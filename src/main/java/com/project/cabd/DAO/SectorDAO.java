package com.project.cabd.DAO;

import com.project.cabd.entities.pure.Sector;

import java.util.List;

public interface SectorDAO {

    List<Sector> getSectors();

    List<String> getSectorCodes();

    Sector getSector(String code);

    Sector insertSector(Sector sector);

    Sector updateSector(Sector sector);

    Sector deleteSector(String code);
}
