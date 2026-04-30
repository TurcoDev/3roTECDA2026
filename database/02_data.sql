-- ============================================================
-- 02_data.sql - Inserción de datos iniciales
-- ============================================================

USE tresa;

-- Usuarios (sin profession_id ni city_id por ahora, se agregan en 03_relations.sql)
INSERT INTO user (name, age) VALUES
    ('Lucas', 35),
    ('Anna',  28),
    ('Peter', 40),
    ('Maria', 32),
    ('John',  45);

-- Profesiones
INSERT INTO profession (name) VALUES
    ('Developer'),
    ('Designer'),
    ('Teacher'),
    ('Accountant'),
    ('Lawyer');

-- Ciudades
INSERT INTO city (name) VALUES
    ('Tandil'),
    ('Buenos Aires'),
    ('Cordoba'),
    ('Rosario'),
    ('Mendoza');
