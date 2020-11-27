package com.project.cabd.controllers;

import com.project.cabd.DAO.ZookeeperDAOImpl;
import com.project.cabd.entities.helper.OldNewZookeeperDistribution;
import com.project.cabd.entities.helper.WorkingHours;
import com.project.cabd.entities.pure.Sector;
import com.project.cabd.entities.pure.Zookeeper;
import com.project.cabd.entities.pure.ZookeeperDistribution;
import com.project.cabd.entities.pure.ZookeeperDistributionH;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/zookeepers")
public class ZookeepersController {

    private final ZookeeperDAOImpl zookeeperDAOImpl;

    @Autowired
    public ZookeepersController(ZookeeperDAOImpl zookeeperDAOImpl) {
        this.zookeeperDAOImpl = zookeeperDAOImpl;
    }

    @RequestMapping(value = "/list_zookeepers/{cnp}", method = RequestMethod.GET)
    public String viewZookeepersPage(@ModelAttribute("possibleSectors") List<Sector> possibleSectors, @PathVariable(name = "cnp") String cnp, Model model) {
        // the list of all zookeepers
        List<Zookeeper> zookeepersList = zookeeperDAOImpl.getZookeepers();

        // the current selected zookeeper for displaying his/her distribution
        Zookeeper selectedZookeeper = zookeeperDAOImpl.getZookeeper(cnp);

        // the distribution for the selected zookeeper
        List<ZookeeperDistributionH> selectedZookeeperDistribution = zookeeperDAOImpl.getZookeeperDistribution(cnp);

        model.addAttribute("listZookeepers", zookeepersList);
        model.addAttribute("selectedZookeeper", selectedZookeeper);
        model.addAttribute("initialZookeeperDistribution", selectedZookeeperDistribution);

        // ZookeeperDistribution object used when inserting a new zookeeper's working hours
        ZookeeperDistribution newZookeeperDistribution = new ZookeeperDistribution(null, selectedZookeeper.getCnp(), null);
        model.addAttribute("newZookeeperDistribution", newZookeeperDistribution);

        // OldNewZookeeperDistribution object used when changing a zookeeper's working program
        OldNewZookeeperDistribution oldNewZookeeperDistribution = new OldNewZookeeperDistribution(selectedZookeeper.getCnp(), null, null, null, null);
        model.addAttribute("oldNewZookeeperDistribution", oldNewZookeeperDistribution);

        return "zookeepers/list_zookeepers";
    }

    @GetMapping("/add_zookeeper_form")
    public String showFormForAdd(@ModelAttribute("initialZookeeper") Zookeeper initialZookeeper, Model theModel) {
        // the new zookeeper which will be filled in the form
        Zookeeper newZookeeper = new Zookeeper();

        theModel.addAttribute("newZookeeper", newZookeeper);

        return "/zookeepers/add_zookeeper_form";
    }

    @RequestMapping(value = "/save_zookeeper", method = RequestMethod.POST)
    public String save(@ModelAttribute("newZookeeper") Zookeeper newZookeeper) {
        return "redirect:/zookeepers/list_zookeepers/" + zookeeperDAOImpl.insertZookeeper(newZookeeper).getCnp();
    }

    @GetMapping("/edit_zookeeper/{cnp}")
    public ModelAndView showEditForm(@ModelAttribute("initialZookeeper") Zookeeper initialZookeeper, @PathVariable(name = "cnp") String cnp) {
        ModelAndView MAV = new ModelAndView("zookeepers/edit_zookeeper_form");

        Zookeeper zookeeperToBeUpdated = zookeeperDAOImpl.getZookeeper(cnp);

        MAV.addObject("zookeeperToBeUpdated", zookeeperToBeUpdated);

        return MAV;
    }

    @PostMapping(value = "/update_zookeeper/{oldCnp}")
    public String update(@ModelAttribute("zookeeperWithUpdates") Zookeeper zookeeperWithUpdates, @PathVariable(name = "oldCnp") String oldCnp) {
        return "redirect:/zookeepers/list_zookeepers/" + zookeeperDAOImpl.updateZookeeper(oldCnp, zookeeperWithUpdates).getCnp();
    }

    @GetMapping("/delete_zookeeper/{cnp}")
    public String delete(@PathVariable(name = "cnp") String cnp) {
        zookeeperDAOImpl.deleteZookeeper(cnp);

        Zookeeper initialZookeeper = zookeeperDAOImpl.getZookeeper(zookeeperDAOImpl.getZookeeperCnps().get(0));

        return "redirect:/zookeepers/list_zookeepers/" + initialZookeeper.getCnp();
    }

    @PostMapping(value = "/save_zookeeper_working_hours")
    public String saveDistribution(@ModelAttribute("newZookeeperDistribution") ZookeeperDistribution newZookeeperDistribution) {
        newZookeeperDistribution.setWorkingHours(new WorkingHours(newZookeeperDistribution.getWorkingHours().getStartHour().split(" - ")[0],
                newZookeeperDistribution.getWorkingHours().getStartHour().split(" - ")[1]));
        return "redirect:/zookeepers/list_zookeepers/" + zookeeperDAOImpl.insertZookeeperWorkingHours(newZookeeperDistribution).getZookeeperCnp();
    }

    @GetMapping("/delete_zookeeper_working_hours/zookeeper_cnp/{zookeeperCnp}/sector_code/{sectorCode}/start_hour/{startHour}/end_hour/{endHour}")
    public String removeDistribution(@PathVariable(name = "zookeeperCnp") String zookeeperCnp, @PathVariable(name = "sectorCode") String sectorCode, @PathVariable(name = "startHour") String startHour, @PathVariable(name = "endHour") String endHour) {
        return "redirect:/zookeepers/list_zookeepers/" + zookeeperDAOImpl.removeZookeeperWorkingHours(new ZookeeperDistribution(sectorCode, zookeeperCnp, new WorkingHours(startHour, endHour))).getZookeeperCnp();
    }

    @PostMapping(value = "/change_zookeeper_working_program")
    public String updateDistribution(@ModelAttribute("oldNewZookeeperDistribution") OldNewZookeeperDistribution oldNewZookeeperDistribution) {
        oldNewZookeeperDistribution.setOldSectorCode(String.format("%1$-" + "10" + "s", oldNewZookeeperDistribution.getOldWorkingHours().getStartHour().split(":")[0]));
        oldNewZookeeperDistribution.setOldWorkingHours(new WorkingHours(oldNewZookeeperDistribution.getOldWorkingHours().getStartHour().split(" - ")[0].split(" ")[1],
                oldNewZookeeperDistribution.getOldWorkingHours().getStartHour().split(" - ")[1]));
        oldNewZookeeperDistribution.setNewWorkingHours(new WorkingHours(oldNewZookeeperDistribution.getNewWorkingHours().getStartHour().split(" - ")[0],
                oldNewZookeeperDistribution.getNewWorkingHours().getStartHour().split(" - ")[1]));

        return "redirect:/zookeepers/list_zookeepers/"
                + zookeeperDAOImpl.changeZookeeperWorkingProgram(
                new ZookeeperDistribution(oldNewZookeeperDistribution.getOldSectorCode(), oldNewZookeeperDistribution.getZookeeperCnp(), oldNewZookeeperDistribution.getOldWorkingHours()),
                new ZookeeperDistribution(oldNewZookeeperDistribution.getNewSectorCode(), oldNewZookeeperDistribution.getZookeeperCnp(), oldNewZookeeperDistribution.getNewWorkingHours())).getZookeeperCnp();
    }
}
