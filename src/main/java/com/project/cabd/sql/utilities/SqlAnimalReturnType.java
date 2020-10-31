package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.Animal;
import org.springframework.jdbc.core.SqlReturnType;

import java.math.BigDecimal;
import java.sql.*;

public class SqlAnimalReturnType implements SqlReturnType {

    @Override
    public Object getTypeValue(CallableStatement cs, int paramIndex, int sqlType, String typeName) throws SQLException {
        Struct struct = (Struct) cs.getObject(paramIndex);
        Object[] attrs = struct.getAttributes();
        Animal animal = new Animal();
        animal.setCode(attrs[0].toString());
        animal.setName(attrs[1].toString());
        animal.setWeight(((BigDecimal) attrs[2]).floatValue());
        animal.setHeight(((BigDecimal) attrs[3]).floatValue());
        animal.setBirthday(new Date(((Timestamp) attrs[4]).getTime()));
        animal.setSpecies(attrs[5].toString());
        animal.setBreed(attrs[6].toString());
        animal.setSex(attrs[7].toString().charAt(0));
        return animal;
    }
}
