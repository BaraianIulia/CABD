package com.project.cabd.DAO;

import com.project.cabd.entities.Animal;
import com.project.cabd.entities.AnimalDistribution;
import com.project.cabd.entities.AnimalDistributionH;
import com.project.cabd.entities.AnimalMeasurement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.util.List;

@Repository
@Transactional
public class AnimalDAOImpl implements AnimalDAO {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public AnimalDAOImpl(DataSource dataSource) {
        this.jdbcTemplate =  new JdbcTemplate(dataSource);
    }

    @Override
    public List<Animal> getAnimals() {
        String sql = "select * from animals";

        List<Animal> animalsList = jdbcTemplate.query(sql,
                BeanPropertyRowMapper.newInstance(Animal.class));

        return animalsList;
    }

    @Override
    public Animal getAnimal(String code) {
        return null;
    }

    @Override
    public List<String> getAnimalCodes() {
        return null;
    }

    @Override
    public List<AnimalMeasurement> getAnimalMeasurements(String code) {
        return null;
    }

    @Override
    public List<AnimalDistributionH> getAnimalDistribution(String code) {
        return null;
    }

    @Override
    public Animal insertAnimal(Animal animal) {
        return null;
    }

    @Override
    public Animal updateAnimal(Animal animal) {
        return null;
    }

    @Override
    public Animal deleteAnimal(String code) {
        return null;
    }

    @Override
    public AnimalDistribution letAnimalInSector(AnimalDistribution animalDistribution) {
        return null;
    }

    @Override
    public AnimalDistribution removeAnimalFromSector(AnimalDistribution animalDistribution) {
        return null;
    }

    @Override
    public AnimalDistribution moveAnimal(AnimalDistribution oldAnimalDistribution, AnimalDistribution newAnimalDistribution) {
        return null;
    }
}
