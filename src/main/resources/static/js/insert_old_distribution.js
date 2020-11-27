function insertOldDistribution(oldSector, oldStartHour, oldEndHour) {
    // we need to fill in the form fields of the old distribution of the zookeeper we want its program changed
    // (the distribution corresponding to the table line on which we press the Change Working Program button)
    document.getElementById("old-working-schedule").defaultValue = oldSector.trim() + ": " + oldStartHour + " - " + oldEndHour;
}