package com.project.cabd.entities.helper;

public class OldNewZookeeperDistribution {

    private String zookeeperCnp;
    private String oldSectorCode;
    private WorkingHours oldWorkingHours;
    private String newSectorCode;
    private WorkingHours newWorkingHours;

    public OldNewZookeeperDistribution() {
    }

    public OldNewZookeeperDistribution(String zookeeperCnp, String oldSectorCode, WorkingHours oldWorkingHours, String newSectorCode, WorkingHours newWorkingHours) {
        this.zookeeperCnp = zookeeperCnp;
        this.oldSectorCode = oldSectorCode;
        this.oldWorkingHours = oldWorkingHours;
        this.newSectorCode = newSectorCode;
        this.newWorkingHours = newWorkingHours;
    }

    public String getZookeeperCnp() {
        return zookeeperCnp;
    }

    public void setZookeeperCnp(String zookeeperCnp) {
        this.zookeeperCnp = zookeeperCnp;
    }

    public String getOldSectorCode() {
        return oldSectorCode;
    }

    public void setOldSectorCode(String oldSectorCode) {
        this.oldSectorCode = oldSectorCode;
    }

    public WorkingHours getOldWorkingHours() {
        return oldWorkingHours;
    }

    public void setOldWorkingHours(WorkingHours oldWorkingHours) {
        this.oldWorkingHours = oldWorkingHours;
    }

    public String getNewSectorCode() {
        return newSectorCode;
    }

    public void setNewSectorCode(String newSectorCode) {
        this.newSectorCode = newSectorCode;
    }

    public WorkingHours getNewWorkingHours() {
        return newWorkingHours;
    }

    public void setNewWorkingHours(WorkingHours newWorkingHours) {
        this.newWorkingHours = newWorkingHours;
    }

    public String getOldWorkingInterval() {
        return this.getOldSectorCode() + ": " + this.getOldWorkingHours().getStartHour() + " - " + this.getOldWorkingHours().getEndHour();
    }

    @Override
    public String toString() {
        return "OldNewZookeeperDistribution{" +
                "zookeeperCnp='" + zookeeperCnp + '\'' +
                ", oldSectorCode='" + oldSectorCode + '\'' +
                ", oldWorkingHours=" + oldWorkingHours +
                ", newSectorCode='" + newSectorCode + '\'' +
                ", newWorkingHours=" + newWorkingHours +
                '}';
    }
}
