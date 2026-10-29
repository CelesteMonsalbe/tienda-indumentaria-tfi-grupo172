# Listado de Módulos — Sistema de Gestión para Local de Indumentaria

Este documento enumera los módulos funcionales del sistema, su descripción y prioridad de desarrollo, definidos para la segunda etapa del proyecto.

## 1. Módulo de Autenticación y Usuarios
* **Descripción:** Permite el inicio de sesión y la gestión de perfiles de acceso. Implementa control de roles en el backend para diferenciar las acciones permitidas a la administración frente al personal operativo.
* **Prioridad:** Alta (Fundamental para la seguridad y control de accesos).

## 2. Módulo de Productos y Stock
* **Descripción:** Administración integral del catálogo de indumentaria. Permite el alta, la modificación y la baja lógica (desactivación, sin borrado físico) de productos y variantes (talles y colores), la definición del precio de venta y el control automatizado de stock (disponible, reservado y fallado) con trazabilidad de cada movimiento.
* **Prioridad:** Alta (Núcleo operativo del negocio).
* **Fuera del MVP:** carga de imágenes de productos y alertas de stock mínimo.

## 3. Módulo de Ventas y Pedidos
* **Descripción:** Registro de ventas minoristas presenciales en el local, indicando de qué stock sale cada unidad (disponible o fallado), y gestión de pedidos mayoristas con sus datos de envío, pagos parciales (seña) y estados (pendiente, confirmado, despachado, entregado, cancelado). Incluye la reserva automática de stock al crear el pedido y su liberación si vence sin confirmación ni seña.
* **Prioridad:** Alta (Proceso principal de facturación y salida de mercadería).

## 4. Módulo de Clientes
* **Descripción:** Centralización de los datos de clientes: contacto, CUIT para facturación y dirección de envío. No se distingue un tipo fijo (minorista o mayorista): el canal lo determina la operación, ya sea una venta de mostrador o un pedido con envío.
* **Prioridad:** Media.

## 5. Módulo de Proveedores y Compras
* **Descripción:** Registro de proveedores y de los ingresos de mercadería (asociando variantes, cantidades y precios de compra). Permite el ingreso de stock de forma automatizada. El acceso a los precios de compra está restringido al administrador.
* **Prioridad:** Media.

## 6. Módulo de Reportes y Estadísticas
* **Descripción:** Generación automática de reportes de ventas, rotación de productos y margen bruto (el sistema no contempla todos los demás costos del comercio, por lo que no se habla de ganancia total). Módulo de acceso exclusivo para el rol de administrador.
* **Prioridad:** Baja (Complementario para la toma de decisiones gerenciales).
