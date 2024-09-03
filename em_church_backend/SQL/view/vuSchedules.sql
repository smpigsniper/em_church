USE `EM_Church`;
CREATE  OR REPLACE VIEW `EM_Church`.`vuSchedules` AS
    SELECT 
        s.*, u.prefer_name
    FROM
        schedules s
            LEFT JOIN
        users u ON s.charge = u.id;
