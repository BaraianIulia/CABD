package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Sector;
import com.project.cabd.sql.utilities.SqlSectorReturnType;
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
import java.sql.SQLException;
import java.sql.Struct;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class SectorDAOImpl implements SectorDAO {

    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall readSectors;
    private SimpleJdbcCall readSectorCodes;
    private SimpleJdbcCall insertSectorJdbc;
    private SimpleJdbcCall updateSectorJdbc;
    private SimpleJdbcCall deleteSectorJdbc;

    @Autowired
    public SectorDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @PostConstruct
    private void postConstruct() {
        jdbcTemplate.setResultsMapCaseInsensitive(true);

        readSectors = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_sectors")
                .returningResultSet("sectors",
                        BeanPropertyRowMapper.newInstance(Sector.class));

        readSectorCodes = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_sector_codes")
                .returningResultSet("sectorCodes",
                        (RowMapper) (resultSet, i) -> resultSet.getString(1));

        insertSectorJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("insert_sector")
                .declareParameters(
                        new SqlParameter("p_name", Types.VARCHAR),
                        new SqlParameter("p_area", Types.FLOAT),
                        new SqlParameter("p_capacity", Types.INTEGER),
                        new SqlOutParameter("v_sector_object", OracleTypes.STRUCT, "T_SECTOR",
                                new SqlSectorReturnType()));

        updateSectorJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("update_sector")
                .declareParameters(
                        new SqlParameter("p_code", Types.CHAR),
                        new SqlParameter("p_name", Types.VARCHAR),
                        new SqlParameter("p_area", Types.FLOAT),
                        new SqlParameter("p_capacity", Types.INTEGER),
                        new SqlOutParameter("v_sector_object", OracleTypes.STRUCT, "T_SECTOR",
                                new SqlSectorReturnType()));

        deleteSectorJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("delete_sector")
                .declareParameters(
                        new SqlParameter("p_code", Types.CHAR),
                        new SqlOutParameter("v_sector_object", OracleTypes.STRUCT, "T_SECTOR",
                                new SqlSectorReturnType()));
    }

    @Override
    public List<Sector> getSectors() {
        Map resultSet = readSectors.execute(new HashMap<String, Object>(0));
        List sectorsList = (ArrayList) resultSet.get("sectors");

        return sectorsList;
    }

    @Override
    public List<String> getSectorCodes() {
        Map resultSet = readSectorCodes.execute(new HashMap<String, Object>(0));
        List sectorCodes = (ArrayList) resultSet.get("sectorCodes");

        return sectorCodes;
    }

    @Override
    public Sector getSector(String code) {
        Sector sector = new Sector();

        try {
            Struct sectorOracleObject = (Struct) jdbcTemplate.queryForObject("select CRUD.read_sector(?) from dual", new Object[]{code}, Object.class);
            Object[] attrs = sectorOracleObject.getAttributes();

            sector = new Sector(attrs[0].toString(), attrs[1].toString(), ((BigDecimal) attrs[2]).floatValue(), ((BigDecimal) attrs[3]).intValue());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return sector;
    }

    @Override
    public Sector insertSector(Sector sector) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_name", sector.getName());
        inParamsMap.put("p_area", sector.getArea());
        inParamsMap.put("p_capacity", sector.getCapacity());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Sector newSector = insertSectorJdbc.executeObject(Sector.class, in);

        return newSector;
    }

    @Override
    public Sector updateSector(Sector sector) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_code", sector.getCode());
        inParamsMap.put("p_name", sector.getName());
        inParamsMap.put("p_area", sector.getArea());
        inParamsMap.put("p_capacity", sector.getCapacity());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Sector updatedSector = updateSectorJdbc.executeObject(Sector.class, in);

        return updatedSector;
    }

    @Override
    public Sector deleteSector(String code) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_code", code);

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Sector deletedSector = deleteSectorJdbc.executeObject(Sector.class, in);

        return deletedSector;
    }
}
