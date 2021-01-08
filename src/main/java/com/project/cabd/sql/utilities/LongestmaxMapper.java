package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.Longestmax;
import org.springframework.jdbc.core.RowMapper;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class LongestmaxMapper implements RowMapper<Longestmax> {
    @Override
    public Longestmax mapRow(ResultSet rs, int rowNum) throws SQLException {
        Longestmax var = new Longestmax();
        var.setCode(rs.getString("animal_code").toString());
        var.setStartc(new Date(((Timestamp) (rs.getTimestamp("startc"))).getTime()));
        var.setEndc(new Date(((Timestamp) (rs.getTimestamp("endc"))).getTime()));
        var.setNr_ore(rs.getFloat("nr_ore"));
        var.setHeight(rs.getFloat("height"));
        return var;
    }
}
