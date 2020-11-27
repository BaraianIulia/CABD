function insertSectorToBeUpdated(sectorCode, currentSectorName, currentSectorArea, currentSectorCapacity) {
    // we need to fill in the form fields of the sector attributes we want to update
    // (the sector corresponding to the table line on which we press the Edit button)
    document.getElementById("sector-code").defaultValue = sectorCode;
    document.getElementById("update-sector-name").defaultValue = currentSectorName;
    document.getElementById("update-sector-area").defaultValue = currentSectorArea;
    document.getElementById("update-sector-capacity").defaultValue = currentSectorCapacity;
}