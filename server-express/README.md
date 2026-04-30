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