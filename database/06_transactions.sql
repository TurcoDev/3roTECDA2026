-- ============================================================
-- 06_transactions.sql - Transacciones
-- ============================================================

USE tecda;

-- ----------------------------------------------------------------
-- COMMIT: todas las operaciones se confirman juntas
-- Si una falla, se puede hacer ROLLBACK antes de confirmar
-- ----------------------------------------------------------------
START TRANSACTION;

UPDATE user SET age = age + 1 WHERE id = 1;
UPDATE user SET age = age + 1 WHERE id = 2;

COMMIT;  -- Confirma ambos cambios de forma atómica

-- ----------------------------------------------------------------
-- ROLLBACK: deshace todos los cambios desde START TRANSACTION
-- Útil cuando algo sale mal en medio de una operación
-- ----------------------------------------------------------------
START TRANSACTION;

UPDATE user SET age = 99 WHERE id = 1;

ROLLBACK;  -- Descarta el cambio anterior, id=1 conserva su edad original

-- Verificar el estado final
SELECT id, name, age FROM user ORDER BY id;
