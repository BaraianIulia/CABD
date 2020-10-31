package com.project.cabd.entities.pure;

import com.project.cabd.entities.helper.TTime;

public class AnimalMeasurement {

    private String animalCode;
    private float weight;
    private float height;
    private TTime measurementDate;

    public AnimalMeasurement() {
    }

    public AnimalMeasurement(String animalCode, float weight, float height, TTime measurementDate) {
        this.animalCode = animalCode;
        this.weight = weight;
        this.height = height;
        this.measurementDate = measurementDate;
    }

    public String getAnimalCode() {
        return animalCode;
    }

    public void setAnimalCode(String animalCode) {
        this.animalCode = animalCode;
    }

    public float getWeight() {
        return weight;
    }

    public void setWeight(float weight) {
        this.weight = weight;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public TTime getMeasurementDate() {
        return measurementDate;
    }

    public void setMeasurementDate(TTime measurementDate) {
        this.measurementDate = measurementDate;
    }

    @Override
    public String toString() {
        return "AnimalMeasurement{" +
                "animalCode='" + animalCode + '\'' +
                ", weight=" + weight +
                ", height=" + height +
                ", measurementDate=" + measurementDate +
                '}';
    }
}
