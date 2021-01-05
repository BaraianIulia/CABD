package com.project.cabd.entities.pure;

import java.sql.Date;

public class Variation {
    private String code;
    private Date startt;
    private String sablon;
    private float diff;
    private float height;

    public Variation() {
    }

    public Variation(String code, Date startt, String sablon, float diff, float height) {
        this.code = code;
        this.startt = startt;
        this.sablon = sablon;
        this.diff = diff;
        this.height = height;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getStartt() {
        return startt;
    }

    public void setStartt(Date startt) {
        this.startt = startt;
    }

    public String getSablon() {
        return sablon;
    }

    public void setSablon(String sablon) {
        this.sablon = sablon;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public float getDiff() {
        return diff;
    }

    public void setDiff(float diff) {
        this.diff = diff;
    }

    @Override
    public String toString() {
        return "Variation{" +
                "code='" + code + '\'' +
                ", startt='" + startt + '\'' +
                ", sablon=" + sablon +
                ", height=" + height +
                ", diff=" + diff +
                '}';
    }
}
