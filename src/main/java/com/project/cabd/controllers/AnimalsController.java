package com.project.cabd.controllers;

import com.project.cabd.DAO.AnimalDAOImpl;
import com.project.cabd.entities.Animal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class AnimalsController {

    private final AnimalDAOImpl animalDAOImpl;

    @Autowired
    public AnimalsController(AnimalDAOImpl animalDAOImpl) {
        this.animalDAOImpl = animalDAOImpl;
    }

    @GetMapping("/animals")
    public String viewAnimalsPage(Model model) {
        List<Animal> animalsList = animalDAOImpl.getAnimals();
        model.addAttribute("listAnimals", animalsList);
        return "animals";
    }
}
