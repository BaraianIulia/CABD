function insertOldSector(oldSector) {
    // we need to fill in the form field of the old sector of the animal we want to move
    // (the sector corresponding to the table line on which we press the Move button)
    document.getElementById("old-sector-code").defaultValue = oldSector;
}