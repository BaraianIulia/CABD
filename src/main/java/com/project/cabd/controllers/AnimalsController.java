package com.project.cabd.controllers;

import com.project.cabd.DAO.AnimalDAOImpl;
import com.project.cabd.entities.helper.OldNewAnimalDistribution;
import com.project.cabd.entities.pure.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/animals")
public class AnimalsController {

    private final AnimalDAOImpl animalDAOImpl;

    @Autowired
    public AnimalsController(AnimalDAOImpl animalDAOImpl) {
        this.animalDAOImpl = animalDAOImpl;
    }

    @RequestMapping(value = "/list_animals/{code}", method = RequestMethod.GET)
    public String viewAnimalsPage(@ModelAttribute("possibleSectors") List<Sector> possibleSectors, @PathVariable(name = "code") String code, Model model) {
        // the list of all animals
        List<Animal> animalsList = animalDAOImpl.getAnimals();

        // the current selected animal for displaying measurements and distribution
        Animal selectedAnimal = animalDAOImpl.getAnimal(code);

        // the measurements for the selected animal
        List<AnimalMeasurement> selectedAnimalMeasurements = animalDAOImpl.getAnimalMeasurements(code);

        // the distribution for the selected animal
        List<AnimalDistributionH> selectedAnimalDistribution = animalDAOImpl.getAnimalDistribution(code);

        model.addAttribute("listAnimals", animalsList);
        model.addAttribute("selectedAnimal", selectedAnimal);
        model.addAttribute("listAnimalMeasurements", selectedAnimalMeasurements);
        model.addAttribute("initialAnimalDistribution", selectedAnimalDistribution);

        // AnimalDistribution object used when inserting a new animal distribution
        AnimalDistribution newAnimalDistribution = new AnimalDistribution(selectedAnimal.getCode(), null);
        model.addAttribute("newAnimalDistribution", newAnimalDistribution);

        // OldNewAnimalDistribution object used when moving an animal from a current residing sector to another sector
        OldNewAnimalDistribution oldNewAnimalDistribution = new OldNewAnimalDistribution(selectedAnimal.getCode(), null, null);
        model.addAttribute("oldNewAnimalDistribution", oldNewAnimalDistribution);

        return "animals/list_animals";
    }

    @GetMapping("/add_animal_form")
    public String showFormForAdd(@ModelAttribute("initialAnimal") Animal initialAnimal, Model theModel) {
        // the new animal which will be filled in the form
        Animal newAnimal = new Animal();

        theModel.addAttribute("newAnimal", newAnimal);

        return "/animals/add_animal_form";
    }

    @RequestMapping(value = "/save_animal", method = RequestMethod.POST)
    public String save(@ModelAttribute("newAnimal") Animal newAnimal) {
        return "redirect:/animals/list_animals/" + animalDAOImpl.insertAnimal(newAnimal).getCode();
    }

    @GetMapping("/edit_animal/{code}")
    public ModelAndView showEditForm(@ModelAttribute("initialAnimal") Animal initialAnimal, @PathVariable(name = "code") String code) {
        ModelAndView MAV = new ModelAndView("animals/edit_animal_form");

        Animal animalToBeUpdated = animalDAOImpl.getAnimal(code);

        MAV.addObject("animalToBeUpdated", animalToBeUpdated);

        return MAV;
    }

    @PostMapping(value = "/update_animal")
    public String update(@ModelAttribute("animalWithUpdates") Animal animalWithUpdates) {
        return "redirect:/animals/list_animals/" + animalDAOImpl.updateAnimal(animalWithUpdates).getCode();
    }

    @GetMapping("/delete_animal/{code}")
    public String delete(@PathVariable(name = "code") String code) {
        animalDAOImpl.deleteAnimal(code);

        Animal initialAnimal = animalDAOImpl.getAnimal(animalDAOImpl.getAnimalCodes().get(0));

        return "redirect:/animals/list_animals/" + initialAnimal.getCode();
    }

    @PostMapping(value = "/save_animal_sector")
    public String saveDistribution(@ModelAttribute("newAnimalDistribution") AnimalDistribution newAnimalDistribution) {
        return "redirect:/animals/list_animals/" + animalDAOImpl.letAnimalInSector(newAnimalDistribution).getAnimalCode();
    }

    @GetMapping("/delete_animal_sector/animal_code/{animalCode}/sector_code/{sectorCode}")
    public String removeDistribution(@PathVariable(name = "animalCode") String animalCode, @PathVariable(name = "sectorCode") String sectorCode) {
        return "redirect:/animals/list_animals/" + animalDAOImpl.removeAnimalFromSector(new AnimalDistribution(animalCode, sectorCode)).getAnimalCode();
    }

    @PostMapping(value = "/move_animal")
    public String updateDistribution(@ModelAttribute("oldNewAnimalDistribution") OldNewAnimalDistribution oldNewAnimalDistribution) {
        return "redirect:/animals/list_animals/"
                + animalDAOImpl.moveAnimal(new AnimalDistribution(oldNewAnimalDistribution.getAnimalCode(), oldNewAnimalDistribution.getOldSectorCode()),
                new AnimalDistribution(oldNewAnimalDistribution.getAnimalCode(), oldNewAnimalDistribution.getNewSectorCode())).getAnimalCode();
    }
}
