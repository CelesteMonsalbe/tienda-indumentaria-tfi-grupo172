# Sistema de Gestión para Local de Indumentaria

## Propuesta del proyecto

Proyecto desarrollado para el **Trabajo Final Integrador de la Tecnicatura Universitaria en Programación a Distancia (UTN)**.

El proyecto consiste en desarrollar un **sistema web de gestión para un local de indumentaria femenina ubicado en Flores, Ciudad Autónoma de Buenos Aires**.

Actualmente, el comercio gestiona sus ventas, stock, clientes, pedidos y compras a proveedores mediante cuadernos y planillas de Excel desconectadas entre sí. Esta modalidad genera pérdida de tiempo, errores en el control del stock, dificultades para realizar el seguimiento de pedidos y limitaciones para obtener información útil para la toma de decisiones.

La propuesta consiste en centralizar estas operaciones en una única aplicación web, facilitando la gestión diaria del comercio y mejorando el acceso a la información.

### Funcionalidades principales

- Gestión de productos y variantes de talle y color.
- Control y actualización de stock.
- Registro de ventas minoristas.
- Gestión de pedidos mayoristas y su estado.
- Gestión de clientes.
- Gestión de proveedores y compras.
- Generación de reportes básicos.
- Perfiles de acceso diferenciados para administrador y personal operativo.

---

## Stack tecnológico

### Frontend

**React + TypeScript + HTML + CSS**

Se utilizará React debido a que el equipo cuenta con experiencia previa con esta tecnología adquirida durante la tecnicatura, permitiendo reducir la curva de aprendizaje y optimizar los tiempos de desarrollo.

### Backend

**Node.js + Express + TypeScript**

Se utilizará TypeScript tanto en frontend como en backend, facilitando el desarrollo y mantenimiento del proyecto. Express permitirá implementar la API y organizar las rutas y la lógica de negocio.

### Base de datos

**PostgreSQL (SQL - Relacional)**

Se selecciona una base de datos relacional debido a que la información del negocio presenta relaciones definidas entre productos, stock, ventas, clientes, proveedores y compras. PostgreSQL permitirá mantener la integridad de los datos y evitar inconsistencias en las operaciones.

### Despliegue

- **Frontend:** Vercel
- **Backend:** Render o Railway
- **Base de datos:** Render o Railway

La plataforma definitiva será seleccionada durante la etapa de desarrollo de acuerdo con las necesidades del proyecto.

---

## Plan de trabajo

El proyecto se desarrollará en tres etapas, alineadas con el cronograma establecido por la cátedra.

### Etapa 1 — Propuesta y repositorio

**Fecha límite: 30/08/2026**

- Definición de la problemática y solución.
- Definición del alcance inicial.
- Selección del stack tecnológico.
- Creación y configuración del repositorio.
- Presentación de la propuesta.

### Etapa 2 — Diseño y módulos

**Fecha límite: 27/09/2026**

- Diseño de la base de datos.
- Definición de entidades y relaciones.
- Diseño de la arquitectura.
- Definición de módulos.
- Definición de roles y permisos.
- Diseño inicial de interfaces.

### Etapa 3 — Desarrollo, pruebas, despliegue y entrega final

**Fecha límite: 14/11/2026**

- Desarrollo del frontend y backend.
- Implementación de la base de datos.
- Integración de los módulos.
- Pruebas y corrección de errores.
- Despliegue online.
- Documentación final.
- Preparación del video explicativo.
- Entrega final.

---

## Estructura del repositorio

```text
tienda-indumentaria-tfi-grupo172/
│
├── frontend/
├── backend/
├── database/
├── docs/
│   ├── arquitectura/
│   ├── diagramas/
│   ├── entregas/
│   └── propuesta/
│
├── .gitignore
└── README.md
```

- `frontend/`: código de la aplicación web.
- `backend/`: servidor y API.
- `database/`: scripts y archivos relacionados con PostgreSQL.
- `docs/`: documentación, diagramas y entregas del proyecto.

---

## Integrantes

- **Sol Yoon**
- **Magdalena Darchez**
- **Celeste Monsalbe**

## Tutor

**Oscar Londero**

---

## Estado del proyecto

**Etapa actual:** Propuesta y definición del proyecto.

**Grupo:** 172

**Primera entrega:** 30/08/2026

**Segunda entrega:** 27/09/2026

**Entrega final:** 14/11/2026
