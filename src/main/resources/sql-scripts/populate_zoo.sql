set serveroutput on
/

create type t_sectors is table of char(10);
/
create type t_sectors_working_hours is table of char(20);
/
create type t_residing_intervals is table of t_time;
/
create type t_dates is table of date;
/

/* populate SECTORS table */
insert into sectors values('S1', 'Pool Area', 654.23 * 10, 200 * 10);
insert into sectors values('S2', 'Aquarium', 458.16 * 10, 500 * 10);
insert into sectors values('S3', 'Cave Area', 375.50 * 10, 100 * 10);
insert into sectors values('S4', 'Tropical Pavilion', 721.75 * 10, 350 * 10);
insert into sectors values('S5', 'Botanical Garden', 567.25 * 10, 225 * 10);
insert into sectors values('S6', 'Safari Park', 523.35 * 10, 200 * 10);
insert into sectors values('S7', 'Polar Area', 127.75 * 10, 50 * 10);
insert into sectors values('S8', 'Exotic Pasture', 975.85 * 10, 500 * 10);
insert into sectors values('S9', 'Underground', 274.12 * 10, 400 * 10);
insert into sectors values('S10', 'Oak Forest', 833.23 * 10, 400 * 10);


/* populate ANIMALS table */
declare
    V_NR_MAMMALS integer := 1000;
    V_CODE_PREFIX char := 'A';
    V_MAMMALS_INITIAL_ID integer := -1;
    V_NR_REPTILES integer := 500;
    V_REPTILES_INITIAL_ID integer := 1999;
    V_NR_BIRDS integer := 750;
    V_BIRDS_INITIAL_ID integer := 2999;
    V_NR_AMPHIBIANS integer := 375;
    V_AMPHIBIANS_INITIAL_ID integer := 4999;
    V_NR_FISH integer := 375;
    V_FISH_INITIAL_ID integer := 5999;
    
    V_BIRTHDAY_INTERVAL_START date := date '2010-01-01';
    V_BIRTHDAY_INTERVAL_END date := date '2020-10-16';
    
    V_MONKEY_MIN_WEIGHT float := 30.00;
    V_MONKEY_MAX_WEIGHT float := 100.01;
    V_MONKEY_MIN_HEIGHT float := 75.00;
    V_MONKEY_MAX_HEIGHT float := 180.01;
    V_BIG_CARNIVORE_MIN_WEIGHT float := 50.00;
    V_BIG_CARNIVORE_MAX_WEIGHT float := 450.01;
    V_BIG_CARNIVORE_MIN_HEIGHT float := 75.00;
    V_BIG_CARNIVORE_MAX_HEIGHT float := 150.01;
    V_HERBIVOROUS_MIN_WEIGHT float := 50.00;
    V_HERBIVOROUS_MAX_WEIGHT float := 300.01;
    V_HERBIVOROUS_MIN_HEIGHT float := 75.00;
    V_HERBIVOROUS_MAX_HEIGHT float := 200.01;
    V_SMALL_CARNIVORE_MIN_WEIGHT float := 50.00;
    V_SMALL_CARNIVORE_MAX_WEIGHT float := 200.01;
    V_SMALL_CARNIVORE_MIN_HEIGHT float := 30.00;
    V_SMALL_CARNIVORE_MAX_HEIGHT float := 100.01;
    V_ELEPHANT_MIN_WEIGHT float := 3000.00;
    V_ELEPHANT_MAX_WEIGHT float := 6000.00;
    V_ELEPHANT_MIN_HEIGHT float := 200.00;
    V_ELEPHANT_MAX_HEIGHT float := 400.01;
    V_HIPPOPOTAMUS_MIN_WEIGHT float := 3000.00;
    V_HIPPOPOTAMUS_MAX_WEIGHT float := 6000.01;
    V_HIPPOPOTAMUS_MIN_HEIGHT float := 75.00;
    V_HIPPOPOTAMUS_MAX_HEIGHT float := 125.01;
    V_MANATEE_MIN_WEIGHT float := 100.00;
    V_MANATEE_MAX_WEIGHT float := 200.01;
    V_MANATEE_MIN_HEIGHT float := 50.00;
    V_MANATEE_MAX_HEIGHT float := 75.01;
    V_GIRAFFE_MIN_WEIGHT float := 400.00;
    V_GIRAFFE_MAX_WEIGHT float := 750.01;
    V_GIRAFFE_MIN_HEIGHT float := 300.00;
    V_GIRAFFE_MAX_HEIGHT float := 400.01;
    V_KANGAROO_MIN_WEIGHT float := 40.00;
    V_KANGAROO_MAX_WEIGHT float := 75.01;
    V_KANGAROO_MIN_HEIGHT float := 150.00;
    V_KANGAROO_MAX_HEIGHT float := 200.01;
    
    V_CROCODILE_MIN_WEIGHT float := 75.00;
    V_CROCODILE_MAX_WEIGHT float := 150.01;
    V_CROCODILE_MIN_HEIGHT float := 125.00;
    V_CROCODILE_MAX_HEIGHT float := 200.01;
    V_LIZARD_MIN_WEIGHT float := 30.00;
    V_LIZARD_MAX_WEIGHT float := 50.01;
    V_LIZARD_MIN_HEIGHT float := 75.00;
    V_LIZARD_MAX_HEIGHT float := 150.01;
    V_SNAKE_MIN_WEIGHT float := 30.00;
    V_SNAKE_MAX_WEIGHT float := 80.01;
    V_SNAKE_MIN_HEIGHT float := 300.00;
    V_SNAKE_MAX_HEIGHT float := 900.01;
    
    V_SMALL_BIRD_MIN_WEIGHT float := 5.00;
    V_SMALL_BIRD_MAX_WEIGHT float := 15.01;
    V_SMALL_BIRD_MIN_HEIGHT float := 25.00;
    V_SMALL_BIRD_MAX_HEIGHT float := 50.01;
    V_MEDIUM_BIRD_MIN_WEIGHT float := 10.00;
    V_MEDIUM_BIRD_MAX_WEIGHT float := 20.01;
    V_MEDIUM_BIRD_MIN_HEIGHT float := 50.00;
    V_MEDIUM_BIRD_MAX_HEIGHT float := 80.01;
    V_LARGE_BIRD_MIN_WEIGHT float := 15.00;
    V_LARGE_BIRD_MAX_WEIGHT float := 30.01;
    V_LARGE_BIRD_MIN_HEIGHT float := 80.00;
    V_LARGE_BIRD_MAX_HEIGHT float := 180.01;
    V_PENGUIN_MIN_WEIGHT float := 20.00;
    V_PENGUIN_MAX_WEIGHT float := 40.01;
    V_PENGUIN_MIN_HEIGHT float := 75.00;
    V_PENGUIN_MAX_HEIGHT float := 125.01;
    
    V_FROG_MIN_WEIGHT float := 3.00;
    V_FROG_MAX_WEIGHT float := 7.51;
    V_FROG_MIN_HEIGHT float := 5.00;
    V_FROG_MAX_HEIGHT float := 30.01;
    V_SALAMANDER_MIN_WEIGHT float := 30.00;
    V_SALAMANDER_MAX_WEIGHT float := 50.01;
    V_SALAMANDER_MIN_HEIGHT float := 75.00;
    V_SALAMANDER_MAX_HEIGHT float := 150.01;
    
    V_FISH_MIN_WEIGHT float := 5.00;
    V_FISH_MAX_WEIGHT float := 12.01;
    V_FISH_MIN_HEIGHT float := 20.00;
    V_FISH_MAX_HEIGHT float := 75.01;
    
    type t_names is table of varchar(50);
    type t_breeds is table of varchar(100);
    
    v_code char(10);
    v_code_counter integer := V_MAMMALS_INITIAL_ID;
    
    v_animal_names_males t_names := t_names('Coco', 'Max', 'Buddy', 'Angel', 'Harley', 'Charlie', 'Pepper', 'Shadow', 'Jack', 'Milo', 'Rocky', 'Oliver', 'Ruby', 'Duke', 'Ginger', 
            'Baby', 'Bear', 'Bailey', 'Marley', 'Oscar', 'Peanut', 'Lucky', 'Cooper', 'Dexter', 'Loki', 'Oreo', 'Sammy', 'Tucker', 'Leo', 'Louie', 'Romeo', 'Sam', 'Bandit', 'Finn', 
            'Jake', 'Jasper', 'Kiwi', 'Scout', 'Sunny', 'Teddy', 'Toby', 'Willow', 'Bruce', 'Diesel', 'Gizmo', 'Jax', 'Murphy', 'Piper', 'Simba', 'Spike', 'Zeus', 'Ziggy', 'Ace', 
            'Apollo', 'Buster', 'Cookie', 'Frankie', 'George', 'Henry', 'Jackson', 'Lulu', 'Riley', 'Thor', 'Barney', 'Bentley', 'Bruno', 'Hank', 'Hazel');
    v_animal_names_females t_names := t_names('Bella', 'Daisy', 'Lola', 'Angel', 'Luna', 'Lucy', 'Harley', 'Gracie', 'Rocky', 'Sadie', 'Stella', 'Nala', 'Penny', 'Ruby', 'Chloe', 'Cleo', 
            'Molly', 'Sophie', 'Baby', 'Maggie', 'Abby', 'Oreo', 'Sammy', 'Belle', 'Sasha', 'Emma', 'Kiwi', 'Mia', 'Sunny', 'Willow', 'Ariel', 'Athena', 'Dakota', 'Honey', 'Lady', 'Minnie', 
            'Rosie', 'Sunshine', 'Ace', 'Izzy', 'Lulu', 'Zoe', 'Zoey', 'Dixie', 'Jade');
    v_animal_name varchar(50);
    v_nr_animal_names_males number(3) := v_animal_names_males.count;
    v_nr_animal_names_females number(3) := v_animal_names_females.count;
    v_random_index number(3);
    
    v_weight number(6, 2);
    v_height number(5, 2);
    
    v_birthday date;
    
    v_species varchar2(30);
    
    v_breed varchar2(30);
    v_mammal_breeds t_breeds := t_breeds('angolan colobus monkey', 'black howler monkey', 'bonobo monkey', 'buff-cheeked gibbon', 
            'siamang monkey', 'sumatran orangutan', 'western lowland gorilla', 'white-handed gibbon', 'white-faced saki monkey', 'two-toed sloth', 
            'african lion', 'andean bear', 'polar bear', 'clouded leopard', 'cougar', 'malayan tiger', 'plains zebra', 'eastern bongo', 'impala', 
            'lesser kudu', 'llama', 'nigerian dwarf goat', 'okapi', 'gazelle', 'alpaca', 'african painted dog', 'arctic fox', 'black-footed cat', 
            'bobcat', 'brazilian porcupine', 'cape porcupine', 'cheetah', 'mexican wolf', 'red panda', 'snow leopard', 'asian elephant', 'hippopotamus', 
            'florida manatee', 'masai giraffe', 'kangaroo');
    v_nr_mammal_breeds number(2) := v_mammal_breeds.count;
    v_reptile_breeds t_breeds := t_breeds('american alligator', 'american crocodile', 'chinese alligator', 'alligator snapping turtle', 
        'bearded dragon', 'green basilisk', 'chuckwalla', 'galapagos tortoise', 'komodo dragon', 'lace monitor', 'aruba island rattlesnake', 
        'burmese python', 'emerald tree boa', 'indochinese spitting cobra', 'yellow rat snake');
    v_nr_reptile_breeds number(2) := v_reptile_breeds.count;
    v_bird_breeds t_breeds := t_breeds('barn owl', 'blue and gold macaw', 'blue-crowned motmot', 'capuchinbird', 'crested coua', 
            'eastern screech owl', 'fairy bluebird', 'inca tern', 'kea', 'scarlet ibis', 'bald eagle', 'lapped-faced vulture', 'trumpeter swan', 
            'magpie goose', 'greater flamingo', 'ostrich', 'saddlebill stork', 'african penguin', 'king penguin', 'magellanic penguin');
    v_nr_bird_breeds number(2) := v_bird_breeds.count;
    v_amphibian_breeds t_breeds := t_breeds('amazon milk frog', 'dyeing poison dart frog', 'fire-bellied newt', 'golden poison dart frog', 
            'ornate horned frog', 'hellbender', 'japanese giant salamader');
    v_nr_amphibian_breeds number(2) := v_amphibian_breeds.count;
    v_fish_breeds t_breeds := t_breeds('azureus cichlid', 'alligator gar', 'longnose gar', 'mosquitofish', 'red piranha', 'redear sunfish');
    v_nr_fish_breeds number(2) := v_fish_breeds.count;
    
    v_sex char(1);
begin
    for v_counter in 1..V_NR_MAMMALS loop
        v_code_counter := v_code_counter + 1;
        v_code := V_CODE_PREFIX || to_char(v_code_counter);
        
        select decode(trunc(sys.dbms_random.value(0, 2)), 0, 'f', 'm') into v_sex from dual;
        if v_sex = 'm' then
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_males + 1));
            v_animal_name := v_animal_names_males(v_random_index);
        else
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_females + 1));
            v_animal_name := v_animal_names_females(v_random_index);
        end if;
        
        v_species := 'mammal';
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_mammal_breeds + 1));
        v_breed := v_mammal_breeds(v_random_index);
        
        if v_breed in ('angolan colobus monkey', 'black howler monkey', 'bonobo monkey', 'buff-cheeked gibbon', 
            'siamang monkey', 'sumatran orangutan', 'western lowland gorilla', 'white-handed gibbon', 'white-faced saki monkey', 'two-toed sloth') then
            v_weight := trunc(dbms_random.value(V_MONKEY_MIN_WEIGHT, V_MONKEY_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_MONKEY_MIN_HEIGHT, V_MONKEY_MAX_HEIGHT), 2);
        elsif v_breed in ('african lion', 'andean bear', 'polar bear', 'clouded leopard', 'cougar', 'malayan tiger') then
            v_weight := trunc(dbms_random.value(V_BIG_CARNIVORE_MIN_WEIGHT, V_BIG_CARNIVORE_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_BIG_CARNIVORE_MIN_HEIGHT, V_BIG_CARNIVORE_MAX_HEIGHT), 2);
        elsif v_breed in ('plains zebra', 'eastern bongo', 'impala', 
            'lesser kudu', 'llama', 'nigerian dwarf goat', 'okapi', 'gazelle', 'alpaca') then
            v_weight := trunc(dbms_random.value(V_HERBIVOROUS_MIN_WEIGHT, V_HERBIVOROUS_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_HERBIVOROUS_MIN_HEIGHT, V_HERBIVOROUS_MAX_HEIGHT), 2);
        elsif v_breed in ('african painted dog', 'arctic fox', 'black-footed cat', 
            'bobcat', 'brazilian porcupine', 'cape porcupine', 'cheetah', 'mexican wolf', 'red panda', 'snow leopard') then
            v_weight := trunc(dbms_random.value(V_SMALL_CARNIVORE_MIN_WEIGHT, V_SMALL_CARNIVORE_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_SMALL_CARNIVORE_MIN_HEIGHT, V_SMALL_CARNIVORE_MAX_HEIGHT), 2);
        elsif v_breed in ('asian elephant') then
            v_weight := trunc(dbms_random.value(V_ELEPHANT_MIN_WEIGHT, V_ELEPHANT_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_ELEPHANT_MIN_HEIGHT, V_ELEPHANT_MAX_HEIGHT), 2);
        elsif v_breed in ('hippopotamus') then
            v_weight := trunc(dbms_random.value(V_HIPPOPOTAMUS_MIN_WEIGHT, V_HIPPOPOTAMUS_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_HIPPOPOTAMUS_MIN_HEIGHT, V_HIPPOPOTAMUS_MAX_HEIGHT), 2);
        elsif v_breed in ('florida manatee') then
            v_weight := trunc(dbms_random.value(V_MANATEE_MIN_WEIGHT, V_MANATEE_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_MANATEE_MIN_HEIGHT, V_MANATEE_MAX_HEIGHT), 2);
        elsif v_breed in ('masai giraffe') then
            v_weight := trunc(dbms_random.value(V_GIRAFFE_MIN_WEIGHT, V_GIRAFFE_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_GIRAFFE_MIN_HEIGHT, V_GIRAFFE_MAX_HEIGHT), 2);
        else
            v_weight := trunc(dbms_random.value(V_KANGAROO_MIN_WEIGHT, V_KANGAROO_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_KANGAROO_MIN_HEIGHT, V_KANGAROO_MAX_HEIGHT), 2);
        end if;
        
        v_birthday := to_date(trunc(dbms_random.value(to_char(V_BIRTHDAY_INTERVAL_START, 'J'), to_char(V_BIRTHDAY_INTERVAL_END, 'J'))), 'J');
        
        insert into animals values(v_code, v_animal_name, v_weight, v_height, v_birthday, v_species, v_breed, v_sex);
    end loop;
    
    v_code_counter := V_REPTILES_INITIAL_ID;
    for v_counter in 1..V_NR_REPTILES loop
        v_code_counter := v_code_counter + 1;
        v_code := V_CODE_PREFIX || to_char(v_code_counter);
        
        select decode(trunc(sys.dbms_random.value(0, 2)), 0, 'f', 'm') into v_sex from dual;
        if v_sex = 'm' then
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_males + 1));
            v_animal_name := v_animal_names_males(v_random_index);
        else
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_females + 1));
            v_animal_name := v_animal_names_females(v_random_index);
        end if;
        
        v_species := 'reptile';
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_reptile_breeds + 1));
        v_breed := v_reptile_breeds(v_random_index);
        
        if v_breed in ('american alligator', 'american crocodile', 'chinese alligator') then
            v_weight := trunc(dbms_random.value(V_CROCODILE_MIN_WEIGHT, V_CROCODILE_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_CROCODILE_MIN_HEIGHT, V_CROCODILE_MAX_HEIGHT), 2);
        elsif v_breed in ('alligator snapping turtle', 
            'bearded dragon', 'green basilisk', 'chuckwalla', 'galapagos tortoise', 'komodo dragon', 'lace monitor') then
            v_weight := trunc(dbms_random.value(V_LIZARD_MIN_WEIGHT, V_LIZARD_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_LIZARD_MIN_HEIGHT, V_LIZARD_MAX_HEIGHT), 2);
        else
            v_weight := trunc(dbms_random.value(V_SNAKE_MIN_WEIGHT, V_SNAKE_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_SNAKE_MIN_HEIGHT, V_SNAKE_MAX_HEIGHT), 2);
        end if;
        
        v_birthday := to_date(trunc(dbms_random.value(to_char(V_BIRTHDAY_INTERVAL_START, 'J'), to_char(V_BIRTHDAY_INTERVAL_END, 'J'))), 'J');
        
        insert into animals values(v_code, v_animal_name, v_weight, v_height, v_birthday, v_species, v_breed, v_sex);
    end loop;
    
    v_code_counter := V_BIRDS_INITIAL_ID;
    for v_counter in 1..V_NR_BIRDS loop
        v_code_counter := v_code_counter + 1;
        v_code := V_CODE_PREFIX || to_char(v_code_counter);
        
        select decode(trunc(sys.dbms_random.value(0, 2)), 0, 'f', 'm') into v_sex from dual;
        if v_sex = 'm' then
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_males + 1));
            v_animal_name := v_animal_names_males(v_random_index);
        else
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_females + 1));
            v_animal_name := v_animal_names_females(v_random_index);
        end if;
        
        v_species := 'bird';
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_bird_breeds + 1));
        v_breed := v_bird_breeds(v_random_index);
        
        if v_breed in ('barn owl', 'blue and gold macaw', 'blue-crowned motmot', 'capuchinbird', 'crested coua', 
            'eastern screech owl', 'fairy bluebird', 'inca tern', 'kea', 'scarlet ibis') then
            v_weight := trunc(dbms_random.value(V_SMALL_BIRD_MIN_WEIGHT, V_SMALL_BIRD_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_SMALL_BIRD_MIN_HEIGHT, V_SMALL_BIRD_MAX_HEIGHT), 2);
        elsif v_breed in ('bald eagle', 'lapped-faced vulture', 'trumpeter swan', 
            'magpie goose') then
            v_weight := trunc(dbms_random.value(V_MEDIUM_BIRD_MIN_WEIGHT, V_MEDIUM_BIRD_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_MEDIUM_BIRD_MIN_HEIGHT, V_MEDIUM_BIRD_MAX_HEIGHT), 2);
        elsif v_breed in ('greater flamingo', 'ostrich', 'saddlebill stork') then
            v_weight := trunc(dbms_random.value(V_LARGE_BIRD_MIN_WEIGHT, V_LARGE_BIRD_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_LARGE_BIRD_MIN_HEIGHT, V_LARGE_BIRD_MAX_HEIGHT), 2);
        else
            v_weight := trunc(dbms_random.value(V_PENGUIN_MIN_WEIGHT, V_PENGUIN_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_PENGUIN_MIN_HEIGHT, V_PENGUIN_MAX_HEIGHT), 2);
        end if;
        
        v_birthday := to_date(trunc(dbms_random.value(to_char(V_BIRTHDAY_INTERVAL_START, 'J'), to_char(V_BIRTHDAY_INTERVAL_END, 'J'))), 'J');
        
        insert into animals values(v_code, v_animal_name, v_weight, v_height, v_birthday, v_species, v_breed, v_sex);
    end loop;
    
    v_code_counter := V_AMPHIBIANS_INITIAL_ID;
    for v_counter in 1..V_NR_AMPHIBIANS loop
        v_code_counter := v_code_counter + 1;
        v_code := V_CODE_PREFIX || to_char(v_code_counter);
        
        select decode(trunc(sys.dbms_random.value(0, 2)), 0, 'f', 'm') into v_sex from dual;
        if v_sex = 'm' then
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_males + 1));
            v_animal_name := v_animal_names_males(v_random_index);
        else
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_females + 1));
            v_animal_name := v_animal_names_females(v_random_index);
        end if;
        
        v_species := 'amphibian';
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_amphibian_breeds + 1));
        v_breed := v_amphibian_breeds(v_random_index);
        
        if v_breed in ('amazon milk frog', 'dyeing poison dart frog', 'fire-bellied newt', 'golden poison dart frog', 
            'ornate horned frog') then
            v_weight := trunc(dbms_random.value(V_FROG_MIN_WEIGHT, V_FROG_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_FROG_MIN_HEIGHT, V_FROG_MAX_HEIGHT), 2);
        else
            v_weight := trunc(dbms_random.value(V_SALAMANDER_MIN_WEIGHT, V_SALAMANDER_MAX_WEIGHT), 2);
            v_height := trunc(dbms_random.value(V_SALAMANDER_MIN_HEIGHT, V_SALAMANDER_MAX_HEIGHT), 2);
        end if;
        
        v_birthday := to_date(trunc(dbms_random.value(to_char(V_BIRTHDAY_INTERVAL_START, 'J'), to_char(V_BIRTHDAY_INTERVAL_END, 'J'))), 'J');
        
        insert into animals values(v_code, v_animal_name, v_weight, v_height, v_birthday, v_species, v_breed, v_sex);
    end loop;
    
    v_code_counter := V_FISH_INITIAL_ID;
    for v_counter in 1..V_NR_FISH loop
        v_code_counter := v_code_counter + 1;
        v_code := V_CODE_PREFIX || to_char(v_code_counter);
        
        select decode(trunc(sys.dbms_random.value(0, 2)), 0, 'f', 'm') into v_sex from dual;
        if v_sex = 'm' then
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_males + 1));
            v_animal_name := v_animal_names_males(v_random_index);
        else
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_animal_names_females + 1));
            v_animal_name := v_animal_names_females(v_random_index);
        end if;
        
        v_species := 'fish';
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_fish_breeds + 1));
        v_breed := v_fish_breeds(v_random_index);
        
        v_weight := trunc(dbms_random.value(V_FISH_MIN_WEIGHT, V_FISH_MAX_WEIGHT), 2);
        v_height := trunc(dbms_random.value(V_FISH_MIN_HEIGHT, V_FISH_MAX_HEIGHT), 2);
        
        v_birthday := to_date(trunc(dbms_random.value(to_char(V_BIRTHDAY_INTERVAL_START, 'J'), to_char(V_BIRTHDAY_INTERVAL_END, 'J'))), 'J');
        
        insert into animals values(v_code, v_animal_name, v_weight, v_height, v_birthday, v_species, v_breed, v_sex);
    end loop;
end;
/


/* populate ZOOKEEPERS table */
declare
    V_NR_ZOOKEEPERS integer := 300;
    V_BIRTHDAY_INTERVAL_START date := date '1970-01-01';
    V_BIRTHDAY_INTERVAL_END date := date '2000-01-01';
    
    type t_months is table of char(2);
    type t_days is table of char(2);
    type t_names is table of varchar(50);
    type t_roles is table of varchar(20);
    
    v_cnp char(13) := '';
    v_first_cnp_digit char(1) := '';
    v_cnp_year char(2);
    v_cnp_month_number integer;
    v_cnp_month_char varchar(2);
    v_cnp_day_number integer;
    v_cnp_day_char varchar(2);
    v_random_birthday date;
    
    v_first_names_boys t_names := t_names('Wade', 'Dave', 'Seth', 'Ivan', 'Riley', 'Gilbert', 'Jorge', 'Dan', 'Brian', 'Roberto', 'Ramon', 'Miles', 'Liam', 
            'Nathaniel', 'Ethan', 'Lewis', 'Milton', 'Claude', 'Joshua', 'Glen', 'Harvey', 'Blake', 'Antonio', 'Connor', 'Julian');
    v_first_names_girls t_names := t_names('Daisy', 'Deborah', 'Isabel', 'Stella', 'Debra', 'Beverly', 'Vera', 'Angela', 'Lucy', 'Lauren', 'Janet', 'Loretta', 
            'Tracey', 'Beatrice', 'Sabrina', 'Melody', 'Chrysta', 'Christina', 'Vicki', 'Molly', 'Alison', 'Miranda', 'Stephanie', 'Leona');               
    v_first_name varchar(50);
    v_nr_first_names_boys number(2) := v_first_names_boys.count;
    v_nr_first_names_girls number(2) := v_first_names_girls.count;
    v_last_names t_names := t_names('Williams', 'Harris', 'Thomas', 'Robinson', 'Walker', 'Scott', 'Nelson', 'Mitchell', 'Morgan', 'Cooper', 'Howard', 
            'Davis', 'Miller', 'Martin', 'Smith', 'Anderson', 'White', 'Perry', 'Clark', 'Richards', 'Wheeler', 'Warburton', 'Stanley', 'Holland', 
            'Terry', 'Shelton', 'Miles', 'Lucas', 'Fletcher', 'Parks', 'Norris', 'Guzman', 'Daniel', 'Newton', 'Potter', 'Francis', 'Erickson', 'Norman', 
            'Moody', 'Lindsey', 'Gross', 'Sherman', 'Simon', 'Jones', 'Brown', 'Garcia', 'Rodriguez', 'Lee', 'Young', 'Hall');
    v_last_name varchar(50);
    v_nr_last_names number(2) := v_last_names.count;
    v_random_index number(2);
    
    v_email varchar(100);
    v_phone_number varchar(10);
    
    v_roles t_roles := t_roles('cleaner', 'feeder', 'trainer', 'surveiller', 'groomer');
    v_role varchar(20);
    v_nr_roles number(2) := v_roles.count;
begin
    for v_counter in 1..V_NR_ZOOKEEPERS loop
        if sys.dbms_random.value(0, 1) < 0.5 then
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_first_names_boys + 1));
            v_first_name := v_first_names_boys(v_random_index);
            v_first_cnp_digit := '1';
        else 
            v_random_index := trunc(sys.dbms_random.value(1, v_nr_first_names_girls + 1));
            v_first_name := v_first_names_girls(v_random_index);
            v_first_cnp_digit := '2';
        end if;
        
        select to_date(trunc(dbms_random.value(to_char(V_BIRTHDAY_INTERVAL_START, 'J'), to_char(V_BIRTHDAY_INTERVAL_END, 'J'))), 'J') into v_random_birthday from dual;
        select substr(to_char(extract(year from v_random_birthday)), 3) into v_cnp_year from dual;
        select extract(month from v_random_birthday) into v_cnp_month_number from dual;
        select extract(day from v_random_birthday) into v_cnp_day_number from dual;
        if v_cnp_month_number < 10 then
            v_cnp_month_char := '0' || to_char(v_cnp_month_number);
        else
            v_cnp_month_char := to_char(v_cnp_month_number);
        end if;
        if v_cnp_day_number < 10 then
            v_cnp_day_char := '0' || to_char(v_cnp_day_number);
        else
            v_cnp_day_char := to_char(v_cnp_day_number);
        end if;
        v_cnp := v_first_cnp_digit || v_cnp_year || v_cnp_month_char || v_cnp_day_char
                || to_char(trunc(sys.dbms_random.value(0, 10))) || to_char(trunc(sys.dbms_random.value(0, 10))) || to_char(trunc(sys.dbms_random.value(0, 10))) 
                || to_char(trunc(sys.dbms_random.value(0, 10))) || to_char(trunc(sys.dbms_random.value(0, 10))) || to_char(trunc(sys.dbms_random.value(0, 10)));
       
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_last_names + 1));
        v_last_name := v_last_names(v_random_index);
        
        v_email := lower(v_first_name) || to_char(trunc(sys.dbms_random.value(0, 10))) || to_char(trunc(sys.dbms_random.value(0, 10)))
            || to_char(trunc(sys.dbms_random.value(0, 10))) || '.' || lower(v_last_name) || '@zoo.com';
        
        v_phone_number := '07';
        for v_counter_phone_number in 1..8 loop
            v_phone_number := v_phone_number || to_char(trunc(sys.dbms_random.value(0, 10)));
        end loop;
        
        v_random_index := trunc(sys.dbms_random.value(1, v_nr_roles + 1));
        v_role := v_roles(v_random_index);
        
        insert into zookeepers values(v_cnp, v_first_name, v_last_name, v_email, v_phone_number, v_role);
    end loop;
end;
/


create or replace function random_date_from_preceding_month(p_current_date in date) return date as
    v_previous_month integer;
    v_year integer;
    v_first_day date;
    v_last_day date;
begin
    select extract(month from p_current_date) into v_previous_month from dual;
    select extract(year from p_current_date) into v_year from dual;
    if v_previous_month = 1 then
        v_previous_month := 12;
        v_year := v_year - 1;
    else 
        v_previous_month := v_previous_month - 1;
    end if;
    
    select last_day(to_date(v_previous_month || ':' || v_year, 'MM:YYYY')) into v_last_day from dual;
    select add_months((v_last_day + 1), -1) into v_first_day from dual;
    
    return to_date(trunc(dbms_random.value(to_char(v_first_day, 'J'), to_char(v_last_day + 1, 'J'))), 'J');
end random_date_from_preceding_month;
/

/* populate ANIMALS_MEASUREMENTS table */
declare
    V_N_YEARS_UNTIL_GROWING_IS_STABILIZING integer := 5;
    
    V_PROBABILITY_OF_WEIGHT_CHANGE_IN_FIRST_N_YEARS float := 0.85;
    V_PROBABILITY_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS float := 0.95;
    V_MIN_PERCENT_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS float := 0.03;
    V_MAX_PERCENT_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS float := 0.05;
    V_MIN_PERCENT_OF_WEIGHT_DECREASING_IN_FIRST_N_YEARS float := 0.005;
    V_MAX_PERCENT_OF_WEIGHT_DECREASING_IN_FIRST_N_YEARS float := 0.01;
    
    V_PROBABILITY_OF_WEIGHT_CHANGE_AFTER_N_YEARS float := 0.75;
    V_PROBABILITY_OF_WEIGHT_INCREASING_AFTER_N_YEARS float := 0.50;
    V_MIN_PERCENT_OF_WEIGHT_INCREASING_AFTER_N_YEARS float := 0.01;
    V_MAX_PERCENT_OF_WEIGHT_INCREASING_AFTER_N_YEARS float := 0.02;
    V_MIN_PERCENT_OF_WEIGHT_DECREASING_AFTER_N_YEARS float := 0.005;
    V_MAX_PERCENT_OF_WEIGHT_DECREASING_AFTER_N_YEARS float := 0.01;
    
    V_PROBABILITY_OF_HEIGHT_CHANGE_IN_FIRST_N_YEARS float := 0.75;
    V_PROBABILITY_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS float := 0.95;
    V_MIN_PERCENT_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS float := 0.01;
    V_MAX_PERCENT_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS float := 0.02;
    V_MIN_PERCENT_OF_HEIGHT_DECREASING_IN_FIRST_N_YEARS float := 0.0005;
    V_MAX_PERCENT_OF_HEIGHT_DECREASING_IN_FIRST_N_YEARS float := 0.001;
    
    V_PROBABILITY_OF_HEIGHT_CHANGE_AFTER_N_YEARS float := 0.05;
    V_PROBABILITY_OF_HEIGHT_INCREASING_AFTER_N_YEARS float := 0.50;
    V_MIN_PERCENT_OF_HEIGHT_INCREASING_AFTER_N_YEARS float := 0.0001;
    V_MAX_PERCENT_OF_HEIGHT_INCREASING_AFTER_N_YEARS float := 0.0002;
    V_MIN_PERCENT_OF_HEIGHT_DECREASING_AFTER_N_YEARS float := 0.0001;
    V_MAX_PERCENT_OF_HEIGHT_DECREASING_AFTER_N_YEARS float := 0.0002;
    
    v_age_in_years integer;
    v_previous_new_date date;
    v_new_date date;
    v_measurement_start_day date;
    v_measurement_end_day date;
    v_born_in_the_zoo integer;
    
    v_animal_code char(10);
    v_weight number(6, 2);
    v_height number(5, 2);
    v_measurement_date t_time;
    
    cursor animals_cursor is select code, weight, height, birthday from animals;
    x animals_cursor%rowtype;
begin
    for x in animals_cursor loop
        v_animal_code := x.code;
        
        select floor(months_between(x.birthday, am.measurement_date.start_time) / 12), am.measurement_date.start_time
            into v_age_in_years, v_measurement_end_day from animals_measurements am where animal_code = x.code;
        
        v_born_in_the_zoo := trunc(sys.dbms_random.value(0, 2));
        if v_born_in_the_zoo = 1 then
            v_measurement_start_day := x.birthday;
        else 
            v_measurement_start_day := to_date(trunc(dbms_random.value(to_char(x.birthday + 60, 'J'), to_char(v_measurement_end_day - 60 + 1, 'J'))), 'J');
        end if;
        
        select am.weight, am.height, am.measurement_date.start_time into v_weight, v_height, v_new_date from animals_measurements am where animal_code = x.code;
        while true loop
        
            v_previous_new_date := v_new_date;
            v_measurement_date := t_time(random_date_from_preceding_month(v_new_date), v_new_date);
            v_new_date := v_measurement_date.start_time;
            exit when ((v_born_in_the_zoo = 1 and v_new_date <= x.birthday) or (v_born_in_the_zoo = 0 and v_new_date <= v_measurement_start_day));
        
            if v_age_in_years >= V_N_YEARS_UNTIL_GROWING_IS_STABILIZING then
            
                if dbms_random.value(0, 1) < V_PROBABILITY_OF_WEIGHT_CHANGE_AFTER_N_YEARS then -- it needs to change
                    if dbms_random.value(0, 1) > V_PROBABILITY_OF_WEIGHT_INCREASING_AFTER_N_YEARS then -- increase (with probability of decreasing cause going reversed)
                        v_weight := v_weight + trunc(dbms_random.value(V_MIN_PERCENT_OF_WEIGHT_DECREASING_AFTER_N_YEARS, V_MAX_PERCENT_OF_WEIGHT_DECREASING_AFTER_N_YEARS), 4) * v_weight;
                    else -- decrease with probability of increasing
                        v_weight := v_weight - trunc(dbms_random.value(V_MIN_PERCENT_OF_WEIGHT_INCREASING_AFTER_N_YEARS, V_MAX_PERCENT_OF_WEIGHT_INCREASING_AFTER_N_YEARS), 4) * v_weight;
                    end if;
                else -- doesn't change
                    null;
                end if;
                
                if dbms_random.value(0, 1) < V_PROBABILITY_OF_HEIGHT_CHANGE_AFTER_N_YEARS then -- it needs to change
                    if dbms_random.value(0, 1) > V_PROBABILITY_OF_HEIGHT_INCREASING_AFTER_N_YEARS then -- increase
                        v_height := v_height + trunc(dbms_random.value(V_MIN_PERCENT_OF_HEIGHT_DECREASING_AFTER_N_YEARS, V_MAX_PERCENT_OF_HEIGHT_DECREASING_AFTER_N_YEARS), 4) * v_height;
                    else -- decrease
                        v_height := v_height - trunc(dbms_random.value(V_MIN_PERCENT_OF_HEIGHT_INCREASING_AFTER_N_YEARS, V_MAX_PERCENT_OF_HEIGHT_INCREASING_AFTER_N_YEARS), 4) * v_height;
                    end if;
                else -- doesn't change
                    null;
                end if;
                
                select floor(months_between(x.birthday, v_new_date) / 12) 
                    into v_age_in_years from dual;
                
            else 
                
                if dbms_random.value(0, 1) < V_PROBABILITY_OF_WEIGHT_CHANGE_IN_FIRST_N_YEARS then -- it needs to change
                    if dbms_random.value(0, 1) > V_PROBABILITY_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS then -- increase (with probability of decreasing cause going reversed)
                        v_weight := v_weight + trunc(dbms_random.value(V_MIN_PERCENT_OF_WEIGHT_DECREASING_IN_FIRST_N_YEARS, V_MAX_PERCENT_OF_WEIGHT_DECREASING_IN_FIRST_N_YEARS), 4) * v_weight;
                    else -- decrease with probability of increasing
                        v_weight := v_weight - trunc(dbms_random.value(V_MIN_PERCENT_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS, V_MAX_PERCENT_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS), 4) * v_weight;
                    end if;
                else -- doesn't change
                    null;
                end if;
                
                if dbms_random.value(0, 1) < V_PROBABILITY_OF_HEIGHT_CHANGE_IN_FIRST_N_YEARS then -- it needs to change
                    if dbms_random.value(0, 1) > V_PROBABILITY_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS then -- increase
                        v_height := v_height + trunc(dbms_random.value(V_MIN_PERCENT_OF_HEIGHT_DECREASING_IN_FIRST_N_YEARS, V_MAX_PERCENT_OF_HEIGHT_DECREASING_IN_FIRST_N_YEARS), 4) * v_height;
                    else -- decrease
                        v_height := v_height - trunc(dbms_random.value(V_MIN_PERCENT_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS, V_MAX_PERCENT_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS), 4) * v_height;
                    end if;
                else -- doesn't change
                    null;
                end if;
            
            end if;
            
            insert into animals_measurements values(x.code, v_weight, v_height, v_measurement_date);
        
        end loop;
        
        if v_born_in_the_zoo = 1 then
            v_measurement_date := t_time(x.birthday, v_previous_new_date);
        else
            v_measurement_date := t_time(v_measurement_start_day, v_previous_new_date);
        end if;
        v_weight := v_weight - trunc(dbms_random.value(V_MIN_PERCENT_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS, V_MAX_PERCENT_OF_WEIGHT_INCREASING_IN_FIRST_N_YEARS), 4) * v_weight;
        v_height := v_height - trunc(dbms_random.value(V_MIN_PERCENT_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS, V_MAX_PERCENT_OF_HEIGHT_INCREASING_IN_FIRST_N_YEARS), 4) * v_height;
        insert into animals_measurements values(x.code, v_weight, v_height, v_measurement_date);
        
    end loop;
end;
/


create or replace function random_sublist(p_sectors in t_sectors, p_full_time in integer) return t_sectors as
    v_random_sublist_length integer := trunc(sys.dbms_random.value(1, p_sectors.count + 1));
    v_random_sublist t_sectors := t_sectors();
    v_random_element char(10);
begin
    if p_full_time = -1 then
        null;
    elsif p_full_time = 1 then
        v_random_sublist_length := 2;
    else
        v_random_sublist_length := 1;
    end if;

    while v_random_sublist.count < v_random_sublist_length loop
        v_random_element := p_sectors(trunc(sys.dbms_random.value(1, p_sectors.count + 1)));
        if v_random_element not member of v_random_sublist then
            v_random_sublist.extend;
            v_random_sublist(v_random_sublist.last) := v_random_element;
        end if;
    end loop;
    
    return v_random_sublist;
end random_sublist;
/

/* populate ANIMALS_DISTRIBUTION table */
declare
    V_SECTORS_FOR_MONKEYS t_sectors := t_sectors('S4', 'S5', 'S8', 'S10');
    V_SECTORS_FOR_BIG_CARNIVORE_MAMMALS t_sectors := t_sectors('S3', 'S6', 'S8');
    V_SECTORS_FOR_POLAR_MAMMALS t_sectors := t_sectors('S7');
    V_SECTORS_FOR_HERBIVOROUS_MAMMALS t_sectors := t_sectors('S4', 'S6', 'S8', 'S10');
    V_SECTORS_FOR_SMALL_CARNIVORE_MAMMALS t_sectors := t_sectors('S3', 'S4', 'S6', 'S8', 'S10');
    V_SECTORS_FOR_ELEPHANTS_AND_KANGAROOS t_sectors := t_sectors('S4', 'S8');
    V_SECTORS_FOR_HIPPOS_ANDMANATEE t_sectors := t_sectors('S1');
    V_SECTORS_FOR_GIRAFFES t_sectors := t_sectors('S5', 'S6');
    
    V_SECTORS_FOR_CROCODILES t_sectors := t_sectors('S1');
    V_SECTORS_FOR_LIZARDS t_sectors := t_sectors('S1', 'S2', 'S3', 'S4', 'S9');
    V_SECTORS_FOR_SNAKES t_sectors := t_sectors('S3', 'S9');
    
    V_SECTORS_FOR_SMALL_BIRDS t_sectors := t_sectors('S4', 'S5', 'S10');
    V_SECTORS_FOR_MEDIUM_BIRDS t_sectors := t_sectors('S5', 'S10');
    V_SECTORS_FOR_LARGE_BIRDS t_sectors := t_sectors('S1', 'S8');
    V_SECTORS_FOR_PENGUINS t_sectors := t_sectors('S7');
    
    V_SECTORS_FOR_FROGS t_sectors := t_sectors('S9');
    V_SECTORS_FOR_SALAMANDERS t_sectors := t_sectors('S3', 'S9');
    
    V_SECTORS_FOR_FISH t_sectors := t_sectors('S2');
    
    v_residing_sectors t_sectors;
    
    cursor animals_cursor is select code, species, breed from animals;
    x animals_cursor%rowtype;
begin
    for x in animals_cursor loop
        case x.species
            when 'mammal' then
                if x.breed in ('angolan colobus monkey', 'black howler monkey', 'bonobo monkey', 'buff-cheeked gibbon', 
                    'siamang monkey', 'sumatran orangutan', 'western lowland gorilla', 'white-handed gibbon', 'white-faced saki monkey', 'two-toed sloth') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_MONKEYS, -1);
                elsif x.breed in ('african lion', 'andean bear', 'clouded leopard', 'cougar', 'malayan tiger') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_BIG_CARNIVORE_MAMMALS, -1);
                elsif x.breed in ('polar bear', 'arctic fox', 'snow leopard') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_POLAR_MAMMALS, -1);
                elsif x.breed in ('plains zebra', 'eastern bongo', 'impala', 
                    'lesser kudu', 'llama', 'nigerian dwarf goat', 'okapi', 'gazelle', 'alpaca') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_HERBIVOROUS_MAMMALS, -1);
                elsif x.breed in ('african painted dog', 'black-footed cat', 
                    'bobcat', 'brazilian porcupine', 'cape porcupine', 'cheetah', 'mexican wolf', 'red panda') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_SMALL_CARNIVORE_MAMMALS, -1);
                elsif x.breed in ('asian elephant', 'kangaroo') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_ELEPHANTS_AND_KANGAROOS, -1);
                elsif x.breed in ('hippopotamus', 'florida manatee') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_HIPPOS_ANDMANATEE, -1);
                else
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_GIRAFFES, -1);
                end if;
            when 'reptile' then
                if x.breed in ('american alligator', 'american crocodile', 'chinese alligator') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_CROCODILES, -1);
                elsif x.breed in ('alligator snapping turtle', 
                    'bearded dragon', 'green basilisk', 'chuckwalla', 'galapagos tortoise', 'komodo dragon', 'lace monitor') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_LIZARDS, -1);
                else
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_SNAKES, -1);
                end if;
            when 'bird' then
                if x.breed in ('barn owl', 'blue and gold macaw', 'blue-crowned motmot', 'capuchinbird', 'crested coua', 
                    'eastern screech owl', 'fairy bluebird', 'inca tern', 'kea', 'scarlet ibis') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_SMALL_BIRDS, -1);
                elsif x.breed in ('bald eagle', 'lapped-faced vulture', 'trumpeter swan', 
                    'magpie goose') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_MEDIUM_BIRDS, -1);
                elsif x.breed in ('greater flamingo', 'ostrich', 'saddlebill stork') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_LARGE_BIRDS, -1);
                else
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_PENGUINS, -1);
                end if;
            when 'amphibian' then
                if x.breed in ('amazon milk frog', 'dyeing poison dart frog', 'fire-bellied newt', 'golden poison dart frog', 
                    'ornate horned frog') then
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_FROGS, -1);
                else
                    v_residing_sectors := random_sublist(V_SECTORS_FOR_SALAMANDERS, -1);
                end if;
            else
                v_residing_sectors := random_sublist(V_SECTORS_FOR_FISH, -1);
        end case;
        
        for i in 1..v_residing_sectors.count loop
            insert into animals_distribution values(x.code, v_residing_sectors(i));
        end loop;
  
    end loop;
end;
/


create or replace function random_residing_intervals(p_start_date in date, p_nr_subintervals in integer, p_with_start_date_included in integer, p_with_end_date_included in integer) return t_residing_intervals as
    v_residing_intervals t_residing_intervals := t_residing_intervals();
    v_days_increment float := abs(current_date - p_start_date) / p_nr_subintervals;
    v_start_time date := to_date('01-JAN-1950', 'DD-MON-YYYY');
    v_end_time date := to_date('01-JAN-1950', 'DD-MON-YYYY');
    v_counter integer := 0;
begin
    if p_nr_subintervals = 1 or ceil(v_days_increment) <= p_nr_subintervals then
        if p_with_start_date_included = 1 then
            v_start_time := p_start_date;
            if p_with_end_date_included = 1 then
                v_end_time := null;
            else 
                v_end_time := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(current_date, 'J'))), 'J');
            end if;
        else 
            if p_with_end_date_included = 1 then
                v_start_time := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(current_date, 'J'))), 'J');
                v_end_time := null;
            else
                while v_start_time = v_end_time loop
                    v_counter := v_counter + 1;
                    exit when v_counter = 100;
                    v_start_time := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(current_date, 'J'))), 'J');
                    v_end_time := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(current_date, 'J'))), 'J');
                end loop;
            end if;
        end if;
        if v_counter = 100 then
            null;
        else 
            if v_start_time < v_end_time or v_end_time is null then
                v_residing_intervals.extend;
                v_residing_intervals(v_residing_intervals.last) := t_time(v_start_time, v_end_time);
            else
                v_residing_intervals.extend;
                v_residing_intervals(v_residing_intervals.last) := t_time(v_end_time, v_start_time);
            end if;
        end if;
    else 
        for i in 1..p_nr_subintervals loop
            v_start_time := to_date('01-JAN-1950', 'DD-MON-YYYY');
            v_end_time := to_date('01-JAN-1950', 'DD-MON-YYYY');
            v_counter := 0;
            if i = 1 then
                if p_with_start_date_included = 1 then
                    v_residing_intervals.extend;
                    v_residing_intervals(v_residing_intervals.last) := t_time(
                        p_start_date, 
                        to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(p_start_date + v_days_increment, 'J'))), 'J')
                    );
                else
                    while v_start_time = v_end_time loop
                        v_counter := v_counter + 1;
                        exit when v_counter = 100;
                        v_start_time := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(p_start_date + v_days_increment, 'J'))), 'J');
                        v_end_time := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(p_start_date + v_days_increment, 'J'))), 'J');
                    end loop;
                    
                    if v_counter = 100 then
                        null;
                    else 
                        if v_start_time < v_end_time then
                            v_residing_intervals.extend;
                            v_residing_intervals(v_residing_intervals.last) := t_time(v_start_time, v_end_time);
                        else
                            v_residing_intervals.extend;
                            v_residing_intervals(v_residing_intervals.last) := t_time(v_end_time, v_start_time);
                        end if;
                    end if;
                end if;
            elsif i = p_nr_subintervals then
                if p_with_end_date_included = 1 then
                    v_residing_intervals.extend;
                    v_residing_intervals(v_residing_intervals.last) := t_time(
                        to_date(trunc(dbms_random.value(to_char(p_start_date + ((p_nr_subintervals - 1) * v_days_increment), 'J'), to_char(current_date, 'J'))), 'J'), 
                        null
                    );
                else 
                    while v_start_time = v_end_time loop
                        v_counter := v_counter + 1;
                        exit when v_counter = 100;
                        v_start_time := to_date(trunc(dbms_random.value(to_char(p_start_date + ((p_nr_subintervals - 1) * v_days_increment), 'J'), to_char(current_date, 'J'))), 'J');
                        v_end_time := to_date(trunc(dbms_random.value(to_char(p_start_date + ((p_nr_subintervals - 1) * v_days_increment), 'J'), to_char(current_date, 'J'))), 'J');
                    end loop;
                    if v_counter = 100 then
                        null;
                    else
                        if v_start_time < v_end_time then
                            v_residing_intervals.extend;
                            v_residing_intervals(v_residing_intervals.last) := t_time(v_start_time, v_end_time);
                        else
                            v_residing_intervals.extend;
                            v_residing_intervals(v_residing_intervals.last) := t_time(v_end_time, v_start_time);
                        end if;
                    end if;
                end if;
            else 
                while v_start_time = v_end_time loop
                    v_counter := v_counter + 1;
                    exit when v_counter = 100;
                    v_start_time := to_date(trunc(dbms_random.value(to_char(p_start_date + ((i - 1) * v_days_increment), 'J'), to_char(p_start_date + (i * v_days_increment), 'J'))), 'J');
                    v_end_time := to_date(trunc(dbms_random.value(to_char(p_start_date + ((i - 1) * v_days_increment), 'J'), to_char(p_start_date + (i * v_days_increment), 'J'))), 'J');
                end loop;
                
                if v_counter = 100 then
                    null;
                else
                    if v_start_time < v_end_time then
                        v_residing_intervals.extend;
                        v_residing_intervals(v_residing_intervals.last) := t_time(v_start_time, v_end_time);
                    else
                        v_residing_intervals.extend;
                        v_residing_intervals(v_residing_intervals.last) := t_time(v_end_time, v_start_time);
                    end if;
                end if;
            end if;
        end loop;
    end if;

    return v_residing_intervals;
end random_residing_intervals;
/

/*declare
    v_residing_intervals t_residing_intervals := random_residing_intervals(to_date('16-OCT-2020'), 5, 0, 0);
    v_string varchar(300);
begin
    dbms_output.enable(buffer_size => NULL);
    dbms_output.put_line(to_char(v_residing_intervals.count));
    for i in 1..1 loop
        v_residing_intervals := random_residing_intervals(to_date('12-FEB-2015'), 4, 0, 0);
        for j in 1..v_residing_intervals.count loop
            v_string := to_char(v_residing_intervals(j).start_time) || ' ' || to_char(v_residing_intervals(j).end_time);
            dbms_output.put_line(v_string);
        end loop;
        dbms_output.put_line(' ');
    end loop;
end;*/

/* populate ANIMALS_DISTRIBUTION_HISTORY table */
declare
    V_MIN_RESIDING_PERIODS_PER_SECTOR integer := 1;
    V_MAX_RESIDING_PERIODS_PER_SECTOR integer := 5;

    V_SECTORS_FOR_MONKEYS t_sectors := t_sectors('S4', 'S5', 'S8', 'S10');
    V_SECTORS_FOR_BIG_CARNIVORE_MAMMALS t_sectors := t_sectors('S3', 'S6', 'S8');
    V_SECTORS_FOR_POLAR_MAMMALS t_sectors := t_sectors('S7');
    V_SECTORS_FOR_HERBIVOROUS_MAMMALS t_sectors := t_sectors('S4', 'S6', 'S8', 'S10');
    V_SECTORS_FOR_SMALL_CARNIVORE_MAMMALS t_sectors := t_sectors('S3', 'S4', 'S6', 'S8', 'S10');
    V_SECTORS_FOR_ELEPHANTS_AND_KANGAROOS t_sectors := t_sectors('S4', 'S8');
    V_SECTORS_FOR_HIPPOS_ANDMANATEE t_sectors := t_sectors('S1');
    V_SECTORS_FOR_GIRAFFES t_sectors := t_sectors('S5', 'S6');
    
    V_SECTORS_FOR_CROCODILES t_sectors := t_sectors('S1');
    V_SECTORS_FOR_LIZARDS t_sectors := t_sectors('S1', 'S2', 'S3', 'S4', 'S9');
    V_SECTORS_FOR_SNAKES t_sectors := t_sectors('S3', 'S9');
    
    V_SECTORS_FOR_SMALL_BIRDS t_sectors := t_sectors('S4', 'S5', 'S10');
    V_SECTORS_FOR_MEDIUM_BIRDS t_sectors := t_sectors('S5', 'S10');
    V_SECTORS_FOR_LARGE_BIRDS t_sectors := t_sectors('S1', 'S8');
    V_SECTORS_FOR_LARGE_PENGUINS t_sectors := t_sectors('S7');
    
    V_SECTORS_FOR_FROGS t_sectors := t_sectors('S9');
    V_SECTORS_FOR_SALAMANDERS t_sectors := t_sectors('S3', 'S9');
    
    V_SECTORS_FOR_FISH t_sectors := t_sectors('S2');
    
    cursor animals_cursor is select code, species, breed from animals;
    x animals_cursor%rowtype;
    
    cursor current_residing_sectors(p_animal_code char) is select sector_code from animals_distribution where animal_code = p_animal_code;
    y char(10);
    
    v_first_day_at_zoo date;
    v_current_residing_sectors t_sectors := t_sectors();
    v_all_possible_residing_sectors t_sectors := t_sectors();
    v_sectors_with_initial_residing t_sectors := t_sectors();
    v_residing_intervals t_residing_intervals := t_residing_intervals();
begin
    delete from animals_distribution_history;
    
    for x in animals_cursor loop
        v_current_residing_sectors := t_sectors();
        
        select * into v_first_day_at_zoo from 
            (select am.measurement_date.start_time from animals_measurements am where animal_code = x.code order by am.measurement_date.start_time)
        where rownum = 1;
        
        open current_residing_sectors(x.code);
        loop
            fetch current_residing_sectors INTO y;
            exit when current_residing_sectors%notfound;
            v_current_residing_sectors.extend;
            v_current_residing_sectors(v_current_residing_sectors.last) := y;
        end loop;
        close current_residing_sectors;
        
        case x.species
            when 'mammal' then
                if x.breed in ('angolan colobus monkey', 'black howler monkey', 'bonobo monkey', 'buff-cheeked gibbon', 
                    'siamang monkey', 'sumatran orangutan', 'western lowland gorilla', 'white-handed gibbon', 'white-faced saki monkey', 'two-toed sloth') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_MONKEYS;
                elsif x.breed in ('african lion', 'andean bear', 'clouded leopard', 'cougar', 'malayan tiger') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_BIG_CARNIVORE_MAMMALS;
                elsif x.breed in ('polar bear', 'arctic fox', 'snow leopard') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_POLAR_MAMMALS;
                elsif x.breed in ('plains zebra', 'eastern bongo', 'impala', 
                    'lesser kudu', 'llama', 'nigerian dwarf goat', 'okapi', 'gazelle', 'alpaca') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_HERBIVOROUS_MAMMALS;
                elsif x.breed in ('african painted dog', 'black-footed cat', 
                    'bobcat', 'brazilian porcupine', 'cape porcupine', 'cheetah', 'mexican wolf', 'red panda') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_SMALL_CARNIVORE_MAMMALS;
                elsif x.breed in ('asian elephant', 'kangaroo') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_ELEPHANTS_AND_KANGAROOS;
                elsif x.breed in ('hippopotamus', 'florida manatee') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_HIPPOS_ANDMANATEE;
                else
                    v_all_possible_residing_sectors := V_SECTORS_FOR_GIRAFFES;
                end if;
            when 'reptile' then
                if x.breed in ('american alligator', 'american crocodile', 'chinese alligator') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_CROCODILES;
                elsif x.breed in ('alligator snapping turtle', 
                    'bearded dragon', 'green basilisk', 'chuckwalla', 'galapagos tortoise', 'komodo dragon', 'lace monitor') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_LIZARDS;
                else
                    v_all_possible_residing_sectors := V_SECTORS_FOR_SNAKES;
                end if;
            when 'bird' then
                if x.breed in ('barn owl', 'blue and gold macaw', 'blue-crowned motmot', 'capuchinbird', 'crested coua', 
                    'eastern screech owl', 'fairy bluebird', 'inca tern', 'kea', 'scarlet ibis') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_SMALL_BIRDS;
                elsif x.breed in ('bald eagle', 'lapped-faced vulture', 'trumpeter swan', 
                    'magpie goose') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_MEDIUM_BIRDS;
                elsif x.breed in ('greater flamingo', 'ostrich', 'saddlebill stork') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_LARGE_BIRDS;
                else
                    v_all_possible_residing_sectors := V_SECTORS_FOR_LARGE_PENGUINS;
                end if;
            when 'amphibian' then
                if x.breed in ('amazon milk frog', 'dyeing poison dart frog', 'fire-bellied newt', 'golden poison dart frog', 
                    'ornate horned frog') then
                    v_all_possible_residing_sectors := V_SECTORS_FOR_FROGS;
                else
                    v_all_possible_residing_sectors := V_SECTORS_FOR_SALAMANDERS;
                end if;
            else
                v_all_possible_residing_sectors := V_SECTORS_FOR_FISH;
        end case;
        
        v_sectors_with_initial_residing := random_sublist(v_all_possible_residing_sectors, -1);
        
        for i in 1..v_all_possible_residing_sectors.count loop
            if v_all_possible_residing_sectors(i) member of v_current_residing_sectors then
                if v_all_possible_residing_sectors(i) member of v_sectors_with_initial_residing then
                    v_residing_intervals := random_residing_intervals(v_first_day_at_zoo, trunc(dbms_random.value(V_MIN_RESIDING_PERIODS_PER_SECTOR, V_MAX_RESIDING_PERIODS_PER_SECTOR + 1)), 1, 1);
                else 
                    v_residing_intervals := random_residing_intervals(v_first_day_at_zoo, trunc(dbms_random.value(V_MIN_RESIDING_PERIODS_PER_SECTOR, V_MAX_RESIDING_PERIODS_PER_SECTOR + 1)), 0, 1);
                end if;
            else 
                if v_all_possible_residing_sectors(i) member of v_sectors_with_initial_residing then
                    v_residing_intervals := random_residing_intervals(v_first_day_at_zoo, trunc(dbms_random.value(V_MIN_RESIDING_PERIODS_PER_SECTOR, V_MAX_RESIDING_PERIODS_PER_SECTOR + 1)), 1, 0);
                else 
                    v_residing_intervals := random_residing_intervals(v_first_day_at_zoo, trunc(dbms_random.value(V_MIN_RESIDING_PERIODS_PER_SECTOR, V_MAX_RESIDING_PERIODS_PER_SECTOR + 1)), 0, 0);
                end if;
            end if;
            
            for j in 1..v_residing_intervals.count loop
                insert into animals_distribution_history values(x.code, v_all_possible_residing_sectors(i), t_time(v_residing_intervals(j).start_time,  v_residing_intervals(j).end_time));
            end loop;
            
        end loop;
        
    end loop;
end;
/


/* populate ZOOKEEPERS_DISTRIBUTION table */
declare
    v_sectors t_sectors := t_sectors('S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8', 'S9', 'S10');
    v_working_intervals t_sectors := t_sectors('06:0010:00', '10:0014:00', '14:0018:00', '18:0022:00');
    v_full_time integer;
    v_working_sectors t_sectors := t_sectors();
    v_working_hours t_sectors := t_sectors();
    
    cursor zookeepers_cursor is select cnp from zookeepers;
    x zookeepers_cursor%rowtype;
begin
    for x in zookeepers_cursor loop
        v_full_time := trunc(sys.dbms_random.value(0, 2));
        if v_full_time = 1 then
            v_working_sectors := random_sublist(v_sectors, 1);
            v_working_hours := random_sublist(v_working_intervals, 1);
            
            insert into zookeepers_distribution values(v_working_sectors(1), x.cnp, t_working_hours(substr(v_working_hours(1), 1, 5), substr(v_working_hours(1), 6, 10)));
            insert into zookeepers_distribution values(v_working_sectors(2), x.cnp, t_working_hours(substr(v_working_hours(2), 1, 5), substr(v_working_hours(2), 6, 10)));
        else 
            v_working_sectors := random_sublist(v_sectors, 0);
            v_working_hours := random_sublist(v_working_intervals, 0);
            
            insert into zookeepers_distribution values(v_working_sectors(1), x.cnp, t_working_hours(substr(v_working_hours(1), 1, 5), substr(v_working_hours(1), 6, 10)));
        end if;
    end loop;
end;
/


create or replace function random_transition_dates(p_start_date in date, p_nr_transitions in integer) return t_dates as
    v_transition_dates t_dates := t_dates();
    v_transition_dates_unordered t_dates := t_dates();
begin
    if p_nr_transitions = 0 then
        null;
    elsif p_nr_transitions = 1 then
        v_transition_dates.extend;
        v_transition_dates(v_transition_dates.last) := p_start_date;
        v_transition_dates.extend;
        v_transition_dates(v_transition_dates.last) := to_date(trunc(dbms_random.value(to_char(p_start_date, 'J'), to_char(current_date, 'J'))), 'J');
        v_transition_dates.extend;
        v_transition_dates(v_transition_dates.last) := null;
    else 
        v_transition_dates.extend;
        v_transition_dates(v_transition_dates.last) := p_start_date;
        
        for i in 1..p_nr_transitions loop
            v_transition_dates_unordered.extend;
            v_transition_dates_unordered(v_transition_dates_unordered.last) := to_date(trunc(dbms_random.value(to_char(p_start_date + 1, 'J'), to_char(current_date + 1, 'J'))), 'J');
        end loop;
        
        for x in (select distinct column_value from table (cast(v_transition_dates_unordered AS t_dates)) order by column_value) loop
            v_transition_dates.extend;
            v_transition_dates(v_transition_dates.last) := x.column_value;
        end loop;
        
        v_transition_dates.extend;
        v_transition_dates(v_transition_dates.last) := null;
    end if;
        
    return v_transition_dates;
end random_transition_dates;
/

/*declare
    v_transition_dates t_dates := random_transition_dates(to_date('12-FEB-2020'), 10);
begin
    dbms_output.enable(buffer_size => NULL);
    dbms_output.put_line(to_char(v_transition_dates.count));
    for i in 1..v_transition_dates.count loop
        dbms_output.put_line(v_transition_dates(i));
    end loop;
end;*/

/* populate ZOOKEEPERS_DISTRIBUTION_HISTORY table */
declare
    V_MIN_TRANSITIONS integer := 0;
    V_MAX_TRANSITIONS integer := 9;
    
    cursor zookeepers_cursor is select cnp from zookeepers;
    x zookeepers_cursor%rowtype;
    
    cursor current_activity_sectors(p_zookeeper_cnp char) is select zd.sector_code || zd.working_hours.start_hour || zd.working_hours.end_hour from zookeepers_distribution zd where zookeeper_cnp = p_zookeeper_cnp;
    y char(20);
    
    v_first_day_at_zoo date;
    v_start_time date;
    v_end_time date;
    v_full_time integer;
    v_current_activity_sectors t_sectors_working_hours := t_sectors_working_hours();
    v_all_possible_activity_sectors t_sectors_working_hours := t_sectors_working_hours(
        'S1        06:0010:00', 'S1        10:0014:00', 'S1        14:0018:00', 'S1        18:0022:00',
        'S2        06:0010:00', 'S2        10:0014:00', 'S2        14:0018:00', 'S2        18:0022:00',
        'S3        06:0010:00', 'S3        10:0014:00', 'S3        14:0018:00', 'S3        18:0022:00',
        'S4        06:0010:00', 'S4        10:0014:00', 'S4        14:0018:00', 'S4        18:0022:00',
        'S5        06:0010:00', 'S5        10:0014:00', 'S5        14:0018:00', 'S5        18:0022:00',
        'S6        06:0010:00', 'S6        10:0014:00', 'S6        14:0018:00', 'S6        18:0022:00',
        'S7        06:0010:00', 'S7        10:0014:00', 'S7        14:0018:00', 'S7        18:0022:00',
        'S8        06:0010:00', 'S8        10:0014:00', 'S8        14:0018:00', 'S8        18:0022:00',
        'S9        06:0010:00', 'S9        10:0014:00', 'S9        14:0018:00', 'S9        18:0022:00',
        'S10       06:0010:00', 'S10       10:0014:00', 'S10       14:0018:00', 'S10       18:0022:00'
    );
    v_previous_activity_sectors t_sectors_working_hours := t_sectors_working_hours();
    v_activity_sector_1 char(20) := '                    ';
    v_activity_sector_2 char(20) := '                    ';
    v_transition_dates t_dates := t_dates();
begin
    delete from zookeepers_distribution_history;
    
    for x in zookeepers_cursor loop
        v_current_activity_sectors := t_sectors_working_hours();
        
        open current_activity_sectors(x.cnp);
        loop
            fetch current_activity_sectors INTO y;
            exit when current_activity_sectors%notfound;
            v_current_activity_sectors.extend;
            v_current_activity_sectors(v_current_activity_sectors.last) := y;
        end loop;
        close current_activity_sectors;
        
        select (to_date('19' || (substr(x.cnp, 2, 2) || '-' || substr(x.cnp, 4, 2) || '-' || substr(x.cnp, 6, 2)), 'YYYY-MM-DD') + interval '18' year(2)) into v_start_time from dual;
        select current_date - 30 into v_end_time from dual;
        v_first_day_at_zoo := to_date(trunc(dbms_random.value(to_char(v_start_time, 'J'), to_char(v_end_time, 'J'))), 'J');
            
        v_transition_dates := random_transition_dates(v_first_day_at_zoo, trunc(sys.dbms_random.value(V_MIN_TRANSITIONS, V_MAX_TRANSITIONS + 1)));
        
        if v_transition_dates.count = 0 then
            for i in 1..v_current_activity_sectors.count loop
                insert into zookeepers_distribution_history values(substr(v_current_activity_sectors(i), 1, 10), x.cnp, 
                    t_working_hours(substr(v_current_activity_sectors(i), 11, 5), substr(v_current_activity_sectors(i), 16, 5)),
                    t_time(v_first_day_at_zoo, null));
            end loop;
        else 
            for j in reverse 1..v_transition_dates.count - 1 loop
                if j = v_transition_dates.count - 1 then
                    for i in 1..v_current_activity_sectors.count loop
                        insert into zookeepers_distribution_history values(substr(v_current_activity_sectors(i), 1, 10), x.cnp, 
                            t_working_hours(substr(v_current_activity_sectors(i), 11, 5), substr(v_current_activity_sectors(i), 16, 5)),
                            t_time(v_transition_dates(j), null));
                        v_previous_activity_sectors.extend;
                        v_previous_activity_sectors(v_previous_activity_sectors.last) := v_current_activity_sectors(i);
                    end loop;
                else
                    v_full_time := trunc(sys.dbms_random.value(0, 2));
                    
                    v_activity_sector_1 := v_all_possible_activity_sectors(trunc(sys.dbms_random.value(1, v_all_possible_activity_sectors.count + 1)));
                    while v_activity_sector_1 member of v_previous_activity_sectors loop
                        v_activity_sector_1 := v_all_possible_activity_sectors(trunc(sys.dbms_random.value(1, v_all_possible_activity_sectors.count + 1)));
                    end loop;
                        
                    if v_full_time = 1 then
                        v_activity_sector_2 := v_all_possible_activity_sectors(trunc(sys.dbms_random.value(1, v_all_possible_activity_sectors.count + 1)));
                        while v_activity_sector_2 member of v_previous_activity_sectors or substr(v_activity_sector_2, 10, 10) = substr(v_activity_sector_1, 10, 10) loop
                            v_activity_sector_2 := v_all_possible_activity_sectors(trunc(sys.dbms_random.value(1, v_all_possible_activity_sectors.count + 1)));
                        end loop;
                    
                        insert into zookeepers_distribution_history values(substr(v_activity_sector_1, 1, 10), x.cnp, 
                            t_working_hours(substr(v_activity_sector_1, 11, 5), substr(v_activity_sector_1, 16, 5)),
                            t_time(v_transition_dates(j), v_transition_dates(j + 1)));
                            
                        insert into zookeepers_distribution_history values(substr(v_activity_sector_2, 1, 10), x.cnp, 
                            t_working_hours(substr(v_activity_sector_2, 11, 5), substr(v_activity_sector_2, 16, 5)),
                            t_time(v_transition_dates(j), v_transition_dates(j + 1)));
                        
                        v_previous_activity_sectors := t_sectors_working_hours();
                        v_previous_activity_sectors.extend;
                        v_previous_activity_sectors(v_previous_activity_sectors.last) := v_activity_sector_1;
                        v_previous_activity_sectors.extend;
                        v_previous_activity_sectors(v_previous_activity_sectors.last) := v_activity_sector_2;
                        
                        v_activity_sector_1 := '                    ';
                        v_activity_sector_2 := '                    ';
                    else
                        insert into zookeepers_distribution_history values(substr(v_activity_sector_1, 1, 10), x.cnp, 
                            t_working_hours(substr(v_activity_sector_1, 11, 5), substr(v_activity_sector_1, 16, 5)),
                            t_time(v_transition_dates(j), v_transition_dates(j + 1)));
                            
                        v_previous_activity_sectors := t_sectors_working_hours();
                        v_previous_activity_sectors.extend;
                        v_previous_activity_sectors(v_previous_activity_sectors.last) := v_activity_sector_1;
                        
                        v_activity_sector_1 := '                    ';
                    end if;
                end if;
            end loop;
        end if;
        
    end loop;
end;
/

drop function random_date_from_preceding_month;
/
drop function random_residing_intervals;
/
drop function random_sublist;
/
drop function random_transition_dates;
/
drop type t_sectors;
/
drop type t_residing_intervals;
/
drop type t_sectors_working_hours;
/
drop type t_dates;
/

/*
select * from animals order by to_number(substr(code, 2));
select am.animal_code, am.weight, am.height, a.birthday, am.measurement_date.start_time, am.measurement_date.end_time 
    from animals_measurements am join animals a on a.code = am.animal_code where animal_code = 'A301' order by am.measurement_date.start_time;
    
select * from sectors;
select * from zookeepers;

select * from animals_distribution order by to_number(substr(animal_code, 2));
select adh.animal_code, adh.sector_code, adh.residing_time.start_time, adh.residing_time.end_time from animals_distribution_history adh where adh.animal_code = 'A0';

select zd.sector_code, zd.zookeeper_cnp, zd.working_hours.start_hour, zd.working_hours.end_hour from zookeepers_distribution zd order by zd.zookeeper_cnp;
select zdh.sector_code, zdh.zookeeper_cnp, zdh.working_hours.start_hour, zdh.working_hours.end_hour,
    zdh.activity_time.start_time, zdh.activity_time.end_time from zookeepers_distribution_history zdh where zdh.zookeeper_cnp = '1950417564510';
*/