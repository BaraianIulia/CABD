package com.project.cabd.controllers;

import com.project.cabd.DAO.ReportsDAOImpl;
import com.project.cabd.entities.helper.TTime;
import com.project.cabd.entities.pure.Animal;
import com.project.cabd.entities.pure.AnimalMeasurement;
import com.project.cabd.entities.pure.Longestmax;
import com.project.cabd.entities.pure.Variation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

    @GetMapping("/reports/current_state")
    public String viewCurrentStatePage(Model model) {
        return "reports/current_state";
    }

    @RequestMapping(value = "/current_result", method = RequestMethod.GET)
    public String getcurrent(@RequestParam(name = "p_code") String code, Model model) {
        Animal rez = reportsDAOImpl.getCurrent(code);
        model.addAttribute("resultAnimal", rez);
        return "reports/current_state_result";
    }

    @GetMapping("/reports/sometime_state")
    public String viewSometimeStatePage(Model model) {
        return "reports/sometime_state";
    }

    @RequestMapping(value = "/sometime_result", method = RequestMethod.GET)
    public String getsometime(@RequestParam(name = "p_code") String code, @RequestParam(name = "desired_date") String ddate, Model model) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
        Date date2=new Date(System.currentTimeMillis());
        Date date1=new Date();
        try {

            date1 = formatter.parse(ddate);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        System.out.println(date1);
        System.out.println(date2);
        if (date2.before(date1)){
            AnimalMeasurement rez = new AnimalMeasurement();
            rez.setAnimalCode("-");
            TTime t = new TTime(new java.sql.Date(System.currentTimeMillis()), new java.sql.Date(System.currentTimeMillis()));
            rez.setMeasurementDate(t);
            rez.setHeight(0);
            rez.setWeight(0);
            model.addAttribute("resultAnimal", rez);
            model.addAttribute("texterr", "Date cannot be in the future!");
        }
        else {
            AnimalMeasurement rez = reportsDAOImpl.getSometime(code, ddate);
            if (rez.getMeasurementDate() == null) {
                rez.setAnimalCode("-");
                TTime t = new TTime(new java.sql.Date(System.currentTimeMillis()), new java.sql.Date(System.currentTimeMillis()));
                rez.setMeasurementDate(t);
            }
            model.addAttribute("resultAnimal", rez);
            model.addAttribute("texterr", "");
        }
        return "reports/sometime_state_result";
    }

    @GetMapping("/reports/variation")
    public String viewVariationPage(Model model) {
        return "reports/variation";
    }

    @RequestMapping(value = "/var_result", method = RequestMethod.GET)
    public String getvariation(@RequestParam(name = "p_code") String code, Model model) {
        List<Variation> rez = reportsDAOImpl.getVariatio(code);
        model.addAttribute("resultVar", rez);
        List<Date> dated = new ArrayList<Date>();
        List<Float> hei = new ArrayList<Float>();
        for (Variation var : rez) {
            dated.add(var.getStartt());
            hei.add(var.getHeight());
        }
        model.addAttribute("listd", dated);
        model.addAttribute("listh", hei);
        return "reports/variation_result";
    }

    @GetMapping("/reports/longest")
    public String viewLongestPage(Model model) {
        return "reports/longest";
    }

    @RequestMapping(value = "/long_result", method = RequestMethod.GET)
    public String getlongest(@RequestParam(name = "p_code") String code, Model model) {
        Longestmax rez = reportsDAOImpl.getLong(code);
        model.addAttribute("resultVar", rez);
        return "reports/longest_result";
    }
}

