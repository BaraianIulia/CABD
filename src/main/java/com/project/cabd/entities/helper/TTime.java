package com.project.cabd.entities.helper;

import java.sql.Date;

public class TTime {

    private Date startTime;
    private Date endTime;

    public TTime() {
    }

    public TTime(Date startTime, Date endTime) {
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "Time{" +
                "startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }
}
