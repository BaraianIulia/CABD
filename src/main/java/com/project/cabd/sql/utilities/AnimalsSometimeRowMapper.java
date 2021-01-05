package com.project.cabd.sql.utilities;

import com.project.cabd.entities.helper.TTime;
import com.project.cabd.entities.pure.AnimalMeasurement;
import org.springframework.jdbc.core.RowMapper;

import java.sql.*;

public class AnimalsSometimeRowMapper implements RowMapper<AnimalMeasurement> {
    @Override
    public AnimalMeasurement mapRow(ResultSet rs, int rowNum) throws SQLException {
        TTime measurementDate = new TTime();
        AnimalMeasurement animalMeasurement = new AnimalMeasurement();
        animalMeasurement.setAnimalCode(rs.getString("animal_code"));
        animalMeasurement.setWeight(rs.getFloat("weight"));
        animalMeasurement.setHeight(rs.getFloat("height"));
        Struct measurementDateOracleObject = (Struct) rs.getObject("measurement_date");
        if (measurementDateOracleObject.getAttributes()[0] == null) {
            measurementDate.setStartTime(new Date(System.currentTimeMillis()));
        } else {
            measurementDate.setStartTime(new Date(((Timestamp) (measurementDateOracleObject.getAttributes()[0])).getTime()));
        }
        if (measurementDateOracleObject.getAttributes()[1] == null) {
            measurementDate.setEndTime(null);
        } else {
            measurementDate.setEndTime(new Date(((Timestamp) (measurementDateOracleObject.getAttributes()[1])).getTime()));
        }
        animalMeasurement.setMeasurementDate(measurementDate);
        return animalMeasurement;
    }
}
