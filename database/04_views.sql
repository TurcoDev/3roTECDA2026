-- ============================================================
-- 04_views.sql - Vistas (Views)
-- ============================================================

USE tresa;

-- Vista que combina user, profession y city en una sola consulta
CREATE VIEW vw_user_info AS
SELECT
    u.id,
    u.name,
    u.age,
    p.name AS profession,
    c.name AS city
FROM user u
JOIN profession p ON u.profession_id = p.id
JOIN city       c ON u.city_id       = c.id;

-- Insertar un usuario nuevo con todos sus datos de una vez
INSERT INTO user (name, age, profession_id, city_id) VALUES ('Florencia', 35, 1, 3);

-- Consultar la vista (devuelve todos los usuarios con profesión y ciudad)
SELECT * FROM vw_user_info;
