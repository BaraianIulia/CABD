package com.project.cabd.sql.utilities;

import com.project.cabd.entities.helper.WorkingHours;
import com.project.cabd.entities.pure.ZookeeperDistribution;
import org.springframework.jdbc.core.SqlReturnType;

import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Struct;

public class SqlZookeeperDistributionReturnType implements SqlReturnType {

    @Override
    public Object getTypeValue(CallableStatement cs, int paramIndex, int sqlType, String typeName) throws SQLException {
        Struct struct = (Struct) cs.getObject(paramIndex);
        Object[] attrs = struct.getAttributes();

        ZookeeperDistribution zookeeperDistribution = new ZookeeperDistribution();

        zookeeperDistribution.setSectorCode(attrs[0].toString());
        zookeeperDistribution.setZookeeperCnp(attrs[1].toString());

        WorkingHours workingHours = new WorkingHours();
        Struct workingHoursOracleObject = (Struct) attrs[2];
        workingHours.setStartHour(workingHoursOracleObject.getAttributes()[0].toString());
        workingHours.setEndHour(workingHoursOracleObject.getAttributes()[1].toString());
        zookeeperDistribution.setWorkingHours(workingHours);

        return zookeeperDistribution;
    }
}
