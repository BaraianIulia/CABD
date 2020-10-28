package com.project.cabd.entities;

public class WorkingHours {

    private String startHour;
    private String endHour;

    protected WorkingHours() {
    }

    protected WorkingHours(String startHour, String endHour) {
        this.startHour = startHour;
        this.endHour = endHour;
    }

    public String getStartHour() {
        return startHour;
    }

    public void setStartHour(String startHour) {
        this.startHour = startHour;
    }

    public String getEndHour() {
        return endHour;
    }

    public void setEndHour(String endHour) {
        this.endHour = endHour;
    }

    @Override
    public String toString() {
        return "WorkingHours{" +
                "startHour='" + startHour + '\'' +
                ", endHour='" + endHour + '\'' +
                '}';
    }
}
