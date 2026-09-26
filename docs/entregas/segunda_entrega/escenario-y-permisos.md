# Escenario, matriz de permisos y planificación — 2.ª etapa

*Trabajo Final — Sistema de gestión para local de indumentaria*

Este documento resuelve el escenario propuesto por el tutor y define la
matriz de permisos del sistema. Se elabora a partir del
[relevamiento con el cliente](../../relevamiento/relevamiento-2da-etapa.md).
El modelo de datos completo (entidades, atributos y diagrama) vive en
[`docs/diagramas/DER.md`](../../diagramas/DER.md); el listado de módulos,
en [`docs/modulos.md`](../../modulos.md).

## Resolución del escenario propuesto por el tutor

**Escenario:** ingresan 10 remeras distribuidas entre distintos talles; se
realizan dos ventas minoristas; posteriormente llega un pedido mayorista
que solicita varias unidades; mientras todavía está pendiente ocurre otra
venta; luego el pedido se confirma y finalmente aparece una diferencia
entre el stock físico y el sistema.

| Paso | Qué ocurre | Registro(s) generado(s) | Efecto en el stock | Quién puede realizarlo |
|---|---|---|---|---|
| 1 | Ingreso de 10 remeras distribuidas entre talles, asociado a un proveedor. | Ingreso (cabecera) + un movimiento de tipo ingreso por cada variante recibida. | Disponible +N por variante, según lo recibido. | Administrador u operativo. El precio de compra asociado queda restringido al administrador. |
| 2 | Venta minorista de una unidad (por ejemplo, talle M). | Venta + ítem de venta + movimiento de tipo venta, con el precio aplicado. | Disponible −1 en la variante vendida. | Administrador u operativo. |
| 3 | Segunda venta minorista (por ejemplo, talle S). | Ídem paso 2, sobre otra variante. | Disponible −1 en la variante vendida. | Administrador u operativo. |
| 4 | Llega un pedido mayorista que solicita varias unidades; se separan físicamente. | Pedido (estado "pendiente") + ítems de pedido + un movimiento de tipo reserva por cada variante solicitada. | Disponible −N / Reservado +N en las variantes solicitadas. | Administrador u operativo. |
| 5 | Mientras el pedido está pendiente, ocurre otra venta minorista. | Venta + ítem de venta + movimiento de tipo venta, sobre una variante con stock disponible (no reservado). | Disponible −1. El stock reservado no se modifica. | Administrador u operativo. |
| 6 | El pedido se confirma: el cliente deja seña o paga el saldo. | Pago asociado al pedido (seña o saldo) + el pedido pasa a estado "confirmado" + las unidades reservadas quedan consolidadas como egresadas. | Reservado −N (egresa definitivamente; no vuelve a disponible). | Administrador u operativo. |
| 7 | Al contar, aparece una diferencia entre el stock físico y el registrado en el sistema. | Se corrige de inmediato la cantidad disponible al valor real contado, y en simultáneo se genera un movimiento de tipo ajuste con motivo y estado "pendiente" (reclamo abierto con el proveedor). Al resolverse el reclamo, el movimiento pasa a "resuelto"; si hay reposición, esta se registra como un ingreso nuevo. | Disponible se corrige de inmediato a la cantidad real. El estado pendiente/resuelto no refleja el número de stock, sino el seguimiento del reclamo. | La corrección y el registro de la discrepancia puede realizarlos cualquier perfil; el cierre del reclamo (marcar "resuelto") queda a cargo del administrador. |

**Reglas que quedan definidas a partir del escenario:** (1) el pedido
reserva stock desde su creación, no desde su confirmación; (2) la reserva
separa físicamente las unidades, por lo que una venta posterior nunca
compromete lo reservado; (3) la confirmación del pedido no libera stock,
sino que consolida la salida; (4) un ajuste corrige el disponible de
inmediato al valor real contado; el estado pendiente/resuelto del
movimiento de ajuste refleja únicamente el seguimiento del reclamo ante el
proveedor, no si el stock ya fue corregido —que ocurre siempre en el
momento de detectar la diferencia.

## Matriz de permisos

Conforme a lo relevado (sección 2.3 del informe de la 1.ª entrega) y a lo
solicitado por el tutor, las restricciones se aplican en el backend, no
solo en la interfaz. Se definen dos perfiles: administrador (dueño) y
operativo (vendedoras).

| Operación | Administrador | Operativo |
|---|---|---|
| Gestión de usuarios y roles | Sí | No |
| Alta y edición de productos (incluye precio de venta) | Sí | No |
| Consulta de catálogo y variantes | Sí | Sí |
| Registro de venta minorista | Sí | Sí |
| Registro y gestión de pedidos mayoristas (crear, confirmar, despachar) | Sí | Sí |
| Registro de ingreso de mercadería (cantidades) | Sí | Sí |
| Registro y consulta del precio de compra a proveedores | Sí | No |
| Gestión de proveedores (alta y edición) | Sí | No |
| Registro de una discrepancia de stock (ajuste, estado pendiente) | Sí | Sí |
| Resolución definitiva de un ajuste de stock | Sí | No |
| Consulta de stock por variante (disponible, reservado, fallado) | Sí | Sí |
| Consulta del listado completo de clientes | Sí | No |
| Carga de datos de un cliente puntual al tomar un pedido | Sí | Sí |
| Reporte de ventas por producto/talle/color | Sí | No |
| Reporte de ganancias | Sí | No |

**Punto a validar con el tutor:** si el operativo puede consultar el
historial de compras de un cliente puntual al atenderlo, distinguiéndolo
de "consultar el listado completo de clientes", que sí es exclusiva del
administrador.

## Recorrido vertical — planificación

> **Nota:** este reparto se preparó bajo el supuesto de tener un primer
> recorrido funcionando para el 27/09. Según la consigna de la plataforma
> para la 2.ª entrega, en esta etapa no se sube código ni implementación;
> el desarrollo queda pendiente hasta la aprobación del tutor. Se conserva
> esta sección como planificación para la etapa siguiente, no como trabajo
> a subir en esta entrega.

Primer recorrido vertical decidido: **login → producto → variantes →
ingreso de stock → venta minorista → actualización de stock → consulta del
movimiento.** Aunque la interfaz sea sencilla, este recorrido debe
atravesar frontend, backend, PostgreSQL y reglas de negocio de punta a
punta.

**Backend / Base de datos**

- Esquema de base de datos (migraciones) según el DER.
- Autenticación (login) y middleware de validación de rol por endpoint.
- Endpoints de producto y variante (alta y consulta).
- Endpoint de ingreso de mercadería (genera movimiento de tipo ingreso).
- Endpoint de venta minorista (genera movimiento de tipo venta y descuenta stock).
- Endpoint de consulta de movimientos por variante.

**Frontend / Integración**

- Pantalla de login, con manejo de sesión y rol.
- Pantalla de productos y variantes (listado y alta).
- Pantalla de ingreso de stock.
- Pantalla de registro de venta minorista.
- Pantalla de consulta de movimientos por variante.
- Seed de datos de prueba (productos y variantes de ejemplo).

Este reparto no reemplaza la división de tareas más amplia ya acordada;
precisa específicamente qué piezas del recorrido vertical deben quedar
funcionando una vez aprobado el desarrollo.
