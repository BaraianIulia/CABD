package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.AnimalDistributionH;
import com.project.cabd.entities.helper.TTime;
import org.springframework.jdbc.core.RowMapper;

import java.sql.*;

public class AnimalDistributionHRowMapper implements RowMapper<AnimalDistributionH> {

    @Override
    public AnimalDistributionH mapRow(ResultSet rs, int rowNum) throws SQLException {
        TTime residingTime = new TTime();
        AnimalDistributionH animalDistributionH = new AnimalDistributionH();
        animalDistributionH.setAnimalCode(rs.getString("animal_code"));
        animalDistributionH.setSectorCode(rs.getString("sector_code"));
        Struct residingTimeOracleObject = (Struct) rs.getObject("residing_time");
        residingTime.setStartTime(new Date(((Timestamp) (residingTimeOracleObject.getAttributes()[0])).getTime()));
        if (residingTimeOracleObject.getAttributes()[1] == null) {
            residingTime.setEndTime(null);
        } else {
            residingTime.setEndTime(new Date(((Timestamp) (residingTimeOracleObject.getAttributes()[1])).getTime()));
        }
        animalDistributionH.setResidingTime(residingTime);
        return animalDistributionH;
    }
}
