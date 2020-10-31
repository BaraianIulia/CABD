package com.project.cabd.entities.helper;

public class OldNewAnimalDistribution {

    private String animalCode;
    private String oldSectorCode;
    private String newSectorCode;

    public OldNewAnimalDistribution() {
    }

    public OldNewAnimalDistribution(String animalCode, String oldSectorCode, String newSectorCode) {
        this.animalCode = animalCode;
        this.oldSectorCode = oldSectorCode;
        this.newSectorCode = newSectorCode;
    }

    public String getAnimalCode() {
        return animalCode;
    }

    public void setAnimalCode(String animalCode) {
        this.animalCode = animalCode;
    }

    public String getOldSectorCode() {
        return oldSectorCode;
    }

    public void setOldSectorCode(String oldSectorCode) {
        this.oldSectorCode = oldSectorCode;
    }

    public String getNewSectorCode() {
        return newSectorCode;
    }

    public void setNewSectorCode(String newSectorCode) {
        this.newSectorCode = newSectorCode;
    }

    @Override
    public String toString() {
        return "OldNewAnimalDistribution{" +
                "animalCode='" + animalCode + '\'' +
                ", oldSectorCode='" + oldSectorCode + '\'' +
                ", newSectorCode='" + newSectorCode + '\'' +
                '}';
    }
}
