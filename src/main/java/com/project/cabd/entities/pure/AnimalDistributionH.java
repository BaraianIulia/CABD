package com.project.cabd.entities.pure;

import com.project.cabd.entities.helper.TTime;

public class AnimalDistributionH {

    private String animalCode;
    private String sectorCode;
    private TTime residingTime;

    public AnimalDistributionH() {
    }

    public AnimalDistributionH(String animalCode, String sectorCode, TTime residingTime) {
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

    public TTime getResidingTime() {
        return residingTime;
    }

    public void setResidingTime(TTime residingTime) {
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
