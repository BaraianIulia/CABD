create or replace package RAPOARTE is
    absent_entity exception;
    pragma exception_init(absent_entity, -20003);

    function current_animal(p_code char) return sys_refcursor;
    function sometime_animal(p_code char, desired_date char) return sys_refcursor;
    function longest_maxim_height(p_code char) return sys_refcursor;
    function variation_height(p_code char) return sys_refcursor;

end RAPOARTE;

create or replace package body RAPOARTE is
    
    function current_animal(p_code char) return sys_refcursor as
        v_current sys_refcursor;
    begin
        open v_current for 'SELECT * FROM animals WHERE code=:1' using p_code;
        return v_current;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end current_animal;
    
    function sometime_animal(p_code char, desired_date char) return sys_refcursor as
        v_sometime sys_refcursor;
    begin
        open v_sometime for 'SELECT *
                                FROM animals_measurements am
                                WHERE am.animal_code=''' || p_code || ''' AND am.measurement_date.start_time <= TO_TIMESTAMP(''' || TO_CHAR(desired_date) || ''', ''DD-MM-YY HH24:MI:SS'') AND (am.measurement_date.end_time >= TO_TIMESTAMP(''' || TO_CHAR(desired_date) || ''', ''DD-MM-YY HH24:MI:SS'') OR am.measurement_date.end_time IS NULL)';
        return v_sometime;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end sometime_animal;
    
    function longest_maxim_height(p_code char) return sys_refcursor as
        v_maxim sys_refcursor;
    begin
        open v_maxim for 'WITH animalsdetails AS(
                        SELECT animal_code, am.measurement_date.start_time as startt, (CASE WHEN am.measurement_date.end_time IS null THEN (SELECT SYSDATE FROM dual) ELSE am.measurement_date.end_time END ) as endt,height
                        FROM animals_measurements am)
                        SELECT *
                        FROM animalsdetails MATCH_RECOGNIZE (
                             PARTITION BY animal_code
                             ORDER BY startt
                             MEASURES LAST(creste.startt) AS startc, LAST(endt) AS endc, 24*(LAST(endt)-LAST(creste.startt)) AS nr_ore,
                                     LAST(creste.height) as HEIGHT
                             ONE ROW PER MATCH
                             PATTERN (creste{1,} egal{0,} scade{0,})
                             DEFINE
                                creste AS creste.height > PREV(creste.height),
                                scade AS scade.height < PREV(scade.height),
                                egal AS egal.height = PREV(egal.height)
                             ) a
                        WHERE animal_code=''' || p_code || '''AND height = (SELECT max(j.height) FROM animals_measurements j WHERE j.animal_code=''' || p_code || ''')';
        return v_maxim;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end longest_maxim_height;
    
    function variation_height(p_code char) return sys_refcursor as
        v_variation sys_refcursor;
    begin
        open v_variation for 
            'WITH animalsdetails AS(
                SELECT animal_code, am.measurement_date.start_time as startt,height
                FROM animals_measurements am)
                SELECT *
                FROM animalsdetails MATCH_RECOGNIZE (
                     PARTITION BY animal_code
                     ORDER BY startt
                     MEASURES CLASSIFIER() AS sablon, height-PREV(height) AS diff
                     ALL ROWS PER MATCH
                     PATTERN (strt (increase{1,} | decrease{1,} | equal{1,})*)
                     DEFINE
                        increase AS increase.height > PREV(increase.height),
                        decrease AS decrease.height < PREV(decrease.height),
                        equal AS equal.height = PREV(equal.height)
                     ) a
                WHERE animal_code=:1' using p_code;
        return v_variation;
        
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20003, 'The animal to be read was not found by the provided code!');
    end variation_height;

end RAPOARTE;