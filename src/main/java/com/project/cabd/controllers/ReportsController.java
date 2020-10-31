package com.project.cabd.controllers;

import com.project.cabd.DAO.ReportsDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reports")
public class ReportsController {

    private final ReportsDAOImpl reportsDAOImpl;

    @Autowired
    public ReportsController(ReportsDAOImpl reportsDAOImpl) {
        this.reportsDAOImpl = reportsDAOImpl;
    }

    @GetMapping("/reports")
    public String viewReportsPage(Model model) {
        return "reports/reports";
    }
}
