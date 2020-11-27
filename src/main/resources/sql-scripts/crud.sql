create or replace type t_animal is object (code char(10), name varchar2(50), weight number(6, 2), height number(5, 2), birthday date, species varchar2(30), breed varchar2(100), sex char(1));
/
create or replace type t_sector is object (code char(10), name varchar2(30), area number(6, 2), capacity integer);
/
create or replace type t_zookeeper is object (cnp char(13), first_name varchar(50), last_name varchar(50), email varchar(100), phone_number varchar(10), role varchar(20));
/
create or replace type t_animal_distribution is object (animal_code char(10), sector_code char(10));
/
create or replace type t_zookeeper_distribution is object (sector_code char(10), zookeeper_cnp char(13), working_hours t_working_hours);
/

create or replace package CRUD is
    unique_constraint_violated exception;
    pragma exception_init(unique_constraint_violated, -20001);
    not_null_constraint_violated exception;
    pragma exception_init(not_null_constraint_violated, -20002);
    absent_entity exception;
    pragma exception_init(absent_entity, -20003);
    invalid_data exception;
    pragma exception_init(invalid_data, -20004);
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20005);
    foreign_key_constraint_violated exception;
    pragma exception_init(foreign_key_constraint_violated, -20006);
    program_full exception;
    pragma exception_init(program_full, -20007);
    
    type t_animals is table of animals%rowtype;
    type t_sectors is table of sectors%rowtype;
    type t_zookeepers is table of zookeepers%rowtype;
    type t_animal_measurements is table of animals_measurements%rowtype;
    type t_animal_distribution_h is table of animals_distribution_history%rowtype;
    type t_zookeeper_distribution_h is table of zookeepers_distribution_history%rowtype;
    type t_codes is table of char(10);
    type t_cnps is table of char(13);
    
    procedure insert_animal(p_name in varchar2, p_weight in number, p_height in number, p_birthday in date, p_species in varchar2, p_breed in varchar2, p_sex in char, v_animal_object out t_animal);
    procedure delete_animal(p_code in char, v_animal_object out t_animal);
    procedure update_animal(p_code in char, p_name in varchar2, p_weight in number, p_height in number, p_birthday in date, p_species in varchar2, p_breed in varchar2, p_sex in char, v_animal_object out t_animal);
    
    procedure insert_sector(p_name in varchar2, p_area in number, p_capacity in integer, v_sector_object out t_sector);
    procedure delete_sector(p_code in char, v_sector_object out t_sector);
    procedure update_sector(p_code in char, p_name in varchar2, p_area in number, p_capacity in integer, v_sector_object out t_sector);
    
    procedure insert_zookeeper(p_cnp in char, p_first_name in varchar2, p_last_name in varchar2, p_email in varchar2, p_phone_number in varchar2, p_role in varchar2, v_zookeeper_object out t_zookeeper);
    procedure delete_zookeeper(p_cnp in char, v_zookeeper_object out t_zookeeper);
    procedure update_zookeeper(p_old_cnp in char, p_new_cnp in char, p_first_name in varchar2, p_last_name in varchar2, p_email in varchar2, p_phone_number in varchar2, p_role in varchar2, v_zookeeper_object out t_zookeeper);
    
    procedure let_animal_in_sector(p_animal_code in char, p_sector_code in char, v_animal_distribution_object out t_animal_distribution);
    procedure remove_animal_from_sector(p_animal_code in char, p_sector_code in char, v_animal_distribution_object out t_animal_distribution);
    procedure move_animal(p_animal_code in char, p_old_sector_code in char, p_new_sector_code in char, v_animal_distribution_object out t_animal_distribution);
    
    procedure insert_zookeeper_working_hours(p_zookeeper_cnp in char, p_sector_code in char, p_start_hour in char, p_end_hour in char, v_zookeeper_distribution_object out t_zookeeper_distribution);
    procedure remove_zookeeper_working_hours(p_zookeeper_cnp in char, p_sector_code in char, p_start_hour in char, p_end_hour in char, v_zookeeper_distribution_object out t_zookeeper_distribution);
    procedure change_zookeeper_working_program(p_zookeeper_cnp in char, p_old_sector_code in char, p_old_start_hour in char, p_old_end_hour in char, p_new_sector_code in char, p_new_start_hour in char, p_new_end_hour in char, v_zookeeper_distribution_object out t_zookeeper_distribution);

    function read_animals return sys_refcursor;
    function read_animal_codes return sys_refcursor;
    function read_animal(p_code char) return t_animal;
    function read_animal_measurements(p_code char) return sys_refcursor;
    function read_animal_distribution(p_code char) return sys_refcursor;
    
    function read_zookeepers return sys_refcursor;
    function read_zookeeper_cnps return sys_refcursor;
    function read_zookeeper(p_cnp char) return t_zookeeper;
    function read_zookeeper_distribution(p_cnp char) return sys_refcursor;
    
    function read_sectors return sys_refcursor;
    function read_sector_codes return sys_refcursor;
    function read_sector(p_code char) return t_sector;

end CRUD;
/

create or replace package body CRUD is

    function is_valid_cnp(p_cnp char) return integer as
        v_boolean integer;
        v_date date;
    begin
        select case when regexp_like (p_cnp, '^[1-8][0-9]{12}$') then 1 else 0 end into v_boolean from dual;
        if v_boolean = 0 then
            return 0;
        else
            select to_date('19' || (substr(p_cnp, 2, 2) || '-' || substr(p_cnp, 4, 2) || '-' || substr(p_cnp, 6, 2)), 'YYYY-MM-DD') into v_date from dual;
            return 1;
        end if;
        
        exception 
            when others then 
                return 0;
    end is_valid_cnp;
    
    function is_valid_email(p_email varchar2) return integer as
        v_boolean integer;
    begin
        select case when regexp_like (p_email, '^[A-Za-z]+[A-Za-z0-9._]+@[A-Za-z0-9]+\.[A-Za-z]{2,4}$') then 1 else 0 end into v_boolean from dual;
        return v_boolean;
    end is_valid_email;
    
    function is_valid_phone_number(p_phone_number varchar2) return integer as
        v_boolean integer;
    begin
        select case when regexp_like (p_phone_number, '^07[0-9]{8}$') then 1 else 0 end into v_boolean from dual;
        return v_boolean;
    end is_valid_phone_number;

    procedure insert_animal(p_name in varchar2, p_weight in number, p_height in number, p_birthday in date, p_species in varchar2, p_breed in varchar2, p_sex in char, v_animal_object out t_animal) as
        v_code char(10);
        v_animal animals%rowtype;
    begin
        if p_weight <= 0.0 or p_height <= 0.0 then
            raise_application_error(-20004, 'Weight/height needs to be positive non zero!');
        end if;
    
        case p_species
            when 'mammal' then
                select rpad('A' || to_char(nvl(max(to_number(substr(code, 2))) + 1, 0)), 10, ' ') into v_code from (select code from animals union select code from deleted_animals) where to_number(substr(code, 2)) < 2000;
            when 'reptile' then
                select rpad('A' || to_char(nvl(max(to_number(substr(code, 2))) + 1, 2000)), 10, ' ') into v_code from (select code from animals union select code from deleted_animals) where to_number(substr(code, 2)) < 3000;
            when 'bird' then
                select rpad('A' || to_char(nvl(max(to_number(substr(code, 2))) + 1, 3000)), 10, ' ') into v_code from (select code from animals union select code from deleted_animals) where to_number(substr(code, 2)) < 5000;
            when 'amphibian' then
                select rpad('A' || to_char(nvl(max(to_number(substr(code, 2))) + 1, 5000)), 10, ' ') into v_code from (select code from animals union select code from deleted_animals) where to_number(substr(code, 2)) < 6000;
            else
                select rpad('A' || to_char(nvl(max(to_number(substr(code, 2))) + 1, 6000)), 10, ' ') into v_code from (select code from animals union select code from deleted_animals) where to_number(substr(code, 2)) < 7000;
        end case;
    
        execute immediate 'insert into animals values(:1, :2, :3, :4, :5, :6, :7, :8)' using v_code, p_name, p_weight, p_height, p_birthday, p_species, p_breed, p_sex;
        
        select * into v_animal from animals where code = v_code;
        v_animal_object := t_animal(v_animal.code, v_animal.name, v_animal.weight, v_animal.height, v_animal.birthday, v_animal.species, v_animal.breed, v_animal.sex);
        
        exception
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2290 then
                    raise_application_error(-20005, 'Check constraint violated! Sex needs to be ''m'' or ''f''!');
                else
                    raise;
                end if;
    end insert_animal;
    
    procedure delete_animal(p_code in char, v_animal_object out t_animal) as
        v_animal animals%rowtype;
    begin
        execute immediate 'select * from animals where code = :1' into v_animal using p_code;
        
        insert into deleted_animals values(v_animal.code, v_animal.name, v_animal.weight, v_animal.height, v_animal.birthday, v_animal.species, v_animal.breed, v_animal.sex);
        
        execute immediate 'delete from animals where code = :1' using p_code;
        
        v_animal_object := t_animal(v_animal.code, v_animal.name, v_animal.weight, v_animal.height, v_animal.birthday, v_animal.species, v_animal.breed, v_animal.sex);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be deleted was not found!');
    end delete_animal;
    
    procedure update_animal(p_code in char, p_name in varchar2, p_weight in number, p_height in number, p_birthday in date, p_species in varchar2, p_breed in varchar2, p_sex in char, v_animal_object out t_animal) as
        v_animal animals%rowtype;
    begin
        if p_weight <= 0.0 or p_height <= 0.0 then
            raise_application_error(-20004, 'Weight/height needs to be positive non zero!');
        end if;
        
        execute immediate 'select * from animals where code = :1' into v_animal using p_code;
        
        execute immediate 'update animals set name = :1, weight = :2, height = :3, birthday = :4, species = :5, breed = :6, sex = :7 where code = :8' 
            using p_name, p_weight, p_height, p_birthday, p_species, p_breed, p_sex, p_code;
        
        execute immediate 'select * from animals where code = :1' into v_animal using p_code;
        v_animal_object := t_animal(v_animal.code, v_animal.name, v_animal.weight, v_animal.height, v_animal.birthday, v_animal.species, v_animal.breed, v_animal.sex);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be updated was not found!');
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2290 then
                    raise_application_error(-20005, 'Check constraint violated! Sex needs to be ''m'' or ''f''!');
                else
                    raise;
                end if;
    end update_animal;
    
    
    
    procedure insert_sector(p_name in varchar2, p_area in number, p_capacity in integer, v_sector_object out t_sector) as
        v_code char(10);
        v_sector sectors%rowtype;
    begin
        if p_area <= 0.0 then
            raise_application_error(-20004, 'Area needs to be positive non zero!');
        end if;
    
        select rpad('S' || to_char(nvl(max(to_number(substr(code, 2))) + 1, 0)), 10, ' ') into v_code from (select code from sectors union select code from deleted_sectors);
        
        execute immediate 'insert into sectors values(:1, :2, :3, :4)' using v_code, p_name, p_area, p_capacity;
        
        select * into v_sector from sectors where code = v_code;
        v_sector_object := t_sector(v_sector.code , v_sector.name , v_sector.area , v_sector.capacity);
        
        exception
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2290 then
                    raise_application_error(-20005, 'Check constraint violated! Caspacity needs to be between 0 and 5000!');
                else
                    raise;
                end if;
    end insert_sector;
    
    procedure delete_sector(p_code in char, v_sector_object out t_sector) as
        v_sector sectors%rowtype;
    begin
        execute immediate 'select * from sectors where code = :1' into v_sector using p_code;
        
        insert into deleted_sectors values(v_sector.code, v_sector.name, v_sector.area, v_sector.capacity);
        
        execute immediate 'delete from sectors where code = :1' using p_code;
        
        v_sector_object := t_sector(v_sector.code , v_sector.name , v_sector.area , v_sector.capacity);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20001, 'The sector to be deleted was not found!');
    end delete_sector;
    
    procedure update_sector(p_code in char, p_name in varchar2, p_area in number, p_capacity in integer, v_sector_object out t_sector) as
        v_sector sectors%rowtype;
    begin
        if p_area <= 0.0 then
            raise_application_error(-20004, 'Area needs to be positive non zero!');
        end if;
        
        execute immediate 'select * from sectors where code = :1' into v_sector using p_code;
        
        execute immediate 'update sectors set name = :1, area = :2, capacity = :3 where code = :4' 
            using p_name, p_area, p_capacity, p_code;
        
        execute immediate 'select * from sectors where code = :1' into v_sector using p_code;
        v_sector_object := t_sector(v_sector.code , v_sector.name , v_sector.area , v_sector.capacity);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The sector to be updated was not found!');
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2290 then
                    raise_application_error(-20005, 'Check constraint violated! Capacity needs to be between 0 and 5000!');
                else
                    raise;
                end if;
    end update_sector;
    
    
    
    procedure insert_zookeeper(p_cnp in char, p_first_name in varchar2, p_last_name in varchar2, p_email in varchar2, p_phone_number in varchar2, p_role in varchar2, v_zookeeper_object out t_zookeeper) as
        v_zookeeper zookeepers%rowtype;
    begin
        if CRUD.is_valid_cnp(p_cnp) = 0 then
            raise_application_error(-20004, 'Invalid CNP!');
        end if;
        if CRUD.is_valid_email(p_email) = 0 then
            raise_application_error(-20004, 'Invalid email!');
        end if;
        if CRUD.is_valid_phone_number(p_phone_number) = 0 then
            raise_application_error(-20004, 'Invalid phone number!');
        end if;
    
        execute immediate 'insert into zookeepers values(:1, :2, :3, :4, :5, :6)' using p_cnp, p_first_name, p_last_name, p_email, p_phone_number, p_role;
        
        execute immediate 'select * from zookeepers where cnp = :1' into v_zookeeper using p_cnp;
        v_zookeeper_object := t_zookeeper(v_zookeeper.cnp, v_zookeeper.first_name, v_zookeeper.last_name, v_zookeeper.email, v_zookeeper.phone_number, v_zookeeper.role);
        
        exception
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2290 then
                    raise_application_error(-20005, 'Check constraint violated! Invalid role name!');
                else
                    raise;
                end if;
    end insert_zookeeper;
    
    procedure delete_zookeeper(p_cnp in char, v_zookeeper_object out t_zookeeper) as
        v_zookeeper zookeepers%rowtype;
    begin
        execute immediate 'select * from zookeepers where cnp = :1' into v_zookeeper using p_cnp;
        
        insert into deleted_zookeepers values(v_zookeeper.cnp, v_zookeeper.first_name, v_zookeeper.last_name, v_zookeeper.email, v_zookeeper.phone_number, v_zookeeper.role);
        
        execute immediate 'delete from zookeepers where cnp = :1' using p_cnp;
        
        v_zookeeper_object := t_zookeeper(v_zookeeper.cnp, v_zookeeper.first_name, v_zookeeper.last_name, v_zookeeper.email, v_zookeeper.phone_number, v_zookeeper.role);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20001, 'The zookeeper to be deleted was not found!');
    end delete_zookeeper;
    
    procedure update_zookeeper(p_old_cnp in char, p_new_cnp in char, p_first_name in varchar2, p_last_name in varchar2, p_email in varchar2, p_phone_number in varchar2, p_role in varchar2, v_zookeeper_object out t_zookeeper) as
        v_zookeeper zookeepers%rowtype;
    begin
        if is_valid_cnp(p_new_cnp) = 0 then
            raise_application_error(-20004, 'Invalid CNP!');
        end if;
        if is_valid_email(p_email) = 0 then
            raise_application_error(-20004, 'Invalid email!');
        end if;
        if is_valid_phone_number(p_phone_number) = 0 then
            raise_application_error(-20004, 'Invalid phone number!');
        end if;
        
        execute immediate 'select * from zookeepers where cnp = :1' into v_zookeeper using p_old_cnp;
        
        execute immediate 'update zookeepers set cnp = :1, first_name = :2, last_name = :3, email = :4, phone_number = :5, role = :6 where cnp = :7' 
            using p_new_cnp, p_first_name, p_last_name, p_email, p_phone_number, p_role, p_old_cnp;
        
        execute immediate 'select * from zookeepers where cnp = :1' into v_zookeeper using p_new_cnp;
        v_zookeeper_object := t_zookeeper(v_zookeeper.cnp, v_zookeeper.first_name, v_zookeeper.last_name, v_zookeeper.email, v_zookeeper.phone_number, v_zookeeper.role);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The zookeeper to be updated was not found!');
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2290 then
                    raise_application_error(-20005, 'Check constraint violated! Invalid role name!');
                else
                    raise;
                end if;
    end update_zookeeper;
    
    
    
    
    
    procedure let_animal_in_sector(p_animal_code in char, p_sector_code in char, v_animal_distribution_object out t_animal_distribution) as
        v_animal_distribution animals_distribution%rowtype;
    begin
        execute immediate 'insert into animals_distribution values(:1, :2)' using p_animal_code, p_sector_code;
        
        execute immediate 'select * from animals_distribution where animal_code = :1 and sector_code = :2' into v_animal_distribution using p_animal_code, p_sector_code;
        v_animal_distribution_object := t_animal_distribution(v_animal_distribution.animal_code, v_animal_distribution.sector_code);
        
        exception
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2291 then
                    raise_application_error(-20006, 'Foreign key constraint violated! Non existent animal or sector!');
                else
                    raise;
                end if;
    end let_animal_in_sector;
    
    procedure remove_animal_from_sector(p_animal_code in char, p_sector_code in char, v_animal_distribution_object out t_animal_distribution) as
        v_animal_distribution animals_distribution%rowtype;
    begin
        execute immediate 'select * from animals_distribution where animal_code = :1 and sector_code = :2' into v_animal_distribution using p_animal_code, p_sector_code;
        
        execute immediate 'delete from animals_distribution where animal_code = :1 and sector_code = :2' using p_animal_code, p_sector_code;
        
        v_animal_distribution_object := t_animal_distribution(v_animal_distribution.animal_code, v_animal_distribution.sector_code);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20001, 'The animal-sector to be deleted was not found!');
    end remove_animal_from_sector;
    
    procedure move_animal(p_animal_code in char, p_old_sector_code in char, p_new_sector_code in char, v_animal_distribution_object out t_animal_distribution) as
        v_animal_distribution animals_distribution%rowtype;
    begin
        if p_old_sector_code = p_new_sector_code then
            raise_application_error(-20004, 'Cannot move the animal in it''s current sector!');
        end if;
        
        execute immediate 'select * from animals_distribution where animal_code = :1 and sector_code = :2' into v_animal_distribution using p_animal_code, p_old_sector_code;
        
        execute immediate 'delete from animals_distribution where animal_code = :1 and sector_code = :2' using p_animal_code, p_old_sector_code;
        
        execute immediate 'insert into animals_distribution values(:1, :2)' using p_animal_code, p_new_sector_code;
        
        execute immediate 'select * from animals_distribution where animal_code = :1 and sector_code = :2' into v_animal_distribution using p_animal_code, p_new_sector_code;
        v_animal_distribution_object := t_animal_distribution(v_animal_distribution.animal_code, v_animal_distribution.sector_code);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20001, 'The former animal or sector was not found!');
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2291 then
                    raise_application_error(-20006, 'Foreign key constraint violated! Non existent sector!');
                else
                    raise;
                end if;
    end move_animal;





    procedure insert_zookeeper_working_hours(p_zookeeper_cnp in char, p_sector_code in char, p_start_hour in char, p_end_hour in char, v_zookeeper_distribution_object out t_zookeeper_distribution) as
        v_zookeeper_distribution zookeepers_distribution%rowtype;
        v_nr_working_programs integer;
        v_sector_code char(10);
        v_start_hour char(5);
        v_end_hour char(5);
    begin
        execute immediate 'select count(*) from zookeepers_distribution where zookeeper_cnp = :1' into v_nr_working_programs using p_zookeeper_cnp;
        if v_nr_working_programs = 2 then
            raise_application_error(-20007, 'This zookeeper already has full time program! No more working hours can be added!');
        elsif v_nr_working_programs = 1 then
            execute immediate 'select sector_code, zd.working_hours.start_hour, zd.working_hours.end_hour from zookeepers_distribution zd where zookeeper_cnp = :1' 
                into v_sector_code, v_start_hour, v_end_hour using p_zookeeper_cnp;
            if v_start_hour = p_start_hour and v_end_hour = p_end_hour then 
                raise_application_error(-20004, 'Cannot overlap working hours!');
            end if;
        end if;
    
        execute immediate 'insert into zookeepers_distribution values(:1, :2, :3)' using p_sector_code, p_zookeeper_cnp, t_working_hours(p_start_hour, p_end_hour);
        
        execute immediate 'select * from zookeepers_distribution zd where sector_code = :1 and zookeeper_cnp = :2 and zd.working_hours.start_hour = :3
            and zd.working_hours.end_hour = :4' into v_zookeeper_distribution using p_sector_code, p_zookeeper_cnp, p_start_hour, p_end_hour;
        v_zookeeper_distribution_object := t_zookeeper_distribution(v_zookeeper_distribution.sector_code, v_zookeeper_distribution.zookeeper_cnp, v_zookeeper_distribution.working_hours);
        
        exception
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2291 then
                    raise_application_error(-20006, 'Foreign key constraint violated! Non existent zookeeper or sector!');
                else
                    raise;
                end if;
    end insert_zookeeper_working_hours;
    
    procedure remove_zookeeper_working_hours(p_zookeeper_cnp in char, p_sector_code in char, p_start_hour in char, p_end_hour in char, v_zookeeper_distribution_object out t_zookeeper_distribution) as
        v_zookeeper_distribution zookeepers_distribution%rowtype;
    begin
        execute immediate 'select * from zookeepers_distribution zd where sector_code = :1 and zookeeper_cnp = :2 and zd.working_hours.start_hour = :3
            and zd.working_hours.end_hour = :4' into v_zookeeper_distribution using p_sector_code, p_zookeeper_cnp, p_start_hour, p_end_hour;
        
        execute immediate 'delete from zookeepers_distribution zd where sector_code = :1 and zookeeper_cnp = :2 and zd.working_hours.start_hour = :3
            and zd.working_hours.end_hour = :4' using p_sector_code, p_zookeeper_cnp, p_start_hour, p_end_hour;
        
        v_zookeeper_distribution_object := t_zookeeper_distribution(v_zookeeper_distribution.sector_code, v_zookeeper_distribution.zookeeper_cnp, v_zookeeper_distribution.working_hours);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20001, 'The zookeeper-sector to be deleted was not found!');
    end remove_zookeeper_working_hours;
    
    procedure change_zookeeper_working_program(p_zookeeper_cnp in char, p_old_sector_code in char, p_old_start_hour in char, p_old_end_hour in char, p_new_sector_code in char, p_new_start_hour in char, p_new_end_hour in char, v_zookeeper_distribution_object out t_zookeeper_distribution) as
    begin
        if p_old_sector_code = p_new_sector_code and p_old_start_hour = p_new_start_hour and p_old_end_hour = p_new_end_hour then 
            raise_application_error(-20004, 'Redundant change of working program!');
        end if;
            
        CRUD.remove_zookeeper_working_hours(p_zookeeper_cnp, p_old_sector_code, p_old_start_hour, p_old_end_hour, v_zookeeper_distribution_object);
        CRUD.insert_zookeeper_working_hours(p_zookeeper_cnp, p_new_sector_code, p_new_start_hour, p_new_end_hour, v_zookeeper_distribution_object);
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20001, 'The former zookeeper or sector program was not found!');
            when DUP_VAL_ON_INDEX then
                raise_application_error(-20001, 'Unique constraint violated!');
            when others then
                if sqlcode = -1400 then
                    raise_application_error(-20002, 'Not null constraint violated!');
                elsif sqlcode = -2291 then
                    raise_application_error(-20006, 'Foreign key constraint violated! Non existent sector!');
                else
                    raise;
                end if;
    end change_zookeeper_working_program;





    function read_animals return sys_refcursor as
        /*v_animals t_animals := t_animals();
        cursor c_animals is select * from animals order by to_number(trim(substr(code, 2)));
        x c_animals%rowtype;*/
        v_animals sys_refcursor;
    begin
        /*for x in c_animals loop
            v_animals.extend;
            v_animals(v_animals.last) := x;
        end loop;
        return v_animals;*/
        open v_animals for 
            select * from animals order by to_number(trim(substr(code, 2)));
        return v_animals;
    end read_animals; 
    
    function read_animal_codes return sys_refcursor as
        /*v_animal_codes t_codes := t_codes();
        cursor c_animal_codes is select code from animals order by to_number(trim(substr(code, 2)));
        x c_animal_codes%rowtype;*/
        v_animal_codes sys_refcursor;
    begin
        /*for x in c_animal_codes loop
            v_animal_codes.extend;
            v_animal_codes(v_animal_codes.last) := x.code;
        end loop;
        return v_animal_codes;*/
        open v_animal_codes for 
            select code from animals order by to_number(trim(substr(code, 2)));
        return v_animal_codes;
    end read_animal_codes;
    
    function read_animal(p_code char) return t_animal as
        v_animal animals%rowtype;
        v_animal_object t_animal;
    begin
        execute immediate 'select * from animals where code = :1' into v_animal using p_code;
        v_animal_object := t_animal(v_animal.code, v_animal.name, v_animal.weight, v_animal.height, v_animal.birthday, v_animal.species, v_animal.breed, v_animal.sex);
        return v_animal_object;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end read_animal;
    
    function read_animal_measurements(p_code char) return sys_refcursor as
        v_animal_measurements t_animal_measurements := t_animal_measurements();
        v_animal_measurement animals_measurements%rowtype;
        type t_c_animal_measurements is ref cursor;
        v_c_animal_measurements t_c_animal_measurements;
    begin
          open v_c_animal_measurements for 'select * from animals_measurements am where animal_code = :1 order by am.measurement_date.end_time desc nulls first' using p_code;

          /*loop
            fetch v_c_animal_measurements INTO v_animal_measurement;
            v_animal_measurements.extend;
            v_animal_measurements(v_animal_measurements.last) := v_animal_measurement;
            exit when v_c_animal_measurements%notfound;
          end loop;
        
          close v_c_animal_measurements;
    
        return v_animal_measurements;*/
        
        return v_c_animal_measurements;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end read_animal_measurements;
    
    function read_animal_distribution(p_code char) return sys_refcursor as
        v_animal_distribution t_animal_distribution_h := t_animal_distribution_h();
        v_animal_sector animals_distribution_history%rowtype;
        type t_c_animal_distribution is ref cursor;
        v_c_animal_distribution t_c_animal_distribution;
    begin
          open v_c_animal_distribution for 'select * from animals_distribution_history adh where animal_code = :1 order by adh.residing_time.end_time desc nulls first, to_number(trim(substr(adh.sector_code, 2)))' using p_code;

          /*loop
            fetch v_c_animal_distribution INTO v_animal_sector;
            v_animal_distribution.extend;
            v_animal_distribution(v_animal_distribution.last) := v_animal_sector;
            exit when v_c_animal_distribution%notfound;
          end loop;
        
          close v_c_animal_distribution;
    
        return v_animal_distribution;*/
        
        return v_c_animal_distribution;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end read_animal_distribution;
    
    
    function read_zookeepers return sys_refcursor as
        /*v_zookeepers t_zookeepers := t_zookeepers();
        cursor c_zookeepers is select * from zookeepers order by last_name, first_name, cnp;
        x c_zookeepers%rowtype;*/
        v_zookeepers sys_refcursor;
    begin
        /*for x in c_zookeepers loop
            v_zookeepers.extend;
            v_zookeepers(v_zookeepers.last) := x;
        end loop;
        return v_zookeepers;*/
        open v_zookeepers for 
            select * from zookeepers order by last_name, first_name, cnp;
        return v_zookeepers;
    end read_zookeepers;
    
    function read_zookeeper_cnps return sys_refcursor as
        /*v_cnps t_cnps := t_cnps();
        cursor c_zookeepers_cnps is select cnp from zookeepers order by last_name, first_name, cnp;
        x c_zookeepers_cnps%rowtype;*/
        v_cnps sys_refcursor;
    begin
        /*for x in c_zookeepers_cnps loop
            v_cnps.extend;
            v_cnps(v_cnps.last) := x.cnp;
        end loop;
        return v_cnps;*/
        open v_cnps for 
            select cnp from zookeepers order by last_name, first_name, cnp;
        return v_cnps;
    end read_zookeeper_cnps;
    
    function read_zookeeper(p_cnp char) return t_zookeeper as
        v_zookeeper zookeepers%rowtype;
        v_zookeeper_object t_zookeeper;
    begin
        execute immediate 'select * from zookeepers where cnp = :1' into v_zookeeper using p_cnp;
        v_zookeeper_object := t_zookeeper(v_zookeeper.cnp, v_zookeeper.first_name, v_zookeeper.last_name, v_zookeeper.email, v_zookeeper.phone_number, v_zookeeper.role);
        return v_zookeeper_object;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The zookeeper to be read was not found by the provided code!');
    end read_zookeeper;
    
    function read_zookeeper_distribution(p_cnp char) return sys_refcursor as
        v_zookeeper_distribution t_zookeeper_distribution_h := t_zookeeper_distribution_h();
        v_zookeeper_sector zookeepers_distribution_history%rowtype;
        type t_c_zookeeper_distribution is ref cursor;
        v_c_zookeeper_distribution t_c_zookeeper_distribution;
    begin
          open v_c_zookeeper_distribution for 'select * from zookeepers_distribution_history zdh where zookeeper_cnp = :1 order by zdh.activity_time.end_time desc nulls first, to_number(trim(substr(zdh.sector_code, 2)))' using p_cnp;

          /*loop
            fetch v_c_zookeeper_distribution INTO v_zookeeper_sector;
            v_zookeeper_distribution.extend;
            v_zookeeper_distribution(v_zookeeper_distribution.last) := v_zookeeper_sector;
            exit when v_c_zookeeper_distribution%notfound;
          end loop;
        
          close v_c_zookeeper_distribution;
    
        return v_zookeeper_distribution;*/
        
        return v_c_zookeeper_distribution;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The zookeeper to be read was not found by the provided code!');
    end read_zookeeper_distribution;
    
    
    function read_sectors return sys_refcursor as
        /*v_sectors t_sectors := t_sectors();
        cursor c_sectors is select * from sectors order by to_number(trim(substr(code, 2)));
        x c_sectors%rowtype;*/
        v_sectors sys_refcursor;
    begin
        /*for x in c_sectors loop
            v_sectors.extend;
            v_sectors(v_sectors.last) := x;
        end loop;
        return v_sectors;*/
        open v_sectors for 
            select * from sectors order by to_number(trim(substr(code, 2)));
        return v_sectors;
    end read_sectors;
    
    function read_sector_codes return sys_refcursor as
        /*v_sector_codes t_codes := t_codes();
        cursor c_sector_codes is select code from sectors order by to_number(trim(substr(code, 2)));
        x c_sector_codes%rowtype;*/
        v_sector_codes sys_refcursor;
    begin
        /*for x in c_sector_codes loop
            v_sector_codes.extend;
            v_sector_codes(v_sector_codes.last) := x.code;
        end loop;
        return v_sector_codes;*/
        open v_sector_codes for 
            select code from sectors order by to_number(trim(substr(code, 2)));
        return v_sector_codes;
    end read_sector_codes;
    
    function read_sector(p_code char) return t_sector as
        v_sector sectors%rowtype;
        v_sector_object t_sector;
    begin
        execute immediate 'select * from sectors where code = :1' into v_sector using p_code;
        v_sector_object := t_sector(v_sector.code , v_sector.name , v_sector.area , v_sector.capacity);
        return v_sector_object;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The sector to be read was not found by the provided code!');
    end read_sector;
    
end CRUD;
/

declare
    v_animal animals%rowtype;
    v_sector sectors%rowtype;
    v_zookeeper zookeepers%rowtype;
    v_animal_distribution animals_distribution%rowtype;
    v_zookeeper_distribution zookeepers_distribution%rowtype;
    
    v_animals CRUD.t_animals := CRUD.t_animals();
    v_sectors CRUD.t_sectors := CRUD.t_sectors();
    v_zookeepers CRUD.t_zookeepers := CRUD.t_zookeepers();
    v_animal_measurements CRUD.t_animal_measurements := CRUD.t_animal_measurements();
    v_animal_distribution_history CRUD.t_animal_distribution_h := CRUD.t_animal_distribution_h();
    v_zookeeper_distribution_history CRUD.t_zookeeper_distribution_h := CRUD.t_zookeeper_distribution_h();
    v_codes CRUD.t_codes := CRUD.t_codes();
begin
    --v_animal := CRUD.insert_animal('Momo', 15.15, 0.75, to_date('14-FEB-2018', 'DD-MON-YYYY'), 'mammal', 'monkey', 'm');
    --v_animal := CRUD.update_animal('A6000', 'Reptil', 80.4, 0.55, to_date('14-FEB-2018', 'DD-MON-YYYY'), 'crocodile', 'caiman', 'f');
    --v_animal := CRUD.delete_animal('A6000');
    
    --v_sector := CRUD.insert_sector('Cave Area', 789.25, 150);
    --v_sector := CRUD.insert_sector('Aquarium', 458.16, 500);
    --v_sector := CRUD.update_sector('S0', 'Cave Area', 789.26, 150);
    --v_sector := CRUD.delete_sector('S0');
    
    --v_zookeeper := CRUD.insert_zookeeper('2940121097720', 'Maria', 'Pop', 'p_maria@yahoo.com', '0756789345', 'groomer');
    --v_zookeeper := CRUD.update_zookeeper ('2940121097720', '2940121097721', 'Maria', 'Pop', 'pop_maria@yahoo.com', '0756789345', 'groomer');
    --v_zookeeper := CRUD.delete_zookeeper('2940121097721');
    
    --v_animal_distribution := CRUD.let_animal_in_sector('A0', 'S0');
    --v_animal_distribution := CRUD.remove_animal_from_sector('A0', 'S0');
    --v_animal_distribution := CRUD.move_animal('A0', 'S0', 'S1');
    
    --v_zookeeper_distribution := CRUD.insert_zookeeper_working_hours('2940121097720', 'S0', '06:00', '10:00');
    --v_zookeeper_distribution := CRUD.insert_zookeeper_working_hours('2940121097720', 'S0', '10:00', '14:00');
    --v_zookeeper_distribution := CRUD.remove_zookeeper_working_hours('2940121097720', 'S0', '06:00', '10:00');
    --v_zookeeper_distribution := CRUD.change_zookeeper_working_program('2940121097720', 'S0', '10:00', '14:00', 'S0', '10:00', '14:00');
    
    --dbms_output.enable;
    --dbms_output.put_line(v_animal.code);
    --dbms_output.put_line(v_animal.name);
    --dbms_output.put_line(v_animal.weight);
    --dbms_output.put_line(v_animal.height);
    
    --dbms_output.enable;
    --dbms_output.put_line(v_sector.code);
    --dbms_output.put_line(v_sector.name);
    
    --dbms_output.enable;
    --dbms_output.put_line(v_zookeeper.cnp);
    --dbms_output.put_line(v_zookeeper.first_name);
    
    --dbms_output.enable;
    --dbms_output.put_line(v_animal_distribution.animal_code);
    --dbms_output.put_line(v_animal_distribution.sector_code);
    
    --dbms_output.enable;
    --dbms_output.put_line(v_animal_distribution.animal_code);
    --dbms_output.put_line(v_animal_distribution.sector_code);
    
    --dbms_output.enable;
    --dbms_output.put_line(v_zookeeper_distribution.zookeeper_cnp);
    --dbms_output.put_line(v_zookeeper_distribution.sector_code);
    --dbms_output.put_line(v_zookeeper_distribution.working_hours.start_hour);
    --dbms_output.put_line(v_zookeeper_distribution.working_hours.end_hour);
    
    /*
    v_animals := CRUD.read_animals;
    for i in 1..v_animals.count loop
        dbms_output.put_line(v_animals(i).code || ' ' || v_animals(i).name);
    end loop;
    */
    
    /*
    v_codes := CRUD.read_animal_codes;
    for i in 1..v_codes.count loop
        dbms_output.put_line(v_codes(i));
    end loop;
    */
    
    /*
    v_animal := CRUD.read_animal('A2002');
    dbms_output.put_line(v_animal.code || ' ' || v_animal.name);
    */
    
    /*
    v_animal_measurements := CRUD.read_animal_measurements('A10');
    for i in 1..v_animal_measurements.count loop
        dbms_output.put_line(v_animal_measurements(i).animal_code || ' ' || v_animal_measurements(i).weight || ' ' || v_animal_measurements(i).height
            || ' ' || v_animal_measurements(i).measurement_date.start_time || ' ' || v_animal_measurements(i).measurement_date.end_time);
    end loop;
    */
    
    /*
    v_animal_distribution_history := CRUD.read_animal_distribution('A10');
    for i in 1..v_animal_distribution_history.count loop
        dbms_output.put_line(v_animal_distribution_history(i).animal_code || ' ' || v_animal_distribution_history(i).sector_code
            || ' ' || v_animal_distribution_history(i).residing_time.start_time || ' ' || v_animal_distribution_history(i).residing_time.end_time);
    end loop;
    */
    
    null;
end;
/

--select * from animals;
--select am.measurement_date.start_time, am.measurement_date.end_time from animals_measurements am;

--select * from sectors;
--select * from zookeepers;

--select * from animals_distribution;
--select adh.animal_code, adh.sector_code, adh.residing_time.start_time, adh.residing_time.end_time from animals_distribution_history adh;

--select zd.sector_code, zd.zookeeper_cnp, zd.working_hours.start_hour, zd.working_hours.end_hour from zookeepers_distribution zd;
--select zdh.sector_code, zdh.zookeeper_cnp, zdh.working_hours.start_hour, zdh.working_hours.end_hour,
--    zdh.activity_time.start_time, zdh.activity_time.end_time from zookeepers_distribution_history zdh;