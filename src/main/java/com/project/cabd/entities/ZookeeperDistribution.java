package com.project.cabd.entities;

public class ZookeeperDistribution {

    private String sectorCode;
    private String zookeeperCnp;
    private WorkingHours workingHours;

    protected ZookeeperDistribution() {
    }

    protected ZookeeperDistribution(String sectorCode, String zookeeperCnp, WorkingHours workingHours) {
        this.sectorCode = sectorCode;
        this.zookeeperCnp = zookeeperCnp;
        this.workingHours = workingHours;
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

    @Override
    public String toString() {
        return "ZookeeperDistribution{" +
                "sectorCode='" + sectorCode + '\'' +
                ", zookeeperCnp='" + zookeeperCnp + '\'' +
                ", workingHours=" + workingHours +
                '}';
    }
}
