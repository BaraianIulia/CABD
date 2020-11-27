package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Zookeeper;
import com.project.cabd.entities.pure.ZookeeperDistribution;
import com.project.cabd.entities.pure.ZookeeperDistributionH;
import com.project.cabd.sql.utilities.SqlZookeeperDistributionReturnType;
import com.project.cabd.sql.utilities.SqlZookeeperReturnType;
import com.project.cabd.sql.utilities.ZookeeperDistributionHRowMapper;
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
import java.sql.SQLException;
import java.sql.Struct;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class ZookeeperDAOImpl implements ZookeeperDAO {

    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall readZookeepers;
    private SimpleJdbcCall readZookeeperCnps;
    private SimpleJdbcCall readZookeeperDistribution;
    private SimpleJdbcCall insertZookeeperJdbc;
    private SimpleJdbcCall updateZookeeperJdbc;
    private SimpleJdbcCall deleteZookeeperJdbc;
    private SimpleJdbcCall insertZookeeperWorkingHoursJdbc;
    private SimpleJdbcCall removeZookeeperWorkingHoursJdbc;
    private SimpleJdbcCall changeZookeeperWorkingProgramJdbc;

    @Autowired
    public ZookeeperDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @PostConstruct
    private void postConstruct() {
        jdbcTemplate.setResultsMapCaseInsensitive(true);

        readZookeepers = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_zookeepers")
                .returningResultSet("zookeepers",
                        BeanPropertyRowMapper.newInstance(Zookeeper.class));

        readZookeeperCnps = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_zookeeper_cnps")
                .returningResultSet("zookeeperCnps",
                        (RowMapper) (resultSet, i) -> resultSet.getString(1));

        readZookeeperDistribution = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withFunctionName("read_zookeeper_distribution")
                .returningResultSet("zookeeperDistribution",
                        new ZookeeperDistributionHRowMapper());

        insertZookeeperJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("insert_zookeeper")
                .declareParameters(
                        new SqlParameter("p_cnp", Types.CHAR),
                        new SqlParameter("p_first_name", Types.VARCHAR),
                        new SqlParameter("p_last_name", Types.VARCHAR),
                        new SqlParameter("p_email", Types.VARCHAR),
                        new SqlParameter("p_phone_number", Types.VARCHAR),
                        new SqlParameter("p_role", Types.VARCHAR),
                        new SqlOutParameter("v_zookeeper_object", OracleTypes.STRUCT, "T_ZOOKEEPER",
                                new SqlZookeeperReturnType()));

        updateZookeeperJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("update_zookeeper")
                .declareParameters(
                        new SqlParameter("p_old_cnp", Types.CHAR),
                        new SqlParameter("p_new_cnp", Types.CHAR),
                        new SqlParameter("p_first_name", Types.VARCHAR),
                        new SqlParameter("p_last_name", Types.VARCHAR),
                        new SqlParameter("p_email", Types.VARCHAR),
                        new SqlParameter("p_phone_number", Types.VARCHAR),
                        new SqlParameter("p_role", Types.VARCHAR),
                        new SqlOutParameter("v_zookeeper_object", OracleTypes.STRUCT, "T_ZOOKEEPER",
                                new SqlZookeeperReturnType()));

        deleteZookeeperJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("delete_zookeeper")
                .declareParameters(
                        new SqlParameter("p_cnp", Types.CHAR),
                        new SqlOutParameter("v_zookeeper_object", OracleTypes.STRUCT, "T_ZOOKEEPER",
                                new SqlZookeeperReturnType()));

        insertZookeeperWorkingHoursJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("insert_zookeeper_working_hours")
                .declareParameters(
                        new SqlParameter("p_zookeeper_cnp", Types.CHAR),
                        new SqlParameter("p_sector_code", Types.CHAR),
                        new SqlParameter("p_start_hour", Types.CHAR),
                        new SqlParameter("p_end_hour", Types.CHAR),
                        new SqlOutParameter("v_zookeeper_distribution_object", OracleTypes.STRUCT, "T_ZOOKEEPER_DISTRIBUTION",
                                new SqlZookeeperDistributionReturnType()));

        removeZookeeperWorkingHoursJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("remove_zookeeper_working_hours")
                .declareParameters(
                        new SqlParameter("p_zookeeper_cnp", Types.CHAR),
                        new SqlParameter("p_sector_code", Types.CHAR),
                        new SqlParameter("p_start_hour", Types.CHAR),
                        new SqlParameter("p_end_hour", Types.CHAR),
                        new SqlOutParameter("v_zookeeper_distribution_object", OracleTypes.STRUCT, "T_ZOOKEEPER_DISTRIBUTION",
                                new SqlZookeeperDistributionReturnType()));

        changeZookeeperWorkingProgramJdbc = new SimpleJdbcCall(jdbcTemplate)
                .withCatalogName("CRUD")
                .withProcedureName("change_zookeeper_working_program")
                .declareParameters(
                        new SqlParameter("p_zookeeper_cnp", Types.CHAR),
                        new SqlParameter("p_old_sector_code", Types.CHAR),
                        new SqlParameter("p_old_start_hour", Types.CHAR),
                        new SqlParameter("p_old_end_hour", Types.CHAR),
                        new SqlParameter("p_new_sector_code", Types.CHAR),
                        new SqlParameter("p_new_start_hour", Types.CHAR),
                        new SqlParameter("p_new_end_hour", Types.CHAR),
                        new SqlOutParameter("v_zookeeper_distribution_object", OracleTypes.STRUCT, "T_ZOOKEEPER_DISTRIBUTION",
                                new SqlZookeeperDistributionReturnType()));
    }

    @Override
    public List<Zookeeper> getZookeepers() {
        Map resultSet = readZookeepers.execute(new HashMap<String, Object>(0));
        List zookeepersList = (ArrayList) resultSet.get("zookeepers");

        return zookeepersList;
    }

    @Override
    public List<String> getZookeeperCnps() {
        Map resultSet = readZookeeperCnps.execute(new HashMap<String, Object>(0));
        List zookeeperCnps = (ArrayList) resultSet.get("zookeeperCnps");

        return zookeeperCnps;
    }

    @Override
    public Zookeeper getZookeeper(String cnp) {
        Zookeeper zookeeper = new Zookeeper();

        try {
            Struct zookeeperOracleObject = (Struct) jdbcTemplate.queryForObject("select CRUD.read_zookeeper(?) from dual", new Object[]{cnp}, Object.class);
            Object[] attrs = zookeeperOracleObject.getAttributes();

            zookeeper = new Zookeeper(attrs[0].toString(), attrs[1].toString(), attrs[2].toString(), attrs[3].toString(), attrs[4].toString(), attrs[5].toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return zookeeper;
    }

    @Override
    public List<ZookeeperDistributionH> getZookeeperDistribution(String cnp) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_cnp", cnp);
        Map resultSet = readZookeeperDistribution.execute(params);
        List zookeeperDistributionList = (ArrayList) resultSet.get("zookeeperDistribution");

        return zookeeperDistributionList;
    }

    @Override
    public Zookeeper insertZookeeper(Zookeeper zookeeper) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_cnp", zookeeper.getCnp());
        inParamsMap.put("p_first_name", zookeeper.getFirstName());
        inParamsMap.put("p_last_name", zookeeper.getLastName());
        inParamsMap.put("p_email", zookeeper.getEmail());
        inParamsMap.put("p_phone_number", zookeeper.getPhoneNumber());
        inParamsMap.put("p_role", zookeeper.getRole());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Zookeeper newZookeeper = insertZookeeperJdbc.executeObject(Zookeeper.class, in);

        return newZookeeper;
    }

    @Override
    public Zookeeper updateZookeeper(String oldCnp, Zookeeper zookeeper) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_old_cnp", oldCnp);
        inParamsMap.put("p_new_cnp", zookeeper.getCnp());
        inParamsMap.put("p_first_name", zookeeper.getFirstName());
        inParamsMap.put("p_last_name", zookeeper.getLastName());
        inParamsMap.put("p_email", zookeeper.getEmail());
        inParamsMap.put("p_phone_number", zookeeper.getPhoneNumber());
        inParamsMap.put("p_role", zookeeper.getRole());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Zookeeper updatedZookeeper = updateZookeeperJdbc.executeObject(Zookeeper.class, in);

        return updatedZookeeper;
    }

    @Override
    public Zookeeper deleteZookeeper(String cnp) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_cnp", cnp);

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        Zookeeper deletedZookeeper = deleteZookeeperJdbc.executeObject(Zookeeper.class, in);

        return deletedZookeeper;
    }

    @Override
    public ZookeeperDistribution insertZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_zookeeper_cnp", zookeeperDistribution.getZookeeperCnp());
        inParamsMap.put("p_sector_code", zookeeperDistribution.getSectorCode());
        inParamsMap.put("p_start_hour", zookeeperDistribution.getWorkingHours().getStartHour());
        inParamsMap.put("p_end_hour", zookeeperDistribution.getWorkingHours().getEndHour());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        ZookeeperDistribution newZookeeperDistribution = insertZookeeperWorkingHoursJdbc.executeObject(ZookeeperDistribution.class, in);

        return newZookeeperDistribution;
    }

    @Override
    public ZookeeperDistribution removeZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_zookeeper_cnp", zookeeperDistribution.getZookeeperCnp());
        inParamsMap.put("p_sector_code", zookeeperDistribution.getSectorCode());
        inParamsMap.put("p_start_hour", zookeeperDistribution.getWorkingHours().getStartHour());
        inParamsMap.put("p_end_hour", zookeeperDistribution.getWorkingHours().getEndHour());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        ZookeeperDistribution removedZookeeperDistribution = removeZookeeperWorkingHoursJdbc.executeObject(ZookeeperDistribution.class, in);

        return removedZookeeperDistribution;
    }

    @Override
    public ZookeeperDistribution changeZookeeperWorkingProgram(ZookeeperDistribution oldZookeeperDistribution, ZookeeperDistribution newZookeeperDistribution) {
        Map<String, Object> inParamsMap = new HashMap<String, Object>();
        inParamsMap.put("p_zookeeper_cnp", oldZookeeperDistribution.getZookeeperCnp());
        inParamsMap.put("p_old_sector_code", oldZookeeperDistribution.getSectorCode());
        inParamsMap.put("p_old_start_hour", oldZookeeperDistribution.getWorkingHours().getStartHour());
        inParamsMap.put("p_old_end_hour", oldZookeeperDistribution.getWorkingHours().getEndHour());
        inParamsMap.put("p_new_sector_code", newZookeeperDistribution.getSectorCode());
        inParamsMap.put("p_new_start_hour", newZookeeperDistribution.getWorkingHours().getStartHour());
        inParamsMap.put("p_new_end_hour", newZookeeperDistribution.getWorkingHours().getEndHour());

        SqlParameterSource in = new MapSqlParameterSource(inParamsMap);

        ZookeeperDistribution theNewZookeeperDistribution = changeZookeeperWorkingProgramJdbc.executeObject(ZookeeperDistribution.class, in);

        return theNewZookeeperDistribution;
    }
}
