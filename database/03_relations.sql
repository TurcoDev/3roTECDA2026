-- ============================================================
-- 03_relations.sql - Relaciones entre tablas (Foreign Keys)
-- ============================================================

USE tecda;

-- Agregar columnas de relación a la tabla user
ALTER TABLE user
    ADD profession_id INT,
    ADD city_id       INT;

-- Clave foránea hacia profession
ALTER TABLE user
    ADD CONSTRAINT fk_profession
    FOREIGN KEY (profession_id) REFERENCES profession(id);

-- Clave foránea hacia city
ALTER TABLE user
    ADD CONSTRAINT fk_city
    FOREIGN KEY (city_id) REFERENCES city(id);

-- Asignar profesión y ciudad a cada usuario existente
UPDATE user SET profession_id = 1, city_id = 1 WHERE id = 1;  -- Lucas  -> Developer / Tandil
UPDATE user SET profession_id = 2, city_id = 2 WHERE id = 2;  -- Anna   -> Designer / Buenos Aires
UPDATE user SET profession_id = 3, city_id = 3 WHERE id = 3;  -- Peter  -> Teacher  / Cordoba
UPDATE user SET profession_id = 4, city_id = 4 WHERE id = 4;  -- Maria  -> Accountant / Rosario
UPDATE user SET profession_id = 5, city_id = 5 WHERE id = 5;  -- John   -> Lawyer   / Mendoza
