# Listado de Módulos — Sistema de Gestión para Local de Indumentaria

Este documento enumera los módulos funcionales del sistema, su descripción y prioridad de desarrollo, definidos para la segunda etapa del proyecto.

## 1. Módulo de Autenticación y Usuarios
* **Descripción:** Permite el inicio de sesión y la gestión de perfiles de acceso. Implementa control de roles en el backend para diferenciar las acciones permitidas a la administración frente al personal operativo.
* **Prioridad:** Alta (Fundamental para la seguridad y control de accesos).

## 2. Módulo de Productos y Stock
* **Descripción:** Administración integral del catálogo de indumentaria. Permite el alta, baja y modificación de productos, gestión de variantes (talles y colores), carga de imágenes, precios de compra/venta y control automatizado de stock (disponible, reservado y fallado) con alertas de stock mínimo.
* **Prioridad:** Alta (Núcleo operativo del negocio).

## 3. Módulo de Ventas y Pedidos
* **Descripción:** Registro de ventas minoristas presenciales en el local y gestión de pedidos mayoristas con sus datos de envío y estados (pendiente, confirmado, despachado). Incluye la separación automática de stock al reservar mercadería.
* **Prioridad:** Alta (Proceso principal de facturación y salida de mercadería).

## 4. Módulo de Clientes
* **Descripción:** Centralización de la cartera de clientes, diferenciando entre clientes minoristas y mayoristas. Almacena datos de contacto y direcciones de envío para facilitar el despacho de pedidos.
* **Prioridad:** Media.

## 5. Módulo de Proveedores y Compras
* **Descripción:** Registro de proveedores y de las compras de mercadería realizadas (asociando productos, cantidades y precios de compra). Permite el ingreso de stock de forma automatizada.
* **Prioridad:** Media.

## 6. Módulo de Reportes y Estadísticas
* **Descripción:** Generación automática de reportes de ventas, rotación de productos y cálculo de ganancias. Módulo de acceso exclusivo para el rol de administrador.
* **Prioridad:** Baja (Complementario para la toma de decisiones gerenciales).
