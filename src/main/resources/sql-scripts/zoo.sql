set serveroutput on
/

alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
alter session set nls_timestamp_format = 'DD-MON-YY HH:MI:SSXFF';
alter session set nls_timestamp_tz_format = 'DD-MON-YYYY HH24:MI:SS.FF TZH:TZM';
/

drop table animals_measurements;
/
drop table animals_distribution_history;
/
drop table zookeepers_distribution_history;
/
drop table animals_distribution;
/
drop table zookeepers_distribution;
/
drop table animals;
/
drop table deleted_animals;
/
drop table sectors;
/
drop table deleted_sectors;
/
drop table zookeepers;
/
drop table deleted_zookeepers;
/
drop type t_time;
/
drop type t_working_hours;
/

create type t_time is object (start_time date, end_time date);
/
create type t_working_hours is object (start_hour char(5), end_hour char(5));
/

create table animals (
    code char(10) primary key,
    name varchar2(50) not null,
    weight number(6, 2),
    height number(5, 2),
    birthday date not null,
    species varchar2(30) not null,
    breed varchar2(100),
    sex char(1),
    constraint check_sex check (sex in ('m', 'f'))
);
/
create table deleted_animals (
    code char(10) primary key,
    name varchar2(50) not null,
    weight number(6, 2),
    height number(5, 2),
    birthday date not null,
    species varchar2(30) not null,
    breed varchar2(100),
    sex char(1),
    constraint check_deleted_sex check (sex in ('m', 'f'))
);
/
create table sectors (
    code char(10) primary key,
    name varchar2(30) unique,
    area number(6, 2),
    capacity integer,
    constraint check_deleted_capacity check (capacity > 0 and capacity < 5001)
);
/
create table deleted_sectors (
    code char(10) primary key,
    name varchar2(30) unique,
    area number(6, 2),
    capacity integer,
    constraint check_capacity check (capacity > 0 and capacity < 5001)
);
/
create table zookeepers (
    cnp char(13) primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) unique,
    phone_number varchar(10) unique,
    role varchar(20),
    constraint check_role check (role in ('cleaner', 'feeder', 'trainer', 'surveiller', 'groomer'))
);
/
create table deleted_zookeepers (
    cnp char(13) primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) unique,
    phone_number varchar(10) unique,
    role varchar(20),
    constraint check_deleted_role check (role in ('cleaner', 'feeder', 'trainer', 'surveiller', 'groomer'))
);
/
create table animals_measurements (
    animal_code char(10) /*references animals(code)*/,
    weight number(6, 2),
    height number(5, 2),
    measurement_date t_time
);
/
create table animals_distribution (
    animal_code char(10),
    sector_code char(10),
    foreign key (animal_code) references animals(code) on delete cascade validate,
    foreign key (sector_code) references sectors(code) on delete cascade validate,
    constraint pk_animals_distribution primary key (animal_code, sector_code)
);
/
create table animals_distribution_history (
    animal_code char(10),
    sector_code char(10),
    residing_time t_time/*,
    foreign key fk_animals_link_sectors_history (animal_code, sector_code) references animals_distribution(animal_code, sector_code)*/
);
/
create table zookeepers_distribution (
    sector_code char(10),
    zookeeper_cnp char(13),
    working_hours t_working_hours,
    foreign key (sector_code) references sectors(code) on delete cascade validate,
    foreign key (zookeeper_cnp) references zookeepers(cnp) on delete cascade validate,
    constraint pk_zookeepers_distribution primary key (sector_code, zookeeper_cnp, working_hours.start_hour, working_hours.end_hour)
);
/
create table zookeepers_distribution_history (
    sector_code char(10),
    zookeeper_cnp char(13),
    working_hours t_working_hours,
    activity_time t_time/*,
    foreign key fk_sectors_link_zookeepers_history (sector_code, zookeeper_cnp) references zookeepers_distribution(sector_code, zookeeper_cnp)*/
);
/

-- insertions, updates and deletions on animals table will be reflected as history in animals_measurements table
drop trigger animals_trigger;
/
create or replace trigger animals_trigger
after insert or update or delete on animals
for each row
declare
    v_current_date date := current_date;
    v_weight number(6, 2);
    v_height number(5, 2);
begin
    if inserting then
        insert into animals_measurements values (:new.code, :new.weight, :new.height, t_time(current_date, null));
    elsif updating('weight') or updating('height') then 
        select am.weight, am.height into v_weight, v_height from animals_measurements am
            where am.animal_code = :old.code and am.measurement_date.end_time is null;
            
        if v_weight <> :new.weight or v_height <> :new.height then
            update animals_measurements am set am.measurement_date.end_time = v_current_date 
                where am.animal_code = :new.code and am.measurement_date.end_time is null;
            insert into animals_measurements values(:new.code, :new.weight, :new.height, t_time(v_current_date, null));
        end if;
    elsif deleting then
        update animals_measurements am set am.measurement_date.end_time = v_current_date
            where am.animal_code = :old.code and am.measurement_date.end_time is null;
    end if;
end;
/

-- in case of wrong CNP introduced, propagate the change over all tables
drop trigger zookeepers_trigger;
/
create or replace trigger zookeepers_trigger
after update on zookeepers
for each row
declare
begin
    if updating('cnp') then
        update zookeepers_distribution set zookeeper_cnp = :new.cnp where zookeeper_cnp = :old.cnp; 
    end if;
end;
/

-- insertions and deletions on animals_distribution table will be reflected as history in animals_distribution_history table
drop trigger animals_distribution_trigger;
/
create or replace trigger animals_distribution_trigger
after insert or delete on animals_distribution
for each row
declare
    v_current_date date := current_date;
begin
    if inserting then
        insert into animals_distribution_history values (:new.animal_code, :new.sector_code, t_time(current_date, null));
    elsif deleting then
        update animals_distribution_history adh set adh.residing_time.end_time = v_current_date
            where adh.animal_code = :old.animal_code and adh.sector_code = :old.sector_code and
                adh.residing_time.end_time is null;
    end if;
end;
/

-- insertions and deletions on zookeepers_distribution table will be reflected as history in zookeepers_distribution_history table
drop trigger zookeepers_distribution_trigger;
/
create or replace trigger zookeepers_distribution_trigger
after insert or update or delete on zookeepers_distribution
for each row
declare
    v_current_date date := current_date;
begin
    if inserting then
        insert into zookeepers_distribution_history values (:new.sector_code, :new.zookeeper_cnp, :new.working_hours, t_time(current_date, null));
    elsif deleting then
        update zookeepers_distribution_history zdh set zdh.activity_time.end_time = v_current_date
            where zdh.sector_code = :old.sector_code and zdh.zookeeper_cnp = :old.zookeeper_cnp and
                zdh.working_hours.start_hour = :old.working_hours.start_hour and 
                    zdh.working_hours.end_hour = :old.working_hours.end_hour and
                        zdh.activity_time.end_time is null;
    elsif updating('zookeeper_cnp') then
        update zookeepers_distribution_history zdh set zookeeper_cnp = :new.zookeeper_cnp where zookeeper_cnp = :old.zookeeper_cnp;
    end if;
end;
/

/*
insert into animals values('REP1', 'Repti', 80.15, 0.56, to_date('14-FEB-2018', 'DD-MON-YYYY'), 'crocodile', 'caiman', 'f');
update animals set weight = 80.15, height = 0.56 where code = 'REP1';
update animals set weight = 80.15, height = 1.23 where code = 'REP1';
update animals set weight = 70.15, height = 1.23 where code = 'REP1';
delete from animals where code = 'REP1';

select * from animals order by to_number(substr(trim(code), 2));
*/

/*
insert into animals values('REP1', 'Repti', 80.15, 0.56, to_date('14-FEB-2018', 'DD-MON-YYYY'), 'crocodile', 'caiman', 'f');
insert into sectors values('S1', 'Pool Area', 500.6, 100);
insert into animals_distribution values('REP1', 'S1');

select * from animals;
select * from sectors;
select * from animals_distribution;
select adh.animal_code, adh.sector_code, adh.residing_time.start_time, adh.residing_time.end_time from animals_distribution_history adh;

delete from animals where code = 'REP1';
*/

/*
insert into sectors values('S2', 'Cave Area', 789.25, 150);
insert into zookeepers values('2940121097720', 'Maria', 'Pop', 'p_maria@yahoo.com', '0756789345', 'groomer');
insert into zookeepers_distribution values('S2', '2940121097720', t_working_hours('17:00', '20:00'));
insert into zookeepers_distribution values('S2', '2940121097720', t_working_hours('20:00', '22:00'));

--update zookeepers set cnp = '2940121097721' where cnp = '2940121097720';

select * from sectors;
select * from zookeepers;
select zd.sector_code, zd.zookeeper_cnp, zd.working_hours.start_hour, zd.working_hours.end_hour from zookeepers_distribution zd;
select zdh.sector_code, zdh.zookeeper_cnp, zdh.working_hours.start_hour, zdh.working_hours.end_hour,
    zdh.activity_time.start_time, zdh.activity_time.end_time from zookeepers_distribution_history zdh;
    
--delete from zookeepers where cnp = '2940121097720'
*/