package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.Sector;
import org.springframework.jdbc.core.SqlReturnType;

import java.math.BigDecimal;
import java.sql.*;

public class SqlSectorReturnType implements SqlReturnType {

    @Override
    public Object getTypeValue(CallableStatement cs, int paramIndex, int sqlType, String typeName) throws SQLException {
        Struct struct = (Struct) cs.getObject(paramIndex);
        Object[] attrs = struct.getAttributes();
        Sector sector = new Sector();
        sector.setCode(attrs[0].toString());
        sector.setName(attrs[1].toString());
        sector.setArea(((BigDecimal) attrs[2]).floatValue());
        sector.setCapacity(((BigDecimal) attrs[3]).intValue());
        return sector;
    }
}
