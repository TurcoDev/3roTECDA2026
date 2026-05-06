# Base de Datos - MySQL

Clase del 30/04/2026. Motor de base de datos: **MySQL**.

## Estructura de archivos

| Archivo | Contenido |
|---|---|
| `01_setup.sql` | Creación de la base de datos y las tablas |
| `02_data.sql` | Inserción de datos iniciales |
| `03_relations.sql` | Relaciones entre tablas (Foreign Keys) |
| `04_views.sql` | Vistas |
| `05_indexes.sql` | Índices |
| `06_transactions.sql` | Transacciones |
| `07_procedures.sql` | Stored Procedures |
| `08_triggers.sql` | Triggers _(próxima clase)_ |

Ejecutar los archivos en orden numérico.

---

## Temas vistos en clase

### DDL vs DML

- **DDL** (Data Definition Language): sentencias que definen la estructura — `CREATE`, `ALTER`, `DROP`.
- **DML** (Data Manipulation Language): sentencias que manipulan los datos — `INSERT`, `UPDATE`, `DELETE`, `SELECT`.

---

### Tablas y tipos de datos

```sql
CREATE TABLE user (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age  INT NOT NULL
);
```

- `INT` — número entero.
- `VARCHAR(n)` — texto de longitud variable hasta _n_ caracteres.
- `AUTO_INCREMENT` — el motor asigna el valor automáticamente.
- `PRIMARY KEY` — identifica de forma única cada fila.
- `NOT NULL` — el campo es obligatorio.

---

### Relaciones y Foreign Keys

Las **claves foráneas** (FK) vinculan una columna de una tabla con la clave primaria de otra, garantizando integridad referencial: no se puede insertar un `profession_id` que no exista en la tabla `profession`.

```sql
ALTER TABLE user
    ADD CONSTRAINT fk_profession
    FOREIGN KEY (profession_id) REFERENCES profession(id);
```

El modelo resultante es:

```
user ──< profession
user ──< city
```

---

### Vistas (Views)

Una vista es una consulta guardada que se comporta como una tabla virtual. No almacena datos propios; siempre refleja el estado actual de las tablas subyacentes.

```sql
CREATE VIEW vw_user_info AS
SELECT u.id, u.name, u.age, p.name AS profession, c.name AS city
FROM user u
JOIN profession p ON u.profession_id = p.id
JOIN city       c ON u.city_id       = c.id;
```

**Ventajas:**
- Simplifica consultas complejas.
- Permite restringir columnas visibles para ciertos usuarios.
- Centraliza la lógica de negocio en un solo lugar.

---

### Índices (Indexes)

Un índice es una estructura de datos auxiliar que el motor usa para encontrar filas sin recorrer toda la tabla (_full table scan_).

```sql
CREATE INDEX idx_user_name ON user(name);
```

**Cuándo crearlos:**
- Columnas que se filtran frecuentemente (`WHERE`, `JOIN ON`).
- Columnas con alta cardinalidad (muchos valores distintos).

**Costo:** los índices aceleran las lecturas pero ralentizan ligeramente los `INSERT`/`UPDATE`/`DELETE`, ya que deben mantenerse actualizados.

Usar `EXPLAIN` antes y después para comparar el plan de ejecución.

---

### Transacciones

Una transacción agrupa varias operaciones en una **unidad atómica**: o se ejecutan todas, o ninguna.

```sql
START TRANSACTION;

UPDATE user SET age = age + 1 WHERE id = 1;
UPDATE user SET age = age + 1 WHERE id = 2;

COMMIT;   -- confirma todos los cambios
```

```sql
START TRANSACTION;

UPDATE user SET age = 99 WHERE id = 1;

ROLLBACK; -- descarta todos los cambios
```

**Propiedades ACID:**

| Propiedad | Significado |
|---|---|
| **A**tomicidad | Todo o nada |
| **C**onsistencia | La BD pasa de un estado válido a otro |
| **I**solamiento | Las transacciones no se interfieren entre sí |
| **D**urabilidad | Los cambios confirmados persisten aunque el sistema falle |

---

### Stored Procedures (Procedimientos almacenados)

Un stored procedure es un bloque de código SQL con nombre, guardado en la base de datos y reutilizable.

```sql
DELIMITER //

CREATE PROCEDURE user_older_than(IN min_age INT)
BEGIN
    SELECT * FROM user WHERE age >= min_age;
END //

DELIMITER ;

CALL user_older_than(35);
```

- `IN` — parámetro de entrada.
- `OUT` — parámetro de salida (retorna un valor al llamador).
- `DELIMITER //` — necesario para que el cliente no interprete el `;` interno como fin de sentencia.

---

## Próxima clase: Triggers

Un **trigger** (disparador) es un bloque de código que se ejecuta automáticamente cuando ocurre un evento DML sobre una tabla.

### Tipos

| Momento | Evento | Descripción |
|---|---|---|
| `BEFORE` | `INSERT` | Se ejecuta antes de insertar la fila |
| `AFTER` | `INSERT` | Se ejecuta después de insertar la fila |
| `BEFORE` | `UPDATE` | Se ejecuta antes de modificar la fila |
| `AFTER` | `UPDATE` | Se ejecuta después de modificar la fila |
| `BEFORE` | `DELETE` | Se ejecuta antes de eliminar la fila |
| `AFTER` | `DELETE` | Se ejecuta después de eliminar la fila |

### Variables especiales

- `NEW` — contiene los valores de la fila nueva (disponible en `INSERT` y `UPDATE`).
- `OLD` — contiene los valores de la fila anterior (disponible en `UPDATE` y `DELETE`).

### Ejemplo: auditoría automática

```sql
DELIMITER //

CREATE TRIGGER trg_after_insert_user
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    INSERT INTO audit_user (action, user_id, action_date)
    VALUES ('INSERT', NEW.id, NOW());
END //

DELIMITER ;
```

Cada vez que se inserta un usuario, este trigger registra la acción en `audit_user` sin que el desarrollador tenga que hacerlo manualmente.

### Ejemplo: validación con SIGNAL

```sql
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
```

`SIGNAL` lanza un error y cancela la operación, similar a lanzar una excepción en un lenguaje de programación.

Ver `08_triggers.sql` para más ejemplos.
