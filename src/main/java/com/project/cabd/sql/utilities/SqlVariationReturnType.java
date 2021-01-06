package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.Variation;
import org.springframework.jdbc.core.RowMapper;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class SqlVariationReturnType implements RowMapper<Variation> {
    @Override
    public Variation mapRow(ResultSet rs, int rowNum) throws SQLException {
        Variation var = new Variation();
        var.setCode(rs.getString("animal_code").toString());
        var.setStartt(new Date(((Timestamp) (rs.getTimestamp("startt"))).getTime()));
        var.setSablon(rs.getString("sablon"));
        if (rs.getString("diff") == null) {
            var.setDiff(0);
        } else {
            var.setDiff(rs.getFloat("diff"));
        }
        var.setHeight(rs.getFloat("height"));
        return var;
    }
}
