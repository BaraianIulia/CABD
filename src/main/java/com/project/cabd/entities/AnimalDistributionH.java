package com.project.cabd.entities;

public class AnimalDistributionH {

    private String animalCode;
    private String sectorCode;
    private Time residingTime;

    protected AnimalDistributionH() {
    }

    protected AnimalDistributionH(String animalCode, String sectorCode, Time residingTime) {
        this.animalCode = animalCode;
        this.sectorCode = sectorCode;
        this.residingTime = residingTime;
    }

    public String getAnimalCode() {
        return animalCode;
    }

    public void setAnimalCode(String animalCode) {
        this.animalCode = animalCode;
    }

    public String getSectorCode() {
        return sectorCode;
    }

    public void setSectorCode(String sectorCode) {
        this.sectorCode = sectorCode;
    }

    public Time getResidingTime() {
        return residingTime;
    }

    public void setResidingTime(Time residingTime) {
        this.residingTime = residingTime;
    }

    @Override
    public String toString() {
        return "AnimalDistributionH{" +
                "animalCode='" + animalCode + '\'' +
                ", sectorCode='" + sectorCode + '\'' +
                ", residingTime=" + residingTime +
                '}';
    }
}
