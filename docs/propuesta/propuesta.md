# Trabajo Final — Entrega 1

## Definición de la problemática y propuesta técnica

**Proyecto:** Sistema de gestión para Tienda de Ropa
**Tutor:** Oscar Londero

**Integrantes:**
- Celeste Monsalbe - DNI 45.028.610
- Magdalena Darchez - DNI 47.402.878
- Sol Yoon - DNI 92.906.418

**Fecha de entrega:** 30/08/2026

---

## 1. Introducción

El presente documento corresponde a la primera entrega del Trabajo Final de la Tecnicatura Universitaria en Programación a Distancia (UTN). El objetivo de esta entrega es presentar la propuesta de proyecto, la justificación de las tecnologías a utilizar y el plan de trabajo previsto para su desarrollo, junto con el repositorio de GitHub donde se alojará el proyecto.

El proyecto consiste en el desarrollo de un sistema de gestión para un local de indumentaria femenina ubicado en el barrio de Flores (CABA), que funcionará como cliente real del trabajo. El local atiende tanto ventas minoristas en el punto de venta como pedidos mayoristas con envíos a clientes de todo el país. En la actualidad, toda su operación —ventas, stock, clientes, pedidos y compras a proveedores— se registra de forma manual en cuadernos y planillas de Excel desconectadas entre sí.

Esta forma de trabajo genera pérdida de tiempo en tareas repetitivas, errores y demoras en la consulta de stock, dificultades en el seguimiento de los pedidos con envío e imposibilidad de analizar estadísticamente el negocio. Frente a esta situación, se propone desarrollar una aplicación web de gestión que centralice toda la operación en una única plataforma, con perfiles de acceso diferenciados para las vendedoras y para el dueño del local, pensada para ser utilizada sin conocimientos técnicos y capaz de generar automáticamente los reportes que hoy no pueden producirse.

El documento se organiza de la siguiente manera: en primer lugar se identifica y analiza la problemática del cliente; luego se presenta la propuesta de solución y su valor agregado; a continuación se valida el problema y se evalúa la viabilidad del proyecto; después se detalla y justifica el stack tecnológico elegido; y finalmente se presenta el plan de trabajo con sus etapas, plazos y la estructura del repositorio.

## 2. Identificación de la problemática

### 2.1 Contexto

El cliente del proyecto es un local de indumentaria femenina ubicado en el barrio de Flores, Ciudad Autónoma de Buenos Aires. El local opera con dos modalidades de venta: la venta minorista, atendida de forma presencial en el punto de venta, y la venta mayorista, destinada a clientes de distintas provincias, cuyos pedidos se despachan mediante envíos.

El equipo de trabajo está compuesto por el dueño y ocho vendedoras. El local trabaja con siete proveedores y maneja un catálogo de aproximadamente 60 productos, con variantes de talle y color.

La gestión del negocio se realiza en la actualidad con herramientas tradicionales: los registros diarios se llevan por escrito en cuadernos y posteriormente se vuelcan, de forma parcial, a planillas de Excel. No se utiliza ningún sistema de gestión informatizado. Esta modalidad de trabajo, sostenida por costumbre, funciona para la operación diaria pero presenta ineficiencias crecientes a medida que aumenta el volumen de ventas y de clientes mayoristas.

### 2.2 Situación actual

El flujo de trabajo difiere según la modalidad de venta. En la venta minorista, la vendedora verifica la disponibilidad del talle o color solicitado recorriendo el local o el depósito, cobra la operación y la registra en el cuaderno; al cierre de la jornada, el dueño traslada esos registros a las planillas de Excel. En la venta mayorista, el pedido ingresa por WhatsApp o teléfono, se registran manualmente los datos del cliente y del envío, se arma y despacha la mercadería, y el seguimiento posterior del pedido depende de anotaciones dispersas.

En ambos casos, la información queda distribuida en distintos medios, sin centralizarse en un único lugar: consultar el stock disponible, revisar las ventas realizadas o seguir un pedido mayorista requiere revisar varios registros y realizar comprobaciones manuales. Lo mismo ocurre con las compras a proveedores: al no estar integrada la información de productos, ventas y stock, resulta difícil determinar con precisión qué productos reponer y cuándo.

### 2.3 Actores y necesidades

A partir del relevamiento se identifican los actores que interactúan con los procesos del negocio y que, en consecuencia, interactuarían con el sistema propuesto. Para cada uno se describe su rol, sus necesidades principales y las limitaciones a considerar.

**Dueño del local:** es el responsable de la gestión integral del negocio: define las compras a proveedores, los precios de venta y las decisiones de reposición. Necesita acceder a una visión completa de la operación, que incluye las ventas realizadas, el estado del stock, los pedidos mayoristas, la información de clientes y proveedores, y los precios de compra. Requiere además contar con reportes y estadísticas que le permitan fundamentar sus decisiones. Parte de la información que maneja —en particular los precios de compra a proveedores y los datos de la cartera de clientes— es de carácter comercialmente sensible, por lo que su acceso debe estar restringido exclusivamente a este actor.

**Vendedoras:** son las encargadas de la atención al público en el punto de venta. Necesitan registrar las ventas de manera rápida y sencilla durante la atención, y consultar la disponibilidad de productos por talle y color sin depender de verificaciones manuales. Dado que su función es operativa, no requieren acceso a la información comercial sensible del negocio, lo que constituye una limitación de acceso a contemplar en el diseño del sistema.

**Clientes minoristas:** compran de forma presencial en el local. No interactuarían directamente con el sistema, pero se benefician de una atención más ágil, en particular en la consulta de disponibilidad de talles y colores.

**Clientes mayoristas:** realizan pedidos desde distintas provincias del país, que se despachan mediante envíos. Esperan que sus pedidos se registren correctamente, que los envíos lleguen en tiempo y forma, y recibir información sobre nuevos productos y promociones. Sus datos de contacto y de envío deben mantenerse actualizados y accesibles para el seguimiento de cada pedido.

**Proveedores:** constituyen un actor indirecto: no interactuarían con el sistema, pero la gestión de las compras que se les realizan —productos, cantidades y precios— forma parte de la información que el negocio necesita registrar y consultar.

La distinción entre las necesidades del dueño y las de las vendedoras fundamenta la definición de perfiles de acceso diferenciados en el sistema propuesto: un perfil de administración con acceso total a la información y un perfil operativo orientado al registro de ventas y la consulta de stock.

### 2.4 Problemáticas identificadas

A partir del relevamiento realizado con el cliente, se identifican las siguientes problemáticas principales:

**Gestión manual de las operaciones.** El registro de ventas, pedidos, stock y compras requiere una importante cantidad de tareas manuales. Esto genera una inversión de tiempo en actividades repetitivas que podrían ser automatizadas.

**Falta de centralización de la información.** La información del negocio se encuentra distribuida entre cuadernos y diferentes planillas de Excel. Esto dificulta su consulta y obliga a realizar verificaciones manuales para obtener una visión completa de las operaciones.

**Dificultades en el control del stock.** La actualización manual de las existencias dificulta conocer de manera rápida y confiable la disponibilidad de los productos, especialmente considerando que el catálogo cuenta con variantes de talle y color.

**Dificultades en el seguimiento de pedidos mayoristas.** Los pedidos realizados por clientes mayoristas requieren un seguimiento adicional debido a que corresponden a clientes de distintas partes del país y deben ser despachados mediante envíos. La ausencia de una herramienta centralizada dificulta consultar el estado de estos pedidos y su información asociada.

**Dificultades en la comunicación de novedades a clientes mayoristas.** La información necesaria para comunicar el ingreso de nuevos productos —imágenes, descripciones y lista de contactos actualizada— no se encuentra centralizada, por lo que debe producirse manualmente en cada ocasión. Al competir con las tareas de venta en el local, esta actividad tiende a postergarse.

**Limitaciones para el análisis del negocio.** Aunque el negocio genera información sobre sus ventas y operaciones, actualmente no dispone de una herramienta que permita procesarla y generar estadísticas de forma automática. El esfuerzo necesario para recopilar y analizar los datos hace que esta información no sea utilizada de manera sistemática para la toma de decisiones.

En conjunto, estas problemáticas generan pérdida de tiempo, dificultan el acceso a información actualizada y limitan la capacidad del negocio para utilizar sus propios datos como herramienta de gestión.

### 2.5 Impacto de la problemática

Las dificultades identificadas tienen impacto tanto en las tareas operativas diarias como en la gestión general del negocio. Si bien el local no registra mediciones formales de estos costos, el relevamiento realizado con el cliente permitió estimarlos.

En el ámbito operativo, el traspaso de los registros del cuaderno a las planillas de Excel insume entre media hora y una hora al cierre de cada jornada, tiempo que se dedica íntegramente a duplicar información ya registrada. A esto se suman las consultas de disponibilidad: las vendedoras verifican de forma manual la existencia de talles y colores más de diez veces por día, interrumpiendo la atención para revisar el local o el depósito. La falta de información confiable sobre las existencias también produce errores concretos: según lo relevado, se vende o compromete mercadería que luego no se encuentra disponible con una frecuencia de hasta una vez por día, lo que obliga a rectificar la operación frente al cliente.

La preparación de los avisos de novedades a los clientes mayoristas —que se envían de forma conjunta por WhatsApp— demanda entre veinte minutos y una hora por cada ingreso de mercadería. Al competir con la atención de la venta en el local, esta tarea tiende a postergarse, por lo que la comunicación no se realiza con la frecuencia ni la inmediatez que el negocio necesita.

En el ámbito de la gestión, el procesamiento manual de los datos hace que la elaboración de estadísticas y reportes resulte tan costosa que, en la práctica, no se realiza. Como consecuencia, las decisiones de compra y reposición se toman sin un análisis sistemático de la información histórica del propio negocio.

## 3. Propuesta de solución y valor agregado

### 3.1 Formulación del problema

A modo de síntesis del análisis desarrollado, el problema puede formularse de la siguiente manera: el personal de un local de indumentaria femenina del barrio de Flores (CABA), con venta minorista en el punto de venta y mayorista con envíos a todo el país, gestiona la totalidad de su operación en cuadernos y planillas de Excel desconectadas entre sí. Esta forma de trabajo genera:

- Pérdida de tiempo en registros duplicados.
- Errores y demoras en la consulta de stock por talle y color.
- Dificultades en el seguimiento de los pedidos con envío.
- Postergación de la comunicación de novedades a los clientes mayoristas.
- Imposibilidad de realizar un análisis estadístico del negocio para fundamentar las decisiones de compra y reposición.

Frente a ello, una solución de software podría centralizar la gestión de ventas, stock, clientes, pedidos y proveedores en una única plataforma, sencilla de utilizar durante la atención, y capaz de generar automáticamente la información que hoy no puede producirse.

### 3.2 Descripción de la solución propuesta

Se propone el desarrollo de una aplicación web de gestión compuesta por los siguientes módulos:

| Módulo | Funcionalidad |
|---|---|
| Ventas y pedidos | Registro rápido de las ventas de mostrador durante la atención y de los pedidos mayoristas con sus datos de envío. Cada pedido cuenta con un estado (pendiente, despachado, entregado) que posibilita su seguimiento. |
| Stock | Administración del catálogo de productos con sus variantes de talle y color, imágenes y descripciones. El stock se actualiza automáticamente con cada venta, pedido e ingreso de mercadería, y el sistema emite alertas al alcanzar el nivel mínimo de reposición. |
| Clientes | Centralización de los datos de clientes, diferenciando minoristas y mayoristas. Para los mayoristas se registran los datos de contacto y de envío, manteniendo actualizada la información necesaria para los pedidos y la comunicación de novedades. |
| Proveedores | Registro de los proveedores y de las compras realizadas, con productos, cantidades y precios. Esta información alimenta el control de stock y el análisis de reposición. |
| Reportes | Generación automática de estadísticas e informes sobre ventas, rotación de productos y necesidades de reposición, a partir de la información registrada por los demás módulos. |

El sistema contará con dos perfiles de acceso, conforme a las necesidades y limitaciones identificadas en el relevamiento: un perfil de administración, destinado al dueño, con acceso total a la información, y un perfil operativo, destinado a las vendedoras, orientado al registro de ventas y la consulta de disponibilidad, sin acceso a la información comercialmente sensible.

### 3.3 Valor agregado

La solución propuesta aporta valor en tres dimensiones.

En primer lugar, **reduce costos operativos**: elimina el doble registro diario entre cuadernos y planillas, reduce las verificaciones manuales de stock que interrumpen la atención y disminuye los errores por venta de mercadería sin existencias, costos cuantificados en la sección 2.5.

En segundo lugar, **habilita capacidades que hoy resultan inviables**: con los datos centralizados, las estadísticas de ventas, rotación y reposición se generan de forma automática, lo que permite fundamentar las decisiones de compra en información histórica del propio negocio. Asimismo, la preparación de la comunicación de novedades deja de requerir la producción manual de imágenes, descripciones y listas de contacto, ya que esa información reside en el sistema.

En tercer lugar, **mejora la experiencia de forma medible**: la consulta de disponibilidad de talles y colores se resuelve en el momento desde el sistema, agilizando la atención minorista y mayorista, y el seguimiento de los pedidos con envío se realiza mediante la consulta de su estado en lugar de depender de anotaciones dispersas.

El valor de la solución no reside en la digitalización de los registros en sí misma, sino en lo que la información centralizada permite hacer: análisis, alertas y seguimientos que con la forma de trabajo actual resultan imposibles o demasiado costosos.

## 4. Validación y viabilidad

**Validación del problema:**

- **¿Ocurre ahora?** Sí, es la operatoria diaria habitual en los comercios minoristas de indumentaria que no están digitalizados.
- **¿Los afectados lo reconocen?** Totalmente; los comerciantes sufren demoras en la atención al cliente, falta de stock actualizado en tiempo real y pérdida de tiempo al cruzar información entre cuadernos y planillas sueltas.
- **¿Soluciones parciales actuales?** Uso de planillas de cálculo (Excel) y registros en papel. No es suficiente porque no permite alertas automáticas de stock mínimo, centraliza la información de forma precaria y es altamente propenso a errores humanos de transcripción.

**Competencia y diferenciación (breve análisis):**

- **Competidores directos:** sistemas de gestión comercial genéricos o plataformas de e-commerce complejas del mercado.
- **Diferenciador de la propuesta:** un enfoque a medida, liviano, con una curva de aprendizaje mínima adaptada específicamente a las necesidades operativas reales de un local de ropa, evitando la sobreingeniería.

**Evaluación de viabilidad:**

- **Viabilidad técnica:** el equipo cuenta con los conocimientos necesarios para desarrollar la solución con el stack seleccionado, minimizando riesgos con tecnologías ya transitadas en la tecnicatura.
- **Viabilidad operativa:** el comercio cuenta con el hardware básico (PC/notebook) y conectividad a internet para operar el sistema en su día a día.
- **Viabilidad temporal:** el alcance del MVP se acota estrictamente para completarlo de forma holgada antes de la fecha límite del informe final (14/11), cumpliendo con los hitos intermedios del 27/09.

## 5. Stack tecnológico y justificación

**Frontend**
- **Tecnología:** React con TypeScript (HTML/CSS).
- **Justificación:** se elige React por la experiencia previa del equipo adquirida a lo largo de la tecnicatura, optimizando los tiempos de desarrollo. Se incorpora TypeScript para añadir tipado estático, lo que reduce la aparición de errores en tiempo de ejecución y mejora la mantenibilidad del código orientado a las entregas pautadas.

**Backend**
- **Tecnología:** Node.js con Express y TypeScript.
- **Justificación:** permite unificar el lenguaje (JavaScript/TypeScript) tanto en el cliente como en el servidor, agilizando la lógica de negocio y facilitando la estructuración de las rutas y controladores para la gestión de ventas, stock y proveedores.

**Base de Datos**
- **Tecnología:** PostgreSQL (Relacional - SQL).
- **Justificación:** se opta por una base de datos relacional porque los datos del negocio (clientes, productos, ventas, proveedores y stock) poseen una estructura estricta y relaciones directas que requieren integridad transaccional (ACID) para evitar inconsistencias en el inventario y la caja diaria.

**Despliegue (Hosting)**
- **Tecnología:** Vercel (Frontend) y Render o Railway (Backend y Base de Datos).
- **Justificación:** son plataformas PaaS que ofrecen capas gratuitas o de bajo costo muy estables, abstraen la complejidad de la infraestructura y permiten cumplir con el requisito obligatorio de tener los componentes funcionando online de manera ágil.

## 6. Plan de trabajo

### 6.1 Objetivo general

Desarrollar una aplicación web de gestión para centralizar y optimizar las operaciones de un local de indumentaria femenina, permitiendo administrar ventas, pedidos, productos, stock, clientes y proveedores desde una única plataforma, con perfiles de acceso diferenciados y generación automática de reportes para facilitar la gestión y la toma de decisiones.

### 6.2 Objetivos específicos

- Centralizar en una única plataforma la información actualmente distribuida entre cuadernos y planillas de Excel.
- Implementar un módulo de gestión de productos, contemplando sus variantes de talle y color.
- Permitir el registro de ventas minoristas y pedidos mayoristas.
- Automatizar la actualización del stock a partir de las ventas, pedidos e ingresos de mercadería.
- Incorporar alertas de stock cuando un producto alcance el nivel mínimo establecido.
- Implementar la gestión de clientes, diferenciando clientes minoristas y mayoristas.
- Implementar la gestión de proveedores y compras de mercadería.
- Permitir consultar el estado de los pedidos mayoristas y su información de envío.
- Incorporar perfiles de acceso diferenciados para el dueño y las vendedoras.
- Generar reportes y estadísticas sobre las ventas, rotación de productos y necesidades de reposición.
- Reducir el tiempo destinado al registro y consulta manual de información.
- Desplegar la aplicación en un entorno online para permitir su utilización fuera del entorno de desarrollo.

### 6.3 Alcance del MVP

El Producto Mínimo Viable contemplará las funcionalidades necesarias para resolver los principales problemas identificados durante el relevamiento del cliente.

**Gestión de productos y stock**
- Alta, baja y modificación de productos.
- Registro de categorías.
- Gestión de talles y colores.
- Registro de imágenes y descripciones.
- Consulta de stock disponible.
- Actualización automática del stock.
- Definición de niveles mínimos de stock.
- Alertas de reposición.

**Ventas y pedidos**
- Registro de ventas minoristas.
- Registro de pedidos mayoristas.
- Registro de los datos correspondientes al envío.
- Gestión del estado de los pedidos.
- Consulta del historial de operaciones.

**Clientes**
- Registro y modificación de clientes.
- Diferenciación entre clientes minoristas y mayoristas.
- Registro de información de contacto.
- Registro de datos de envío para clientes mayoristas.

**Proveedores y compras**
- Registro de proveedores.
- Registro de compras.
- Asociación de productos a proveedores.
- Registro de cantidades y precios de compra.
- Actualización del stock a partir del ingreso de mercadería.

**Reportes**
- Reportes de ventas.
- Estadísticas de productos.
- Información sobre rotación.
- Identificación de productos que requieren reposición.

**Usuarios y permisos**
- Perfil administrador para el dueño del local.
- Perfil operativo para las vendedoras.
- Restricción del acceso a información comercial sensible.

### 6.4 No alcance del MVP

Con el objetivo de mantener el proyecto dentro de los plazos establecidos, las siguientes funcionalidades quedan fuera del alcance inicial:

- Desarrollo de una aplicación móvil nativa.
- Integración con sistemas de facturación electrónica.
- Integración con pasarelas de pago.
- Integración automática con servicios de correo o WhatsApp.
- Seguimiento de envíos mediante APIs de empresas de transporte.
- Gestión contable avanzada.
- Gestión de sueldos del personal.
- Integración con sistemas externos de proveedores.

### 6.5 Etapas y entregables

El desarrollo se organizará en etapas alineadas con el cronograma establecido por la cátedra.

**Etapa 1 — Propuesta y planificación**
*Fecha límite: 30/08*

Actividades:
- Relevamiento y análisis de la problemática del cliente.
- Definición de la solución propuesta.
- Determinación del alcance inicial del proyecto.
- Selección y justificación del stack tecnológico.
- Creación y configuración del repositorio único de GitHub.
- Elaboración de la documentación correspondiente a la primera entrega.

Entregables:
- Propuesta de proyecto.
- Repositorio de GitHub.
- Estructura inicial del proyecto.
- README inicial.

**Etapa 2 — Diseño y definición de módulos**
*Fecha límite: 27/09*

Actividades:
- Diseño de la base de datos PostgreSQL.
- Definición de entidades, atributos y relaciones.
- Diseño de la arquitectura del sistema.
- Definición detallada de los módulos.
- Definición de roles y permisos.
- Diseño inicial de las interfaces.
- Definición de las principales funcionalidades y flujos del sistema.
- Revisión y validación del diseño con el tutor.

Entregables:
- Esquema de la base de datos.
- Diagramas de arquitectura y diseño.
- Listado de módulos.
- Documentación correspondiente a la segunda entrega.

**Etapa 3 — Desarrollo, pruebas, despliegue y entrega final**
*Fecha límite: 14/11*

Actividades:
- Implementación de la base de datos.
- Desarrollo del backend y API.
- Desarrollo del frontend.
- Implementación e integración de los módulos definidos.
- Implementación de roles y permisos.
- Pruebas funcionales y corrección de errores.
- Despliegue de la aplicación y base de datos en servicios online.
- Elaboración de la documentación final.
- Preparación del video explicativo.
- Revisión final del repositorio.

Entregables:
- Sistema funcional.
- Repositorio completo.
- Base de datos.
- Aplicación desplegada online.
- Documentación final.
- Video explicativo.

### 6.6 Estimación temporal

| Período | Actividades principales |
|---|---|
| Hasta 30/08 | Propuesta, relevamiento, planificación y repositorio |
| 31/08 – 13/09 | Análisis, arquitectura y diseño inicial |
| 14/09 – 27/09 | Base de datos, módulos e interfaces |
| 28/09 – 11/10 | Backend, API y base de datos |
| 12/10 – 25/10 | Desarrollo del frontend e integración |
| 26/10 – 31/10 | Finalización de funcionalidades |
| 01/11 – 08/11 | Pruebas, correcciones y despliegue |
| 09/11 – 14/11 | Documentación, video y revisión final |

### 6.7 Riesgos y mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Ampliación excesiva del alcance | Media | Alto | Definir y respetar el alcance del MVP, priorizando funcionalidades esenciales. |
| Retrasos en el desarrollo | Media | Alto | Dividir las tareas entre los integrantes y realizar seguimiento semanal. |
| Problemas de integración frontend/backend | Media | Alto | Definir previamente la estructura de la API y realizar integraciones progresivas. |
| Errores en el modelo de base de datos | Baja/Media | Alto | Diseñar y validar el modelo antes de comenzar el desarrollo. |
| Conflictos en Git | Media | Medio | Utilizar ramas por funcionalidad, commits frecuentes y revisión antes de integrar cambios. |
| Problemas durante el despliegue | Media | Alto | Realizar pruebas de despliegue con anticipación y no esperar a la fecha final. |
| Disponibilidad limitada del cliente para validar funcionalidades | Baja/Media | Medio | Coordinar instancias de validación y recopilar los requisitos principales durante la etapa inicial. |

### 6.8 Criterios de éxito

Se considerará que el proyecto cumple con los objetivos establecidos cuando:

- Las operaciones principales del negocio puedan registrarse desde el sistema sin necesidad de duplicar la información en cuadernos y planillas.
- El stock pueda consultarse por producto, talle y color.
- El stock se actualice automáticamente ante ventas, pedidos e ingresos de mercadería.
- El sistema permita registrar y consultar ventas minoristas y pedidos mayoristas.
- Los pedidos mayoristas puedan ser consultados según su estado.
- Los datos de clientes y proveedores estén centralizados.
- Los usuarios puedan acceder únicamente a las funcionalidades correspondientes a su perfil.
- El dueño pueda acceder a información y reportes necesarios para analizar las ventas y la reposición.
- Las principales operaciones puedan realizarse desde una interfaz sencilla, sin requerir conocimientos técnicos.
- Los principales flujos del sistema hayan sido probados y funcionen correctamente.
- La aplicación se encuentre desplegada y accesible online.
- El repositorio contenga el código fuente, documentación, scripts de base de datos y demás recursos necesarios para ejecutar y comprender el proyecto.

## 7. Repositorio

### 7.1 Repositorio de GitHub

El desarrollo del proyecto se centralizará en un único repositorio de GitHub, de acuerdo con los requisitos establecidos por la cátedra.

**Repositorio:** tienda-indumentaria-tfi-grupo172
**Enlace:** https://github.com/CelesteMonsalbe/tienda-indumentaria-tfi-grupo172.git

El repositorio será utilizado por todos los integrantes del equipo para almacenar el código fuente, la documentación, los recursos relacionados con el proyecto y los archivos necesarios para la configuración y despliegue del sistema.

El control de versiones se realizará mediante Git, utilizando commits y ramas para organizar el desarrollo de las distintas funcionalidades y facilitar el trabajo colaborativo.

### 7.2 Estructura del repositorio

```
tienda-indumentaria-tfi-grupo172/
│
├── frontend/
│   └── Código fuente de la aplicación web desarrollada con React.
│
├── backend/
│   └── Código fuente del servidor y API desarrollados con Node.js y Express.
│
├── database/
│   └── Scripts, migraciones y archivos relacionados con la base de datos PostgreSQL.
│
├── docs/
│   ├── arquitectura/
│   │   └── Documentación relacionada con la arquitectura del sistema.
│   │
│   ├── diagramas/
│   │   └── Diagramas de diseño y modelado del sistema.
│   │
│   ├── entregas/
│   │   └── Documentación correspondiente a las distintas entregas de la cátedra.
│   │
│   └── propuesta/
│       └── Documentación correspondiente a la propuesta inicial del proyecto.
│
├── .gitignore
│
└── README.md
```

Esta organización permite separar el código de las distintas capas de la aplicación y mantener centralizada la documentación del proyecto dentro del mismo repositorio.

### 7.3 Contenido del README

El archivo `README.md` será el documento principal de referencia del repositorio y contendrá la información necesaria para comprender, instalar y ejecutar el proyecto.

Se prevé incluir:

- **Nombre del proyecto:** sistema de gestión para local de indumentaria femenina.
- **Descripción:** breve explicación del problema abordado y de la solución propuesta.
- **Cliente:** descripción general del comercio para el cual se desarrolla el sistema.
- **Objetivos:** principales objetivos del proyecto.
- **Funcionalidades:** descripción de los módulos implementados.
- **Tecnologías utilizadas:** React, Node.js, Express y PostgreSQL.
- **Estructura del proyecto:** explicación de las principales carpetas del repositorio.
- **Requisitos previos:** herramientas y versiones necesarias para ejecutar el sistema.
- **Instalación:** pasos necesarios para configurar y ejecutar el proyecto localmente.
- **Configuración de variables de entorno:** indicaciones sobre las variables necesarias para la conexión con los servicios utilizados, sin incluir credenciales reales.
- **Base de datos:** instrucciones para configurar PostgreSQL y ejecutar los scripts o migraciones.
- **Ejecución:** comandos necesarios para iniciar el frontend y backend.
- **Despliegue:** información sobre los servicios utilizados para alojar la aplicación.
- **Integrantes del equipo:** nombres de los estudiantes participantes.
- **Documentación:** enlaces o referencias a los documentos relevantes almacenados en la carpeta `/docs`.

El README será actualizado progresivamente durante el desarrollo para reflejar el estado actual del proyecto y facilitar su instalación, revisión y mantenimiento.

## 8. Conclusión

A partir del relevamiento realizado con el cliente, se identificó una problemática concreta relacionada con la gestión manual y descentralizada de las operaciones de un local de indumentaria femenina. El uso de cuadernos y planillas de Excel independientes genera pérdida de tiempo, dificultades en el control del stock, errores en las operaciones y limitaciones para obtener información útil para la toma de decisiones.

Frente a esta situación, se propone el desarrollo de una aplicación web que centralice la gestión de ventas, pedidos, productos, stock, clientes y proveedores, incorporando perfiles de acceso diferenciados y herramientas de reportes. La solución busca reducir las tareas manuales, mejorar el acceso a la información y facilitar la gestión cotidiana del negocio.

El proyecto resulta técnicamente viable debido a que las tecnologías seleccionadas forman parte de los conocimientos adquiridos por el equipo durante la carrera. Asimismo, el alcance definido para el MVP permite organizar el desarrollo de acuerdo con los plazos establecidos por la cátedra y priorizar las funcionalidades de mayor valor para el cliente.

La propuesta constituye una oportunidad para aplicar de manera integrada los conocimientos adquiridos durante la Tecnicatura Universitaria en Programación, desarrollando una solución orientada a una necesidad real y con posibilidades de utilización efectiva por parte del comercio.
