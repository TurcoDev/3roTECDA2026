-- ============================================================
-- 07_procedures.sql - Stored Procedures (Procedimientos almacenados)
-- ============================================================

USE tecda;

-- Stored Procedure: devuelve usuarios cuya edad es mayor o igual al parámetro
DELIMITER //

CREATE PROCEDURE user_older_than(IN min_age INT)
BEGIN
    SELECT * FROM user WHERE age >= min_age;
END //

DELIMITER ;

-- Llamar al procedimiento
CALL user_older_than(35);

-- ----------------------------------------------------------------
-- Procedimiento con parámetro OUT (retorna un valor)
-- ----------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE count_users_in_city(IN city_name VARCHAR(50), OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM user u
    JOIN city c ON u.city_id = c.id
    WHERE c.name = city_name;
END //

DELIMITER ;

-- Uso con parámetro OUT
CALL count_users_in_city('Tandil', @resultado);
SELECT @resultado AS usuarios_en_tandil;

-- Ver todos los procedimientos almacenados de la base de datos
SHOW PROCEDURE STATUS WHERE Db = 'tecda';
