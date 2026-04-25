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
