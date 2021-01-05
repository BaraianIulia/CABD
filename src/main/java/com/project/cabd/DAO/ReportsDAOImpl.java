package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Animal;
import com.project.cabd.entities.pure.AnimalMeasurement;
import com.project.cabd.entities.pure.Longestmax;
import com.project.cabd.entities.pure.Variation;
import com.project.cabd.sql.utilities.AnimalsSometimeRowMapper;
import com.project.cabd.sql.utilities.LongestmaxMapper;
import com.project.cabd.sql.utilities.SqlVariationReturnType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class ReportsDAOImpl implements ReportsDAO {

    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall readAnimalCurrent;
    private SimpleJdbcCall readAnimalSometime;
    private SimpleJdbcCall readVariation;
    private SimpleJdbcCall readLongest;

    @Autowired
    public ReportsDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @PostConstruct
    private void postConstruct() {
        jdbcTemplate.setResultsMapCaseInsensitive(true);

        readAnimalCurrent = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("RAPOARTE")
                .withFunctionName("current_animal")
                .returningResultSet("animal",
                        BeanPropertyRowMapper.newInstance(Animal.class));

        readAnimalSometime = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("RAPOARTE")
                .withFunctionName("sometime_animal")
                .returningResultSet("animal", new AnimalsSometimeRowMapper());

        readVariation = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("RAPOARTE")
                .withFunctionName("variation_height")
                .returningResultSet("var", new SqlVariationReturnType());

        readLongest = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("RAPOARTE")
                .withFunctionName("longest_maxim_height")
                .returningResultSet("var", new LongestmaxMapper());
    }

    @Override
    public Animal getCurrent(String code) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_code", code);
        Map resultSet = readAnimalCurrent.execute(params);
        List animalsList = (ArrayList) resultSet.get("animal");
        Animal animal = new Animal();
        if (animalsList.size() >= 1) {
            animal = (Animal) animalsList.get(0);
        }

        return animal;
    }

    @Override
    public AnimalMeasurement getSometime(String code, String ddate) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_code", code);
        inParamsMap.put("desired_date", ddate);
        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Map resultSet = readAnimalSometime.execute(in);
        List animalsList = (ArrayList) resultSet.get("animal");
        AnimalMeasurement animal = new AnimalMeasurement();
        if (animalsList.size() >= 1) {
            animal = (AnimalMeasurement) animalsList.get(0);
        }

        return animal;
    }

    @Override
    public List<Variation> getVariatio(String code) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_code", code);
        Map resultSet = readVariation.execute(params);
        List varList = (ArrayList) resultSet.get("var");

        return varList;
    }

    @Override
    public Longestmax getLong(String code) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_code", code);
        Map resultSet = readLongest.execute(params);
        List animalsList = (ArrayList) resultSet.get("var");
        Longestmax l = new Longestmax();
        if (animalsList.size() >= 1) {
            l = (Longestmax) animalsList.get(0);
        }

        return l;
    }
}
