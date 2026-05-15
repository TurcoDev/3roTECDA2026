# Servidor con Express.js

Este proyecto contiene ejemplos y explicaciones sobre cómo crear un servidor básico usando Express.js en Node.js. A continuación se detallan los conceptos principales vistos en clase.

---

## Instalación de paquetes

Para utilizar Express.js, primero debes instalarlo en tu proyecto. Ejecuta el siguiente comando en la terminal dentro de la carpeta del proyecto:

```
npm install express
```

Esto descargará e instalará Express y lo agregará a las dependencias del proyecto en `package.json`.

---

## Uso de `type: module` en package.json

Para poder usar la sintaxis de módulos ES (import/export) en Node.js, debes agregar la siguiente línea en tu archivo `package.json`:

```json
{
  "type": "module"
}
```

Esto permite que puedas importar Express y otros módulos usando:

```js
import express from 'express';
```

---

## Middleware: express.json()

Un middleware es una función que se ejecuta durante el ciclo de vida de una petición HTTP. Express provee varios middlewares útiles. Uno de los más usados es `express.json()`, que permite que el servidor pueda interpretar automáticamente los datos enviados en formato JSON en el cuerpo de las peticiones.

Ejemplo de uso:
```js
app.use(express.json());
```

Esto es necesario para poder recibir y procesar datos enviados desde el frontend o herramientas como Postman en formato JSON.

---

## Métodos HTTP

Los métodos HTTP definen la acción que se quiere realizar sobre un recurso:
- **GET**: Obtener datos.
- **POST**: Crear un nuevo recurso.
- **PUT**: Reemplazar un recurso existente.
- **PATCH**: Modificar parcialmente un recurso.
- **DELETE**: Eliminar un recurso.

Ejemplo de rutas en Express:
```js
app.get('/ruta', (req, res) => { ... });
app.post('/ruta', (req, res) => { ... });
```

---

## Método `send` de Express

El método `res.send()` se utiliza para enviar una respuesta al cliente. Puede enviar texto, HTML, objetos, arreglos, etc. Ejemplo:

```js
res.send('Hola mundo');
res.send({ mensaje: 'OK' });
```

Express detecta automáticamente el tipo de dato y ajusta los encabezados de la respuesta.

---

## Ejemplo básico de servidor

```js
import express from 'express';
const app = express();
const PORT = 3000;

app.use(express.json()); // Middleware para JSON

app.get('/', (req, res) => {
  res.send('Servidor funcionando');
});

app.listen(PORT, () => {
  console.log(`Servidor escuchando en puerto ${PORT}`);
});
```

---

## Recomendaciones
- Siempre instala las dependencias con `npm install` antes de ejecutar el servidor.
- Usa `type: module` si quieres trabajar con `import` y `export`.
- Recuerda agregar el middleware `express.json()` si vas a recibir datos en formato JSON.
- Prueba tus rutas usando Postman, Insomnia o desde el frontend.

---

## Datos de `users`

En este proyecto hay un archivo con datos de ejemplo de usuarios que puedes usar en tus rutas. Ver el archivo de datos aquí: [server-express/src/data/data.js](server-express/src/data/data.js#L1-L200)

Ejemplo de cómo exponer esos usuarios desde el servidor (puedes añadir esto en `server.js` o en tu router):

```js
import express from 'express'
import { users } from './src/data/data.js'

const app = express()

app.get('/api/users', (req, res) => {
  res.json(users)
})
```

También hay un ejemplo sencillo de manejo de usuarios en [server-express/server.js](server-express/server.js#L1-L200) que muestra rutas `GET`, `POST`, `PUT` y `DELETE` usando un arreglo local `users`.

## Habilitar CORS para un frontend React

Cuando sirves un frontend (por ejemplo una app creada con Vite/React que corre en `http://localhost:5173`) y tu API está en otro puerto (`http://localhost:3000`), necesitarás permitir solicitudes cross-origin en el servidor.

1. Instala el paquete `cors` (si no está instalado):

```bash
npm install cors
```

2. Configura `cors` en tu servidor (por ejemplo en `server.js`):

```js
import express from 'express'
import cors from 'cors'

const app = express()

// Permitir solo el origen del frontend (más seguro)
app.use(cors({ origin: 'http://localhost:5173' }))

// Para desarrollo rápido puedes permitir todos los orígenes (no recomendado en producción)
// app.use(cors())

app.use(express.json())
```

3. Ejemplo de llamada desde React (fetch en `useEffect` o similar):

```js
fetch('http://localhost:3000/api/users')
  .then(res => res.json())
  .then(data => setUsers(data))
  .catch(err => console.error(err))
```

Notas:
- Si usas otro puerto para el frontend, reemplaza `http://localhost:5173` por la URL correcta.
- En producción, restringe `origin` a los dominios que realmente necesites.

---

## Conexión a una base de datos MySQL con Express.js (visto en clase)

En clase hemos visto cómo conectar un proyecto Express.js a una base de datos MySQL, instalar MySQL en la máquina de desarrollo, y cómo hacer consultas seguras desde rutas o modelos. A continuación se muestran pasos, ejemplos y buenas prácticas.

**Instalación de MySQL (Linux / macOS)**

- Ubuntu/Debian (ejemplo):

```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
sudo systemctl start mysql
sudo systemctl enable mysql
mysql --version
```

- macOS (Homebrew):

```bash
brew install mysql
brew services start mysql
```

Después de instalar, crea la base de datos y un usuario dedicado para la aplicación:

```sql
-- En el cliente mysql (por ejemplo: sudo mysql -u root -p)
CREATE DATABASE tecda;
CREATE USER 'tecda_user'@'localhost' IDENTIFIED BY 'tu_password';
GRANT ALL PRIVILEGES ON tecda.* TO 'tecda_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

**Dependencias npm (en la carpeta del proyecto `server-express`)**

Instala el cliente MySQL y `dotenv` para gestionar variables de entorno:

```bash
npm install mysql2 dotenv
```

**Variables de entorno (.env)**

Ejemplo de archivo `.env` en la raíz de `server-express`:

```
DB_HOST=localhost
DB_PORT=3306
DB_USER=tecda_user
DB_PASSWORD=tu_password
DB_NAME=tecda
```

**Conexión recomendada: `mysql2` con pool y promesas**

Se recomienda usar `mysql2/promise` y un `pool` de conexiones para producción. Crea (o reemplaza) `src/db/dbConnect.js` con algo parecido a lo siguiente:

```js
// src/db/dbConnect.js (recomendado)
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

const connection = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'tecda',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

export default connection;
```

En este repositorio hay un `src/db/dbConnect.js` que muestra una conexión simple con `mysql2` (callbacks); y `src/models/user.model.js` que contiene ejemplos con callbacks y comentarios para la versión con promesas. Puedes revisarlos como guía.

**Ejemplos de consultas desde rutas o modelos (async/await)**

```js
import connection from './src/db/dbConnect.js';

// SELECT
app.get('/api/users', async (req, res) => {
  try {
    const [rows] = await connection.query('SELECT * FROM user;');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error en la consulta' });
  }
});

// INSERT (parametrizado)
app.post('/api/users', async (req, res) => {
  const { name, email } = req.body;
  try {
    const [result] = await connection.execute(
      'INSERT INTO user (name, email) VALUES (?, ?)',
      [name, email]
    );
    res.status(201).json({ insertId: result.insertId });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'No se pudo insertar el usuario' });
  }
});

// UPDATE
await connection.execute('UPDATE user SET name = ? WHERE id = ?', [name, id]);

// DELETE
await connection.execute('DELETE FROM user WHERE id = ?', [id]);
```

**Transacciones**

Para operaciones que deben ser atómicas, usa `getConnection()` y transacciones:

```js
const conn = await connection.getConnection();
try {
  await conn.beginTransaction();
  await conn.query('UPDATE accounts SET balance = balance - ? WHERE id = ?', [amount, fromId]);
  await conn.query('UPDATE accounts SET balance = balance + ? WHERE id = ?', [amount, toId]);
  await conn.commit();
} catch (err) {
  await conn.rollback();
  throw err;
} finally {
  conn.release();
}
```

**Buenas prácticas y notas**

- Usa consultas parametrizadas (`?`) o `execute()` para evitar inyección SQL.
- No uses el usuario `root` en producción; crea un usuario con mínimos permisos necesarios.
- Guarda credenciales en variables de entorno y no las subas al repositorio.
- Prefiere un `pool` de conexiones en entornos con concurrencia.
- Maneja errores y libera conexiones en `finally`.

**Archivos de referencia en este repo**

- Conexión simple (actual): [server-express/src/db/dbConnect.js](server-express/src/db/dbConnect.js#L1-L50)
- Ejemplos de uso en modelos: [server-express/src/models/user.model.js](server-express/src/models/user.model.js#L1-L200)

---
