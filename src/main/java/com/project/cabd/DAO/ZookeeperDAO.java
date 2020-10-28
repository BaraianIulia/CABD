package com.project.cabd.DAO;

import com.project.cabd.entities.Zookeeper;
import com.project.cabd.entities.ZookeeperDistribution;
import com.project.cabd.entities.ZookeeperDistributionH;

import java.util.List;

public interface ZookeeperDAO {

    List<Zookeeper> getZookeeepers();

    List<String> getZookeeepersCnps();

    Zookeeper getZookeeeper(String cnp);

    List<ZookeeperDistributionH> getZookeeperDistribution(String cnp);

    Zookeeper insertZookeeper(Zookeeper zookeeper);

    Zookeeper updateZookeeper(Zookeeper zookeeper, String newCnp);

    Zookeeper deleteZookeeper(String cnp);

    ZookeeperDistribution insertZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution);

    ZookeeperDistribution removeZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution);

    ZookeeperDistribution changeZookeeperWorkingProgram(ZookeeperDistribution oldZookeeperDistribution, ZookeeperDistribution newZookeeperDistribution);
}
