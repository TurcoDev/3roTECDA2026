# React + Vite


# Contenidos vistos en clase (18/04/2026)

Hoy vimos una **introducción básica a React**:

- ¿Qué es React?
	- Es una biblioteca de JavaScript para construir interfaces de usuario de forma declarativa y basada en componentes.

- **JSX**
	- Es una extensión de JavaScript que permite escribir código similar a HTML dentro de archivos JS/JSX.
	- Facilita la creación de componentes visuales.

- **Componentes**
	- Son funciones o clases que retornan elementos de interfaz (UI).
	- Permiten reutilizar y organizar el código de la aplicación.

- ¿Qué es **Vite**?
	- Es una herramienta moderna para crear proyectos web rápidamente.
	- Permite iniciar un proyecto de React de forma sencilla y con recarga rápida (HMR).

- **¿Cómo iniciar un proyecto con Vite?**
	1. Instalar Node.js y npm.
	2. Ejecutar `npm create vite@latest` y seguir los pasos.
	3. Elegir la plantilla de React.
	4. Instalar dependencias con `npm install`.
	5. Iniciar el servidor de desarrollo con `npm run dev`.

> **Nota:** Aún no vimos el tema de props ni otros conceptos avanzados.

## Componentes

- ¿Qué son?: Un componente es una pieza reutilizable de la interfaz que puede ser una función o una clase; en React moderno se usan funciones.
- Responsabilidad: encapsulan la UI y su comportamiento, permiten componer la aplicación a partir de piezas pequeñas.

Ejemplo (componente funcional):

```jsx
function Saludo({ name }) {
	return <h1>Hola, {name}!</h1>;
}

// Uso: <Saludo name="María" />
```

## Props

- Definición: "props" (propiedades) son los datos que un componente recibe desde su padre.
- Inmutables: dentro del componente las `props` se consideran de solo lectura; para cambiar datos se usan estados o callbacks.

Ejemplo:

```jsx
function TarjetaUsuario({ usuario }) {
	return (
		<div>
			<h2>{usuario.nombre}</h2>
			<p>{usuario.email}</p>
		</div>
	);
}

// Uso: <TarjetaUsuario usuario={{ nombre: 'Ana', email: 'ana@ejemplo.com' }} />
```

## `useState`

- Qué hace: es un Hook que permite agregar estado local a componentes funcionales.
- Firma: `const [valor, setValor] = useState(valorInicial)`.
- Re-render: llamar a `setValor` provoca que React vuelva a renderizar el componente con el nuevo estado.

Ejemplo:

```jsx
import { useState } from 'react';

function Contador() {
	const [cuenta, setCuenta] = useState(0);
	return (
		<div>
			<p>Cuenta: {cuenta}</p>
			<button onClick={() => setCuenta(c => c + 1)}>Incrementar</button>
		</div>
	);
}
```

## `useEffect`

- Qué hace: es el Hook para ejecutar efectos secundarios (fetch, suscripciones, timers, manipulación del DOM fuera de React).
- Dependencias: recibe un arreglo de dependencias; el efecto se ejecuta cuando esas dependencias cambian.
- Limpieza: puede devolver una función para limpiar efectos (ej. cancelar suscripciones) antes del siguiente efecto o al desmontar.

Ejemplos:

```jsx
import { useEffect, useState } from 'react';

function EjemploFetch() {
	const [data, setData] = useState(null);

	useEffect(() => {
		let activo = true;
		fetch('/api/datos')
			.then(r => r.json())
			.then(json => { if (activo) setData(json); });

		return () => { activo = false; } // limpieza
	}, []); // [] -> se ejecuta solo al montar

	return <pre>{JSON.stringify(data, null, 2)}</pre>;
}
```

Uso común de dependencias:

```jsx
useEffect(() => {
	// efecto que depende de "query"
}, [query]);
```

---

Si querés, puedo ajustar los ejemplos al código del proyecto o añadir más detalles y ejemplos interactivos.

## Ejemplo: consumo de API local (http://localhost:3000)

A continuación hay un ejemplo práctico de un componente React que consume una API local corriendo en `http://localhost:3000`, ruta `/users`. Asegurate de tener el backend en ejecución y que permita CORS.

```jsx
import { useEffect, useState } from 'react';

function UsuariosList() {
	const [usuarios, setUsuarios] = useState(null);
	const [error, setError] = useState(null);
	const [loading, setLoading] = useState(true);

	useEffect(() => {
		let mounted = true;
		fetch('http://localhost:3000/users')
			.then(res => {
				if (!res.ok) throw new Error('Respuesta inválida ' + res.status);
				return res.json();
			})
			.then(data => { if (mounted) setUsuarios(data); })
			.catch(err => { if (mounted) setError(err.message); })
			.finally(() => { if (mounted) setLoading(false); });

		return () => { mounted = false; };
	}, []);

	if (loading) return <p>Cargando...</p>;
	if (error) return <p>Error: {error}</p>;
	if (!usuarios || usuarios.length === 0) return <p>No hay usuarios.</p>;

	return (
		<ul>
			{usuarios.map(u => (
				<li key={u.id}>{u.name} — {u.email}</li>
			))}
		</ul>
	);
}

export default UsuariosList;
```

Uso: importar y usar `<UsuariosList />` en `App.jsx` o el componente donde quieras mostrar la lista. Por ejemplo:

```jsx
import UsuariosList from './components/UsuariosList';

function App() {
	return (
		<div>
			<h1>Usuarios</h1>
			<UsuariosList />
		</div>
	);
}

export default App;
```

Nota: el backend debe exponer `GET /users` que devuelva JSON (array de objetos con `id`, `name`, `email`).
