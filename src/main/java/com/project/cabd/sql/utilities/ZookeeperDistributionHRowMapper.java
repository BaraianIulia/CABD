package com.project.cabd.sql.utilities;

import com.project.cabd.entities.helper.TTime;
import com.project.cabd.entities.helper.WorkingHours;
import com.project.cabd.entities.pure.ZookeeperDistributionH;
import org.springframework.jdbc.core.RowMapper;

import java.sql.*;

public class ZookeeperDistributionHRowMapper implements RowMapper<ZookeeperDistributionH> {

    @Override
    public ZookeeperDistributionH mapRow(ResultSet rs, int rowNum) throws SQLException {
        TTime activityTime = new TTime();
        WorkingHours workingHours = new WorkingHours();

        ZookeeperDistributionH zookeeperDistributionH = new ZookeeperDistributionH();

        zookeeperDistributionH.setSectorCode(rs.getString("sector_code"));
        zookeeperDistributionH.setZookeeperCnp(rs.getString("zookeeper_cnp"));

        Struct workingHoursOracleObject = (Struct) rs.getObject("working_hours");
        workingHours.setStartHour(workingHoursOracleObject.getAttributes()[0].toString());
        workingHours.setEndHour(workingHoursOracleObject.getAttributes()[1].toString());
        zookeeperDistributionH.setWorkingHours(workingHours);

        Struct activityTimeOracleObject = (Struct) rs.getObject("activity_time");
        activityTime.setStartTime(new Date(((Timestamp) (activityTimeOracleObject.getAttributes()[0])).getTime()));
        if (activityTimeOracleObject.getAttributes()[1] == null) {
            activityTime.setEndTime(null);
        } else {
            activityTime.setEndTime(new Date(((Timestamp) (activityTimeOracleObject.getAttributes()[1])).getTime()));
        }
        zookeeperDistributionH.setActivityTime(activityTime);

        return zookeeperDistributionH;
    }
}
