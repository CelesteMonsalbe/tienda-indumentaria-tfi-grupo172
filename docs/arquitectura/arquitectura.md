# Arquitectura del sistema

## 1. Objetivo

El sistema tiene como objetivo digitalizar y organizar los principales procesos de gestión de un local de indumentaria, principalmente el manejo de productos y variantes, control de stock, ventas, pedidos e ingresos de mercadería.

La arquitectura se plantea buscando separar las distintas responsabilidades del sistema, facilitar su mantenimiento y permitir la incorporación progresiva de nuevos módulos.

---

## 2. Arquitectura general

El sistema utilizará una arquitectura cliente-servidor.

El frontend será responsable de la interfaz con el usuario y se comunicará mediante HTTP con una API REST desarrollada en el backend. El backend concentrará las reglas de negocio y accederá a la base de datos PostgreSQL para consultar y persistir la información.

El flujo general será:

```text
Frontend
React + TypeScript
        |
        | HTTP / JSON
        v
Backend
Node.js + Express + TypeScript
        |
        v
PostgreSQL
```

De esta manera, la interfaz, la lógica de negocio y la persistencia de datos permanecen separadas.

---

## 3. Arquitectura del backend

Para el backend se utilizará una arquitectura en capas:

```text
Rutas
  ↓
Controladores
  ↓
Servicios
  ↓
Acceso a datos
  ↓
PostgreSQL
```

### Rutas

Las rutas representan los distintos endpoints disponibles en la API REST. Reciben las solicitudes HTTP y determinan qué controlador debe atender cada operación.

Por ejemplo, existirán rutas relacionadas con productos, variantes, ventas, stock, pedidos y usuarios.

### Controladores

Los controladores reciben las solicitudes provenientes de las rutas, obtienen los datos enviados por el cliente y delegan las operaciones correspondientes a la capa de servicios.

También son responsables de devolver las respuestas HTTP correspondientes al frontend.

### Servicios

La capa de servicios concentra las principales reglas de negocio.

En esta capa se resolverán operaciones como:

- Registrar una venta.
- Actualizar el stock de una variante.
- Registrar movimientos de stock.
- Gestionar ingresos de mercadería.
- Reservar o liberar stock para pedidos.
- Aplicar las restricciones correspondientes según el rol del usuario.

Separar estas reglas de los controladores permite mantener organizada la lógica del sistema y facilita futuras modificaciones.

### Acceso a datos

Esta capa será responsable de la comunicación entre la lógica de negocio y PostgreSQL.

Permitirá realizar las operaciones necesarias para consultar, crear, modificar o eliminar registros sin mezclar el acceso a la base de datos con las reglas de negocio.

---

## 4. Stack tecnológico

### Frontend: React + TypeScript

React permitirá construir la interfaz mediante componentes reutilizables y organizar las diferentes pantallas del sistema.

TypeScript permitirá agregar tipado estático al desarrollo, facilitando la detección temprana de errores y mejorando la mantenibilidad del código.

### Backend: Node.js + Express + TypeScript

Node.js será utilizado como entorno de ejecución del backend.

Express permitirá implementar la API REST, organizar las rutas y gestionar las solicitudes y respuestas HTTP entre el frontend y el servidor.

TypeScript se utilizará también en el backend para incorporar tipado estático, facilitar la detección de errores y mantener consistencia tecnológica con el frontend.

### Base de datos: PostgreSQL

PostgreSQL será utilizado como sistema gestor de base de datos relacional.

El modelo del proyecto presenta relaciones claras entre entidades como productos, variantes, ventas, movimientos de stock, pedidos, clientes, proveedores y usuarios, por lo que una base de datos relacional resulta adecuada para representar y mantener estas relaciones.

### Comunicación: API REST + JSON

El frontend y el backend se comunicarán mediante una API REST utilizando HTTP.

La información intercambiada entre ambas partes utilizará principalmente formato JSON.

### Control de versiones: Git y GitHub

Se utilizará Git para el control de versiones y GitHub como repositorio compartido del proyecto, permitiendo organizar y mantener los cambios realizados por las integrantes del equipo.

---

## 5. Organización general

La estructura general prevista para el proyecto es:

```text
tienda-indumentaria-tfi-grupo172/
│
├── frontend/
├── backend/
├── database/
├── docs/
│   └── arquitectura/
│       └── arquitectura.md
│
└── README.md
```

`frontend` contendrá posteriormente la aplicación desarrollada con React y TypeScript.

`backend` contendrá posteriormente la API desarrollada con Node.js, Express y TypeScript.

`database` contendrá el esquema de PostgreSQL, las relaciones y los datos iniciales necesarios para realizar pruebas.

`docs` contendrá la documentación del proyecto, incluyendo la definición de arquitectura.

---

## 6. Reglas de negocio y arquitectura

Las reglas de negocio se concentrarán principalmente en la capa de servicios del backend.

El sistema deberá permitir controlar el stock a nivel de variante de producto. Cada variante podrá representar combinaciones de talle y color según corresponda al producto.

El stock deberá diferenciar entre unidades disponibles, reservadas y falladas/apartadas.

Además de mantener las cantidades actuales, las operaciones que modifiquen las existencias deberán generar movimientos de stock para conservar la trazabilidad.

Las ventas deberán almacenar el precio aplicado al momento de realizar la operación, de manera que una modificación posterior del precio del producto no altere las ventas históricas.

Los pedidos mayoristas deberán permitir reservar unidades mientras se encuentran pendientes. La confirmación del pedido consolidará posteriormente la salida de esas unidades.

---

## 7. Usuarios y permisos

El sistema contempla inicialmente dos roles:

- **Administrador:** correspondiente principalmente al dueño del comercio.
- **Operativo:** correspondiente al personal encargado de las operaciones diarias.

Las restricciones de acceso deberán implementarse en el backend y no solamente ocultando funcionalidades en la interfaz.

El administrador tendrá acceso a operaciones de gestión y a información sensible, mientras que el perfil operativo podrá realizar las tareas necesarias para la actividad diaria, como registrar ventas, consultar stock o gestionar pedidos según los permisos definidos.

---

## 8. Despliegue

El despliegue online del sistema se realizará durante la etapa de desarrollo e integración del proyecto.

La estrategia prevista actualmente es:

- **Frontend:** Vercel.
- **Backend:** Render o Railway.
- **Base de datos PostgreSQL:** Render o Railway.

Vercel será utilizado para alojar la aplicación frontend desarrollada con React y TypeScript.

Para el backend y la base de datos se evaluarán Render y Railway, debido a su compatibilidad con Node.js y PostgreSQL. La plataforma definitiva será seleccionada durante la etapa de desarrollo de acuerdo con las necesidades técnicas del proyecto.

Durante la etapa actual se trabajará principalmente en el diseño de la arquitectura, el modelo de datos y la definición de los módulos. El despliegue online se realizará posteriormente, una vez implementados e integrados el frontend, el backend y la base de datos.

---

Esta organización permite mantener separadas la interfaz de usuario, la lógica de negocio y la persistencia de datos, facilitando el desarrollo modular y la evolución futura del sistema.