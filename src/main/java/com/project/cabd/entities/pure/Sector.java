package com.project.cabd.entities.pure;

public class Sector {

    private String code;
    private String name;
    private float area;
    private int capacity;

    public Sector() {
    }

    public Sector(String code, String name, float area, int capacity) {
        this.code = code;
        this.name = name;
        this.area = area;
        this.capacity = capacity;
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

    public float getArea() {
        return area;
    }

    public void setArea(float area) {
        this.area = area;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    @Override
    public String toString() {
        return "Sector{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", area=" + area +
                ", capacity=" + capacity +
                '}';
    }
}
