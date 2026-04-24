# Servidor Node.js (server1.mjs y server2.mjs)

Este README explica paso a paso los dos servidores incluidos en esta carpeta:

- `server1.mjs` — servidor HTTP básico que responde "Hello World".
- `server2.mjs` — servidor HTTP básico con un CRUD en memoria para usuarios (/users).

Requisitos previos

- Sistema Linux (estas instrucciones son para Debian/Ubuntu; adaptar según tu distribución).
- Acceso a la terminal con privilegios para instalar paquetes (sudo).

Instalar Node.js (opciones)

1) Usando NodeSource (ejemplo para Node 18 LTS):

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

2) Usando nvm (recomendado si quieres múltiples versiones):

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
# cierra y vuelve a abrir la terminal o carga nvm en la sesión actual
source ~/.nvm/nvm.sh
nvm install --lts
nvm use --lts
```

Verificar instalación:

```bash
node -v
npm -v
```

Instalación en Windows

1) Usando el instalador oficial (recomendado para la mayoría de usuarios):

  - Ve a https://nodejs.org/ y descarga el instalador LTS para Windows.
  - Ejecuta el instalador y sigue los pasos (acepta agregar `node` y `npm` al PATH).

2) Usando `nvm-windows` (si necesitas múltiples versiones):

```powershell
# Descarga e instala nvm-windows desde: https://github.com/coreybutler/nvm-windows
# Después de instalar, desde PowerShell o CMD:
nvm install lts
nvm use lts
```

3) Usando `winget` (Windows 10/11 con App Installer):

```powershell
winget install OpenJS.NodeJS.LTS -e --source winget
```

Comprobación en PowerShell / CMD:

```powershell
node -v
npm -v
```

Nota sobre `curl` y PowerShell:

- Windows 10/11 incluye `curl.exe`; igualmente puedes usar `Invoke-RestMethod` en PowerShell si prefieres:

```powershell
# Usando curl
curl http://127.0.0.1:3000/users

# Usando PowerShell
Invoke-RestMethod -Method Get -Uri http://127.0.0.1:3000/users
```

Introducción corta: servidores en Node.js y protocolo HTTP

Node.js permite crear servidores HTTP usando su módulo integrado `http` (o `node:http` en módulos ES). Un servidor HTTP escucha peticiones en un puerto y responde con un código de estado, cabeceras y un cuerpo. Los métodos HTTP más usados aquí son:

- GET: recuperar recursos (ej. obtener lista de usuarios).
- POST: crear recursos (ej. agregar un usuario).
- PUT: actualizar recursos existentes (ej. modificar un usuario indicando su `id`).
- DELETE: eliminar recursos (ej. borrar un usuario por `id`).

Ambos servidores usan el módulo nativo, por lo que no requieren dependencias externas.

Descripción de los archivos

- `server1.mjs`
  - Crea un servidor que responde con texto plano "Hello World!" en la ruta `/`.
  - Escucha en `127.0.0.1:3000`.
  - Uso:

```bash
node server1.mjs
# o (si usas node v18+ con import sintaxis) igual funciona
```

- `server2.mjs`
  - Implementa un pequeño CRUD en memoria para `users` (array `users` dentro del proceso).
  - Rutas y comportamiento:
    - `GET /users` — devuelve la lista de usuarios en JSON. Código: 200.
    - `POST /users` — espera un body JSON con al menos `{ "name": "..." }`. Crea usuario asignando `id = users.length + 1`. Responde 201 con el usuario creado.
    - `PUT /users` — espera un body JSON con la estructura completa del usuario incluyendo `id`. Si el `id` existe, actualiza y responde 200 con el usuario actualizado; si no existe, responde 404 con `{ "error": "User not found" }`.
    - `DELETE /users/:id` — elimina el usuario cuyo id se pasa en la URL (ej: `/users/2`). Si lo elimina responde 204; si no existe responde 404 con `{ "error": "User not found" }`.
    - `GET /` — responde "Hello World!" en texto plano.
  - Escucha en `127.0.0.1:3000`.
  - Uso:

```bash
node server2.mjs
```

Ejemplos de uso con `curl`

1) Probar el servidor básico (`server1.mjs`):

```bash
curl http://127.0.0.1:3000/
# Salida: Hello World!
```

2) Listar usuarios (`server2.mjs`):

```bash
curl http://127.0.0.1:3000/users
# Salida: JSON con la lista de usuarios
```

3) Crear un usuario:

```bash
curl -X POST http://127.0.0.1:3000/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Pedro"}'
# Salida: JSON del usuario creado con id
```

4) Actualizar un usuario (PUT):

```bash
curl -X PUT http://127.0.0.1:3000/users \
  -H "Content-Type: application/json" \
  -d '{"id":1,"name":"Juan Actualizado"}'
# Salida: JSON del usuario actualizado o 404 si no existe
```

5) Eliminar un usuario (DELETE):

```bash
curl -X DELETE http://127.0.0.1:3000/users/2
# Respuesta HTTP 204 si fue eliminado, 404 si no existe
```

Notas y consideraciones

- El CRUD de `server2.mjs` mantiene los datos en memoria; al reiniciar el proceso los datos vuelven al estado inicial del archivo.
- La implementación espera que los bodies lleguen completos en JSON y no tiene validación exhaustiva: en producción debes validar entradas y manejar errores con más cuidado.
- En `DELETE` el servidor responde 204 (sin contenido); el código actual también envía un JSON opcional con un mensaje, pero por especificación 204 no debe llevar cuerpo. El comportamiento se mantiene simple para ejemplificar.
- Si el puerto `3000` está ocupado, cambia la llamada a `server.listen(...)` en los archivos o libera el puerto.

Depuración rápida

- Ver logs en la terminal donde se ejecuta `node`.
- Si recibes `EACCES` o problemas al instalar Node, usa `nvm` para evitar permisos.