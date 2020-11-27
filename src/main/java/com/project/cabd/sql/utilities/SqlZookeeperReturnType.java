package com.project.cabd.sql.utilities;

import com.project.cabd.entities.pure.Zookeeper;
import org.springframework.jdbc.core.SqlReturnType;

import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Struct;

public class SqlZookeeperReturnType implements SqlReturnType {

    @Override
    public Object getTypeValue(CallableStatement cs, int paramIndex, int sqlType, String typeName) throws SQLException {
        Struct struct = (Struct) cs.getObject(paramIndex);
        Object[] attrs = struct.getAttributes();
        Zookeeper zookeeper = new Zookeeper();
        zookeeper.setCnp(attrs[0].toString());
        zookeeper.setFirstName(attrs[1].toString());
        zookeeper.setLastName(attrs[2].toString());
        zookeeper.setEmail(attrs[3].toString());
        zookeeper.setPhoneNumber(attrs[4].toString());
        zookeeper.setRole(attrs[5].toString());
        return zookeeper;
    }
}
