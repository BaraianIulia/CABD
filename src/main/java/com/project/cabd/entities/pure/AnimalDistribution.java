package com.project.cabd.entities.pure;

public class AnimalDistribution {

    private String animalCode;
    private String sectorCode;

    public AnimalDistribution() {
    }

    public AnimalDistribution(String animalCode, String sectorCode) {
        this.animalCode = animalCode;
        this.sectorCode = sectorCode;
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

    @Override
    public String toString() {
        return "AnimalDistribution{" +
                "animalCode='" + animalCode + '\'' +
                ", sectorCode='" + sectorCode + '\'' +
                '}';
    }
}
