package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Zookeeper;
import com.project.cabd.entities.pure.ZookeeperDistribution;
import com.project.cabd.entities.pure.ZookeeperDistributionH;

import java.util.List;

public interface ZookeeperDAO {

    List<Zookeeper> getZookeepers();

    List<String> getZookeeperCnps();

    Zookeeper getZookeeper(String cnp);

    List<ZookeeperDistributionH> getZookeeperDistribution(String cnp);

    Zookeeper insertZookeeper(Zookeeper zookeeper);

    Zookeeper updateZookeeper(String oldCnp, Zookeeper zookeeper);

    Zookeeper deleteZookeeper(String cnp);

    ZookeeperDistribution insertZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution);

    ZookeeperDistribution removeZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution);

    ZookeeperDistribution changeZookeeperWorkingProgram(ZookeeperDistribution oldZookeeperDistribution, ZookeeperDistribution newZookeeperDistribution);
}
