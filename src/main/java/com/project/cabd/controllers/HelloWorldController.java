package com.project.cabd.controllers;

import com.project.cabd.entities.pure.Animal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class HelloWorldController {

    @GetMapping("/")
    public String welcome(@ModelAttribute("initialAnimal") Animal initialAnimal) {
        return "index";
    }

    // create a mapping for "/hello"
    @GetMapping("/hello")
    public String sayHello(Model theModel) {
        theModel.addAttribute("theDate", new java.util.Date());
        return "helloworld";
    }
}
