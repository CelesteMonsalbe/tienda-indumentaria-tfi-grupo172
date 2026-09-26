# Modelo de datos — Diagrama entidad-relación

Base relacional (PostgreSQL). Este archivo es la versión legible del modelo;
el detalle ejecutable está en [`schema.sql`](../../database/schema.sql), los datos de
prueba en [`seed.sql`](../../database/seed.sql) y una versión editable en
[`modelo.dbml`](./modelo.dbml) (para abrir en dbdiagram.io).

## Diagrama

```mermaid
erDiagram
    PRODUCTO ||--o{ VARIANTE : tiene
    VARIANTE ||--o{ MOVIMIENTO_STOCK : registra
    VARIANTE ||--o{ VENTA_ITEM : "vendida en"
    VARIANTE ||--o{ PEDIDO_ITEM : "solicitada en"
    VARIANTE ||--o{ INGRESO_ITEM : "recibida en"
    VENTA ||--o{ VENTA_ITEM : contiene
    CLIENTE ||--o{ VENTA : "compra (opcional)"
    CLIENTE ||--o{ PEDIDO : realiza
    PEDIDO ||--o{ PEDIDO_ITEM : contiene
    PROVEEDOR ||--o{ INGRESO : provee
    INGRESO ||--o{ INGRESO_ITEM : contiene
    USUARIO ||--o{ VENTA : registra
    USUARIO ||--o{ INGRESO : registra
    USUARIO ||--o{ MOVIMIENTO_STOCK : ejecuta

    USUARIO {
        int id PK
        varchar_100 nombre
        varchar_150 email UK
        varchar_255 password_hash
        rol_usuario rol
        timestamp creado_en
    }

    PRODUCTO {
        int id PK
        varchar_150 nombre
        text descripcion
        numeric_10_2 precio_venta
        timestamp creado_en
    }

    VARIANTE {
        int id PK
        int producto_id FK
        varchar_20 talle
        varchar_40 color
        int cantidad_disponible
        int cantidad_reservada
        int cantidad_fallada
        text descripcion_falla
    }

    CLIENTE {
        int id PK
        varchar_150 nombre
        varchar_15 cuit
        varchar_150 contacto
        text direccion_envio
        timestamp creado_en
    }

    PROVEEDOR {
        int id PK
        varchar_150 nombre
        varchar_150 contacto
    }

    VENTA {
        int id PK
        timestamp fecha
        int cliente_id FK
        numeric_10_2 total
        numeric_10_2 descuento
        int usuario_id FK
    }

    VENTA_ITEM {
        int id PK
        int venta_id FK
        int variante_id FK
        int cantidad
        numeric_10_2 precio_unitario_aplicado
    }

    PEDIDO {
        int id PK
        int cliente_id FK
        timestamp fecha
        estado_pedido estado
        text direccion_envio
        varchar_100 numero_seguimiento
        numeric_10_2 monto_sena
        numeric_10_2 saldo_pendiente
    }

    PEDIDO_ITEM {
        int id PK
        int pedido_id FK
        int variante_id FK
        int cantidad
        numeric_10_2 precio_unitario_aplicado
    }

    INGRESO {
        int id PK
        int proveedor_id FK
        timestamp fecha
        int usuario_id FK
    }

    INGRESO_ITEM {
        int id PK
        int ingreso_id FK
        int variante_id FK
        int cantidad_recibida
        int cantidad_fallada
        numeric_10_2 precio_compra
    }

    MOVIMIENTO_STOCK {
        int id PK
        int variante_id FK
        tipo_movimiento tipo
        int cantidad
        timestamp fecha
        text motivo
        estado_ajuste estado
        int usuario_id FK
        varchar_20 referencia_tipo
        int referencia_id
    }
```

*(Los tipos con guion bajo, ej. `numeric_10_2`, representan `numeric(10,2)`;
es una limitación de sintaxis de Mermaid, no del esquema real — ver
`schema.sql` para los tipos exactos.)*

## Entidades por función

**Catálogo** — `PRODUCTO`, `VARIANTE`: el precio vive en el producto; cada
variante (talle/color) mantiene tres contadores de stock independientes
(disponible, reservado, fallado).

**Ventas** — `VENTA`, `VENTA_ITEM`: venta de mostrador, cliente opcional
(puede ser anónima).

**Pedidos mayoristas** — `CLIENTE`, `PEDIDO`, `PEDIDO_ITEM`: el pedido
reserva stock desde su creación; guarda seña, saldo y dirección de envío
propias.

**Abastecimiento** — `PROVEEDOR`, `INGRESO`, `INGRESO_ITEM`: cada ingreso
agrupa lo recibido de un proveedor, con precio de compra por ítem.

**Trazabilidad** — `MOVIMIENTO_STOCK`: historial de todo cambio de stock
(ingreso, venta, reserva, confirmación de pedido, ajuste).

**Usuarios** — `USUARIO`: dos roles (administrador / operativo); los
permisos se validan en el backend, no en la base.

## Decisiones de diseño

- El precio y la dirección de envío se copian al momento de la operación
  (`venta_item`, `pedido_item`, `pedido.direccion_envio`): un cambio
  posterior en el catálogo o en el cliente no altera operaciones ya
  registradas.
- El stock de una variante son tres contadores actuales (disponible,
  reservado, fallado), respaldados por el historial en `movimiento_stock`.
- En un ajuste, el stock se corrige de inmediato; el campo `estado`
  (pendiente/resuelto) refleja solo el seguimiento del reclamo con el
  proveedor, no si el número ya fue corregido.
- `cliente` no tiene un tipo fijo (minorista/mayorista): la diferencia está
  en el canal de la operación (`venta` vs. `pedido`), no en la persona.
- `movimiento_stock.cantidad` es siempre positiva (representa cuántas
  unidades se movieron); el efecto lo determina `tipo`, no el signo. La
  única excepción es `ajuste`, donde el signo sí importa: positivo si sobró
  stock, negativo si faltó.
- `variante` no admite dos filas idénticas para el mismo producto
  (`UNIQUE(producto_id, talle, color)`), incluyendo el caso de productos sin
  variantes (índice único parcial adicional en `schema.sql`).

## Archivos relacionados

- [`schema.sql`](../../database/schema.sql) — script DDL ejecutable.
- [`seed.sql`](../../database/seed.sql) — datos de prueba.
- [`modelo.dbml`](./modelo.dbml) — versión editable para dbdiagram.io.
