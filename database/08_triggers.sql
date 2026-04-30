-- ============================================================
-- 08_triggers.sql - Triggers (Disparadores)
-- Tema: próxima clase
-- ============================================================

USE tresa;

-- Un TRIGGER es un bloque de código que se ejecuta automáticamente
-- cuando ocurre un evento DML (INSERT, UPDATE, DELETE) en una tabla.
--
-- Sintaxis:
--   CREATE TRIGGER nombre
--   BEFORE | AFTER  INSERT | UPDATE | DELETE  ON tabla
--   FOR EACH ROW
--   BEGIN
--     -- código
--   END
--
-- Palabras especiales dentro del trigger:
--   NEW  -> fila con los valores nuevos (disponible en INSERT y UPDATE)
--   OLD  -> fila con los valores anteriores (disponible en UPDATE y DELETE)

-- ============================================================
-- AFTER INSERT: auditar cada nuevo usuario
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_after_insert_user
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    INSERT INTO audit_user (action, user_id, action_date)
    VALUES ('INSERT', NEW.id, NOW());
END //

DELIMITER ;

-- ============================================================
-- AFTER UPDATE: auditar cada modificación de usuario
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_after_update_user
AFTER UPDATE ON user
FOR EACH ROW
BEGIN
    INSERT INTO audit_user (action, user_id, action_date)
    VALUES ('UPDATE', NEW.id, NOW());
END //

DELIMITER ;

-- ============================================================
-- AFTER DELETE: auditar cada eliminación de usuario
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_after_delete_user
AFTER DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO audit_user (action, user_id, action_date)
    VALUES ('DELETE', OLD.id, NOW());
END //

DELIMITER ;

-- ============================================================
-- BEFORE INSERT: validar que la edad sea mayor a 0
-- SIGNAL lanza un error y cancela la operación
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_before_insert_user
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
    IF NEW.age <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La edad debe ser mayor a 0';
    END IF;
END //

DELIMITER ;

-- ============================================================
-- BEFORE UPDATE: evitar que la edad baje respecto al valor actual
-- ============================================================
DELIMITER //

CREATE TRIGGER trg_before_update_user_age
BEFORE UPDATE ON user
FOR EACH ROW
BEGIN
    IF NEW.age < OLD.age THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede reducir la edad de un usuario';
    END IF;
END //

DELIMITER ;

-- ============================================================
-- Prueba de los triggers
-- ============================================================

-- INSERT dispara trg_before_insert_user (valida edad) y trg_after_insert_user (audita)
INSERT INTO user (name, age, profession_id, city_id) VALUES ('Carlos', 25, 1, 1);

-- UPDATE dispara trg_before_update_user_age (valida) y trg_after_update_user (audita)
UPDATE user SET age = 26 WHERE name = 'Carlos';

-- DELETE dispara trg_after_delete_user (audita)
DELETE FROM user WHERE name = 'Carlos';

-- Verificar el registro de auditoría
SELECT * FROM audit_user ORDER BY action_date DESC;

-- Probar la validación de edad (debe lanzar un error)
-- INSERT INTO user (name, age) VALUES ('Test', -1);

-- Ver todos los triggers de la base de datos
SHOW TRIGGERS FROM tresa;
