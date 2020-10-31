package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Animal;
import com.project.cabd.entities.pure.AnimalDistribution;
import com.project.cabd.entities.pure.AnimalDistributionH;
import com.project.cabd.entities.pure.AnimalMeasurement;
import com.project.cabd.sql.utilities.AnimalDistributionHRowMapper;
import com.project.cabd.sql.utilities.AnimalMeasurementRowMapper;
import com.project.cabd.sql.utilities.SqlAnimalDistributionReturnType;
import com.project.cabd.sql.utilities.SqlAnimalReturnType;
import oracle.jdbc.OracleTypes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.*;
import java.util.*;

@Repository
@Transactional
public class AnimalDAOImpl implements AnimalDAO {

    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall readAnimals;
    private SimpleJdbcCall readAnimalCodes;
    private SimpleJdbcCall readAnimalMeasurements;
    private SimpleJdbcCall readAnimalDistribution;
    private SimpleJdbcCall insertAnimalJdbc;
    private SimpleJdbcCall updateAnimalJdbc;
    private SimpleJdbcCall deleteAnimalJdbc;
    private SimpleJdbcCall letAnimalInSectorJdbc;
    private SimpleJdbcCall removeAnimalFromSectorJdbc;
    private SimpleJdbcCall moveAnimalJdbc;

    @Autowired
    public AnimalDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @PostConstruct
    private void postConstruct() {
        jdbcTemplate.setResultsMapCaseInsensitive(true);

        readAnimals = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_animals")
                .returningResultSet("animals",
                        BeanPropertyRowMapper.newInstance(Animal.class));

        readAnimalCodes = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_animal_codes")
                .returningResultSet("animalCodes",
                        (RowMapper) (resultSet, i) -> resultSet.getString(1));

        readAnimalMeasurements = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_animal_measurements")
                .returningResultSet("animalMeasurements", new AnimalMeasurementRowMapper());

        readAnimalDistribution = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_animal_distribution")
                .returningResultSet("animalDistribution",
                        new AnimalDistributionHRowMapper());

        insertAnimalJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("insert_animal")
                .declareParameters(
                        new SqlParameter("p_name", Types.VARCHAR),
                        new SqlParameter("p_weight", Types.FLOAT),
                        new SqlParameter("p_height", Types.FLOAT),
                        new SqlParameter("p_birthday", Types.DATE),
                        new SqlParameter("p_species", Types.VARCHAR),
                        new SqlParameter("p_breed", Types.VARCHAR),
                        new SqlParameter("p_sex", Types.CHAR),
                        new SqlOutParameter("v_animal_object", OracleTypes.STRUCT, "T_ANIMAL",
                                new SqlAnimalReturnType()));

        updateAnimalJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("update_animal")
                .declareParameters(
                        new SqlParameter("p_code", Types.CHAR),
                        new SqlParameter("p_name", Types.VARCHAR),
                        new SqlParameter("p_weight", Types.FLOAT),
                        new SqlParameter("p_height", Types.FLOAT),
                        new SqlParameter("p_birthday", Types.DATE),
                        new SqlParameter("p_species", Types.VARCHAR),
                        new SqlParameter("p_breed", Types.VARCHAR),
                        new SqlParameter("p_sex", Types.CHAR),
                        new SqlOutParameter("v_animal_object", OracleTypes.STRUCT, "T_ANIMAL",
                                new SqlAnimalReturnType()));

        deleteAnimalJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("delete_animal")
                .declareParameters(
                        new SqlParameter("p_code", Types.CHAR),
                        new SqlOutParameter("v_animal_object", OracleTypes.STRUCT, "T_ANIMAL",
                                new SqlAnimalReturnType()));

        letAnimalInSectorJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("let_animal_in_sector")
                .declareParameters(
                        new SqlParameter("p_animal_code", Types.CHAR),
                        new SqlParameter("p_sector_code", Types.CHAR),
                        new SqlOutParameter("v_animal_distribution_object", OracleTypes.STRUCT, "T_ANIMAL_DISTRIBUTION",
                                new SqlAnimalDistributionReturnType()));

        removeAnimalFromSectorJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("remove_animal_from_sector")
                .declareParameters(
                        new SqlParameter("p_animal_code", Types.CHAR),
                        new SqlParameter("p_old_sector_code", Types.CHAR),
                        new SqlParameter("p_new_sector_code", Types.CHAR),
                        new SqlOutParameter("v_animal_distribution_object", OracleTypes.STRUCT, "T_ANIMAL_DISTRIBUTION",
                                new SqlAnimalDistributionReturnType()));

        moveAnimalJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("move_animal")
                .declareParameters(
                        new SqlParameter("p_animal_code", Types.CHAR),
                        new SqlParameter("p_sector_code", Types.CHAR),
                        new SqlOutParameter("v_animal_distribution_object", OracleTypes.STRUCT, "T_ANIMAL_DISTRIBUTION",
                                new SqlAnimalDistributionReturnType()));
    }

    @Override
    public List<Animal> getAnimals() {
        Map resultSet = readAnimals.execute(new HashMap<String, Object>(0));
        List animalsList = (ArrayList) resultSet.get("animals");

        return animalsList;
    }

    @Override
    public Animal getAnimal(String code) {
        Animal animal = new Animal();

        try {
            Struct animalOracleObject = (Struct) jdbcTemplate.queryForObject("select CRUD.read_animal(?) from dual", new Object[]{code}, Object.class);
            Object[] attrs = animalOracleObject.getAttributes();

            animal = new Animal(attrs[0].toString(), attrs[1].toString(), ((BigDecimal) attrs[2]).floatValue(), ((BigDecimal) attrs[3]).floatValue(),
                    new Date(((Timestamp) attrs[4]).getTime()), attrs[5].toString(), attrs[6].toString(), attrs[7].toString().charAt(0));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return animal;
    }

    @Override
    public List<String> getAnimalCodes() {
        Map resultSet = readAnimalCodes.execute(new HashMap<String, Object>(0));
        List animalCodes = (ArrayList) resultSet.get("animalCodes");

        return animalCodes;
    }

    @Override
    public List<AnimalMeasurement> getAnimalMeasurements(String code) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_code", code);
        Map resultSet = readAnimalMeasurements.execute(params);
        List animalMeasurementsList = (ArrayList) resultSet.get("animalMeasurements");

        return animalMeasurementsList;
    }

    @Override
    public List<AnimalDistributionH> getAnimalDistribution(String code) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_code", code);
        Map resultSet = readAnimalDistribution.execute(params);
        List animalDistributionList = (ArrayList) resultSet.get("animalDistribution");

        return animalDistributionList;
    }

    @Override
    public Animal insertAnimal(Animal animal) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_name", animal.getName());
        inParamsMap.put("p_weight", animal.getWeight());
        inParamsMap.put("p_height", animal.getHeight());
        inParamsMap.put("p_birthday", animal.getBirthday());
        inParamsMap.put("p_species", animal.getSpecies());
        inParamsMap.put("p_breed", animal.getBreed());
        inParamsMap.put("p_sex", String.valueOf(animal.getSex()));

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Animal newAnimal = insertAnimalJdbc.executeObject(Animal.class, in);

        return newAnimal;
    }

    @Override
    public Animal updateAnimal(Animal animal) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_code", animal.getCode());
        inParamsMap.put("p_name", animal.getName());
        inParamsMap.put("p_weight", animal.getWeight());
        inParamsMap.put("p_height", animal.getHeight());
        inParamsMap.put("p_birthday", animal.getBirthday());
        inParamsMap.put("p_species", animal.getSpecies());
        inParamsMap.put("p_breed", animal.getBreed());
        inParamsMap.put("p_sex", String.valueOf(animal.getSex()));

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Animal updatedAnimal = updateAnimalJdbc.executeObject(Animal.class, in);

        return updatedAnimal;
    }

    @Override
    public Animal deleteAnimal(String code) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_code", code);

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Animal deletedAnimal = deleteAnimalJdbc.executeObject(Animal.class, in);

        return deletedAnimal;
    }

    @Override
    public AnimalDistribution letAnimalInSector(AnimalDistribution animalDistribution) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_animal_code", animalDistribution.getAnimalCode());
        inParamsMap.put("p_sector_code", animalDistribution.getSectorCode());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        AnimalDistribution newAnimalDistribution = letAnimalInSectorJdbc.executeObject(AnimalDistribution.class, in);

        return newAnimalDistribution;
    }

    @Override
    public AnimalDistribution removeAnimalFromSector(AnimalDistribution animalDistribution) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_animal_code", animalDistribution.getAnimalCode());
        inParamsMap.put("p_sector_code", animalDistribution.getSectorCode());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        AnimalDistribution removedAnimalDistribution = removeAnimalFromSectorJdbc.executeObject(AnimalDistribution.class, in);

        return removedAnimalDistribution;
    }

    @Override
    public AnimalDistribution moveAnimal(AnimalDistribution oldAnimalDistribution, AnimalDistribution newAnimalDistribution) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_animal_code", oldAnimalDistribution.getAnimalCode());
        inParamsMap.put("p_old_sector_code", oldAnimalDistribution.getSectorCode());
        inParamsMap.put("p_new_sector_code", newAnimalDistribution.getSectorCode());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        AnimalDistribution theNewAnimalDistribution = moveAnimalJdbc.executeObject(AnimalDistribution.class, in);

        return theNewAnimalDistribution;
    }
}
