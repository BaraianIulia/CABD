package com.project.cabd.controllers;

import com.project.cabd.DAO.ZookeeperDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/zookeepers")
public class ZookeepersController {

    private final ZookeeperDAOImpl zookeeperDAOImpl;

    @Autowired
    public ZookeepersController(ZookeeperDAOImpl zookeeperDAOImpl) {
        this.zookeeperDAOImpl = zookeeperDAOImpl;
    }

    @GetMapping("/zookeepers")
    public String viewZookeepersPage(Model model) {
        return "zookeepers/zookeepers";
    }
}
