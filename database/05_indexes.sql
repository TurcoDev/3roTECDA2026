-- ============================================================
-- 05_indexes.sql - Índices (Indexes)
-- ============================================================

USE tecda;

-- Ejecutar ANTES de crear el índice para comparar el plan de ejecución
-- MySQL usa un full table scan sin índice
EXPLAIN SELECT * FROM user WHERE name = 'Anna';

-- Crear un índice sobre el campo name para acelerar búsquedas por nombre
CREATE INDEX idx_user_name ON user(name);

-- Ejecutar DESPUÉS de crear el índice
-- MySQL ahora usa el índice idx_user_name (mucho más rápido en tablas grandes)
EXPLAIN SELECT * FROM user WHERE name = 'Anna';

-- Ver todos los índices de la tabla user
SHOW INDEX FROM user;

-- Para eliminar el índice si ya no se necesita:
-- DROP INDEX idx_user_name ON user;
