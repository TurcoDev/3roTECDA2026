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
