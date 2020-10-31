package com.project.cabd.config;

import com.project.cabd.DAO.AnimalDAOImpl;
import com.project.cabd.DAO.SectorDAOImpl;
import com.project.cabd.entities.pure.Animal;
import com.project.cabd.entities.pure.Sector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice("com.project.cabd.controllers")
public class AnnotationAdvice {

    private final AnimalDAOImpl animalDAOImpl;
    private final SectorDAOImpl sectorDAOImpl;

    @Autowired
    public AnnotationAdvice(AnimalDAOImpl animalDAOImpl, SectorDAOImpl sectorDAOImpl) {
        this.animalDAOImpl = animalDAOImpl;
        this.sectorDAOImpl = sectorDAOImpl;
    }

    @ModelAttribute("initialAnimal")
    public Animal getInitialAnimal() {
        return animalDAOImpl.getAnimal(animalDAOImpl.getAnimalCodes().get(0));
    }

    @ModelAttribute("possibleSectors")
    public List<Sector> getAllPossibleSectors() {
        return sectorDAOImpl.getSectors();
    }
}
