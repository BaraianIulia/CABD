package com.project.cabd.DAO;

import com.project.cabd.entities.Animal;
import com.project.cabd.entities.AnimalDistribution;
import com.project.cabd.entities.AnimalDistributionH;
import com.project.cabd.entities.AnimalMeasurement;

import java.util.List;

public interface AnimalDAO {

    List<Animal> getAnimals();

    Animal getAnimal(String code);

    List<String> getAnimalCodes();

    List<AnimalMeasurement> getAnimalMeasurements(String code);

    List<AnimalDistributionH> getAnimalDistribution(String code);

    Animal insertAnimal(Animal animal);

    Animal updateAnimal(Animal animal);

    Animal deleteAnimal(String code);

    AnimalDistribution letAnimalInSector(AnimalDistribution animalDistribution);

    AnimalDistribution removeAnimalFromSector(AnimalDistribution animalDistribution);

    AnimalDistribution moveAnimal(AnimalDistribution oldAnimalDistribution, AnimalDistribution newAnimalDistribution);
}
