package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.AnimalDistribution;
import org.springframework.jdbc.core.SqlReturnType;

import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Struct;

public class SqlAnimalDistributionReturnType implements SqlReturnType {

    @Override
    public Object getTypeValue(CallableStatement cs, int paramIndex, int sqlType, String typeName) throws SQLException {
        Struct struct = (Struct) cs.getObject(paramIndex);
        Object[] attrs = struct.getAttributes();
        AnimalDistribution animalDistribution = new AnimalDistribution();
        animalDistribution.setAnimalCode(attrs[0].toString());
        animalDistribution.setSectorCode(attrs[1].toString());
        return animalDistribution;
    }
}
