USE `EM_Church`;
CREATE OR REPLACE VIEW `EM_Church`.`vuSchedules` AS
    SELECT 
        s.*, u.prefer_name, u1.prefer_name AS created_by_name
    FROM
        schedules s
            LEFT JOIN
        users u ON s.charge = u.id
            LEFT JOIN
        users u1 ON s.created_by = u1.id