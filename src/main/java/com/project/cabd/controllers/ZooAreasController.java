package com.project.cabd.controllers;

import com.project.cabd.DAO.SectorDAOImpl;
import com.project.cabd.entities.pure.Sector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/areas")
public class ZooAreasController {

    private final SectorDAOImpl sectorDAOImpl;

    @Autowired
    public ZooAreasController(SectorDAOImpl sectorDAOImpl) {
        this.sectorDAOImpl = sectorDAOImpl;
    }

    @GetMapping("/list_zoo_areas")
    public String viewZooAreasPage(Model model) {
        // the list of all sectors
        List<Sector> sectorsList = sectorDAOImpl.getSectors();

        model.addAttribute("listSectors", sectorsList);

        // Sector object used when inserting a new sector
        Sector newSector = new Sector();
        model.addAttribute("newSector", newSector);

        // Sector object used when updating a sector
        Sector sectorWithUpdates = new Sector();
        model.addAttribute("sectorWithUpdates", sectorWithUpdates);

        return "areas/list_zoo_areas";
    }

    @RequestMapping(value = "/save_zoo_area", method = RequestMethod.POST)
    public String save(@ModelAttribute("newSector") Sector newSector) {
        sectorDAOImpl.insertSector(newSector);
        return "redirect:/areas/list_zoo_areas";
    }

    @PostMapping(value = "/update_zoo_area")
    public String update(@ModelAttribute("sectorWithUpdates") Sector sectorWithUpdates) {
        sectorDAOImpl.updateSector(sectorWithUpdates);
        return "redirect:/areas/list_zoo_areas";
    }

    @GetMapping("/delete_zoo_area/{code}")
    public String delete(@PathVariable(name = "code") String code) {
        sectorDAOImpl.deleteSector(code);
        return "redirect:/areas/list_zoo_areas";
    }
}
