package com.project.cabd.entities;

import java.sql.Date;

public class Animal {

    private String code;
    private String name;
    private float weight;
    private float height;
    private Date birthday;
    private String species;
    private String breed;
    private char sex;

    protected Animal() {
    }

    protected Animal(String code, String name, float weight, float height, Date birthday, String species, String breed, char sex) {
        this.code = code;
        this.name = name;
        this.weight = weight;
        this.height = height;
        this.birthday = birthday;
        this.species = species;
        this.breed = breed;
        this.sex = sex;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getSpecies() {
        return species;
    }

    public void setSpecies(String species) {
        this.species = species;
    }

    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public char getSex() {
        return sex;
    }

    public void setSex(char sex) {
        this.sex = sex;
    }

    @Override
    public String toString() {
        return "Animal{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", weight=" + weight +
                ", height=" + height +
                ", birthday=" + birthday +
                ", species='" + species + '\'' +
                ", breed='" + breed + '\'' +
                ", sex=" + sex +
                '}';
    }
}
