package com.project.cabd.controllers;

import com.project.cabd.DAO.SectorDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ZooAreasController {

    private final SectorDAOImpl sectorDAOImpl;

    @Autowired
    public ZooAreasController(SectorDAOImpl sectorDAOImpl) {
        this.sectorDAOImpl = sectorDAOImpl;
    }

    @GetMapping("/zoo_areas")
    public String viewZooAreasPage(Model model) {
        return "zoo_areas";
    }
}
