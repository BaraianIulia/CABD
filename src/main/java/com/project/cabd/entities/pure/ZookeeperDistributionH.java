package com.project.cabd.entities.pure;

import com.project.cabd.entities.helper.TTime;
import com.project.cabd.entities.helper.WorkingHours;

public class ZookeeperDistributionH {

    private String sectorCode;
    private String zookeeperCnp;
    private WorkingHours workingHours;
    private TTime activityHours;

    public ZookeeperDistributionH() {
    }

    public ZookeeperDistributionH(String sectorCode, String zookeeperCnp, WorkingHours workingHours, TTime activityHours) {
        this.sectorCode = sectorCode;
        this.zookeeperCnp = zookeeperCnp;
        this.workingHours = workingHours;
        this.activityHours = activityHours;
    }

    public String getSectorCode() {
        return sectorCode;
    }

    public void setSectorCode(String sectorCode) {
        this.sectorCode = sectorCode;
    }

    public String getZookeeperCnp() {
        return zookeeperCnp;
    }

    public void setZookeeperCnp(String zookeeperCnp) {
        this.zookeeperCnp = zookeeperCnp;
    }

    public WorkingHours getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(WorkingHours workingHours) {
        this.workingHours = workingHours;
    }

    public TTime getActivityHours() {
        return activityHours;
    }

    public void setActivityHours(TTime activityHours) {
        this.activityHours = activityHours;
    }

    @Override
    public String toString() {
        return "ZookeeperDistributionH{" +
                "sectorCode='" + sectorCode + '\'' +
                ", zookeeperCnp='" + zookeeperCnp + '\'' +
                ", workingHours=" + workingHours +
                ", activityHours=" + activityHours +
                '}';
    }
}
