package com.project.cabd.DAO;

import com.project.cabd.entities.Zookeeper;
import com.project.cabd.entities.ZookeeperDistribution;
import com.project.cabd.entities.ZookeeperDistributionH;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class ZookeeperDAOImpl implements ZookeeperDAO {

    @Override
    public List<Zookeeper> getZookeeepers() {
        return null;
    }

    @Override
    public List<String> getZookeeepersCnps() {
        return null;
    }

    @Override
    public Zookeeper getZookeeeper(String cnp) {
        return null;
    }

    @Override
    public List<ZookeeperDistributionH> getZookeeperDistribution(String cnp) {
        return null;
    }

    @Override
    public Zookeeper insertZookeeper(Zookeeper zookeeper) {
        return null;
    }

    @Override
    public Zookeeper updateZookeeper(Zookeeper zookeeper, String newCnp) {
        return null;
    }

    @Override
    public Zookeeper deleteZookeeper(String cnp) {
        return null;
    }

    @Override
    public ZookeeperDistribution insertZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution) {
        return null;
    }

    @Override
    public ZookeeperDistribution removeZookeeperWorkingHours(ZookeeperDistribution zookeeperDistribution) {
        return null;
    }

    @Override
    public ZookeeperDistribution changeZookeeperWorkingProgram(ZookeeperDistribution oldZookeeperDistribution, ZookeeperDistribution newZookeeperDistribution) {
        return null;
    }
}
