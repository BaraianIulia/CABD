package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Animal;
import com.project.cabd.entities.pure.AnimalMeasurement;
import com.project.cabd.entities.pure.Longestmax;
import com.project.cabd.entities.pure.Variation;

import java.util.List;

public interface ReportsDAO {
    Animal getCurrent(String code);

    AnimalMeasurement getSometime(String code, String ddate);

    List<Variation> getVariation(String code);

    Longestmax getLong(String code);

}
