package com.project.cabd.DAO;

import com.project.cabd.entities.Sector;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class SectorDAOImpl implements SectorDAO {

    @Override
    public List<Sector> getSectors() {
        return null;
    }

    @Override
    public List<String> getSectorCodes() {
        return null;
    }

    @Override
    public Sector getSector(String code) {
        return null;
    }

    @Override
    public Sector insertSector(Sector sector) {
        return null;
    }

    @Override
    public Sector updateSector(Sector sector) {
        return null;
    }

    @Override
    public Sector deleteSector(String code) {
        return null;
    }
}
