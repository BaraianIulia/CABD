package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Sector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
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
public class SectorDAOImpl implements SectorDAO {

    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall readSectors;

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
    }

    @Override
    public List<Sector> getSectors() {
        Map resultSet = readSectors.execute(new HashMap<String, Object>(0));
        List sectorsList = (ArrayList) resultSet.get("sectors");

        return sectorsList;
    }

    @Override
    public List<String> getSectorCodes() {
        return null;
    }

    @Override
    public Sector getSector(String code) {
        return null;
    }

    @Override
    public Sector insertSector(Sector sector) {
        return null;
    }

    @Override
    public Sector updateSector(Sector sector) {
        return null;
    }

    @Override
    public Sector deleteSector(String code) {
        return null;
    }
}
