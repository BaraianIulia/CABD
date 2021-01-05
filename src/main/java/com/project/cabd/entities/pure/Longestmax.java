package com.project.cabd.entities.pure;

import java.sql.Date;

public class Longestmax {
    private String code;
    private Date startc;
    private Date endc;
    private float nr_ore;
    private float height;

    public Longestmax() {
    }

    public Longestmax(String code, Date startc, Date endc, float nr_ore, float height) {
        this.code = code;
        this.startc = startc;
        this.endc = endc;
        this.nr_ore = nr_ore;
        this.height = height;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getStartc() {
        return startc;
    }

    public void setStartc(Date startc) {
        this.startc = startc;
    }

    public Date getEndc() {
        return endc;
    }

    public void setEndc(Date endc) {
        this.endc = endc;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public float getNr_ore() {
        return nr_ore;
    }

    public void setNr_ore(float nr_ore) {
        this.nr_ore = nr_ore;
    }

    @Override
    public String toString() {
        return "Longest{" +
                "code='" + code + '\'' +
                ", startc='" + startc + '\'' +
                ", endc=" + endc +
                ", height=" + height +
                ", nr_ore=" + nr_ore +
                '}';
    }
}
