-- =========================================================
-- Sistema de gestión — Tienda de indumentaria
-- Esquema de base de datos (PostgreSQL 14+)
-- =========================================================

-- ---------- Tipos enumerados ----------
CREATE TYPE rol_usuario AS ENUM ('administrador', 'operativo');
CREATE TYPE tipo_movimiento AS ENUM ('ingreso', 'venta', 'reserva', 'confirmacion_pedido', 'ajuste');
CREATE TYPE estado_ajuste AS ENUM ('pendiente', 'resuelto');
CREATE TYPE estado_pedido AS ENUM ('pendiente', 'confirmado', 'despachado', 'entregado', 'cancelado');

-- ---------- Usuario ----------
CREATE TABLE usuario (
  id             SERIAL PRIMARY KEY,
  nombre         VARCHAR(100) NOT NULL,
  email          VARCHAR(150) NOT NULL UNIQUE,
  password_hash  VARCHAR(255) NOT NULL,
  rol            rol_usuario NOT NULL,
  creado_en      TIMESTAMP NOT NULL DEFAULT now()
);

-- ---------- Producto y Variante ----------
CREATE TABLE producto (
  id            SERIAL PRIMARY KEY,
  nombre        VARCHAR(150) NOT NULL,
  descripcion   TEXT,
  precio_venta  NUMERIC(10,2) NOT NULL CHECK (precio_venta >= 0),
  creado_en     TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE variante (
  id                   SERIAL PRIMARY KEY,
  producto_id          INTEGER NOT NULL REFERENCES producto(id) ON DELETE CASCADE,
  talle                VARCHAR(20),
  color                VARCHAR(40),
  cantidad_disponible  INTEGER NOT NULL DEFAULT 0 CHECK (cantidad_disponible >= 0),
  cantidad_reservada   INTEGER NOT NULL DEFAULT 0 CHECK (cantidad_reservada >= 0),
  cantidad_fallada     INTEGER NOT NULL DEFAULT 0 CHECK (cantidad_fallada >= 0),
  descripcion_falla    TEXT,
  UNIQUE (producto_id, talle, color)
);

-- ---------- Cliente y Proveedor ----------
CREATE TABLE cliente (
  id               SERIAL PRIMARY KEY,
  nombre           VARCHAR(150) NOT NULL,
  cuit             VARCHAR(15),
  contacto         VARCHAR(150),
  direccion_envio  TEXT,
  creado_en        TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE proveedor (
  id        SERIAL PRIMARY KEY,
  nombre    VARCHAR(150) NOT NULL,
  contacto  VARCHAR(150)
);

-- ---------- Venta ----------
CREATE TABLE venta (
  id           SERIAL PRIMARY KEY,
  fecha        TIMESTAMP NOT NULL DEFAULT now(),
  cliente_id   INTEGER REFERENCES cliente(id),
  total        NUMERIC(10,2) NOT NULL CHECK (total >= 0),
  descuento    NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (descuento >= 0),
  usuario_id   INTEGER NOT NULL REFERENCES usuario(id)
);

CREATE TABLE venta_item (
  id                        SERIAL PRIMARY KEY,
  venta_id                  INTEGER NOT NULL REFERENCES venta(id) ON DELETE CASCADE,
  variante_id               INTEGER NOT NULL REFERENCES variante(id),
  cantidad                  INTEGER NOT NULL CHECK (cantidad > 0),
  precio_unitario_aplicado  NUMERIC(10,2) NOT NULL CHECK (precio_unitario_aplicado >= 0)
);

-- ---------- Pedido (mayorista) ----------
CREATE TABLE pedido (
  id                  SERIAL PRIMARY KEY,
  cliente_id          INTEGER NOT NULL REFERENCES cliente(id),
  fecha               TIMESTAMP NOT NULL DEFAULT now(),
  estado              estado_pedido NOT NULL DEFAULT 'pendiente',
  direccion_envio     TEXT,
  numero_seguimiento  VARCHAR(100),
  monto_sena          NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (monto_sena >= 0),
  saldo_pendiente     NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (saldo_pendiente >= 0)
);

CREATE TABLE pedido_item (
  id                        SERIAL PRIMARY KEY,
  pedido_id                 INTEGER NOT NULL REFERENCES pedido(id) ON DELETE CASCADE,
  variante_id               INTEGER NOT NULL REFERENCES variante(id),
  cantidad                  INTEGER NOT NULL CHECK (cantidad > 0),
  precio_unitario_aplicado  NUMERIC(10,2) NOT NULL CHECK (precio_unitario_aplicado >= 0)
);

-- ---------- Ingreso de mercadería ----------
CREATE TABLE ingreso (
  id            SERIAL PRIMARY KEY,
  proveedor_id  INTEGER NOT NULL REFERENCES proveedor(id),
  fecha         TIMESTAMP NOT NULL DEFAULT now(),
  usuario_id    INTEGER NOT NULL REFERENCES usuario(id)
);

CREATE TABLE ingreso_item (
  id                  SERIAL PRIMARY KEY,
  ingreso_id          INTEGER NOT NULL REFERENCES ingreso(id) ON DELETE CASCADE,
  variante_id         INTEGER NOT NULL REFERENCES variante(id),
  cantidad_recibida   INTEGER NOT NULL CHECK (cantidad_recibida >= 0),
  cantidad_fallada    INTEGER NOT NULL DEFAULT 0 CHECK (cantidad_fallada >= 0),
  precio_compra       NUMERIC(10,2) NOT NULL CHECK (precio_compra >= 0)
);

-- ---------- Movimiento de stock (trazabilidad) ----------
CREATE TABLE movimiento_stock (
  id               SERIAL PRIMARY KEY,
  variante_id      INTEGER NOT NULL REFERENCES variante(id),
  tipo             tipo_movimiento NOT NULL,
  cantidad         INTEGER NOT NULL,          -- siempre positiva, excepto en 'ajuste' (donde el signo indica sobrante/faltante)
  fecha            TIMESTAMP NOT NULL DEFAULT now(),
  motivo           TEXT,
  estado           estado_ajuste,             -- solo aplica cuando tipo = 'ajuste'
  usuario_id       INTEGER NOT NULL REFERENCES usuario(id),
  referencia_tipo  VARCHAR(20),                -- 'venta' | 'pedido' | 'ingreso' (referencia informativa)
  referencia_id    INTEGER
);

-- ---------- Índices de apoyo ----------
CREATE INDEX idx_variante_producto     ON variante(producto_id);
CREATE INDEX idx_movimiento_variante   ON movimiento_stock(variante_id);
CREATE INDEX idx_venta_item_venta      ON venta_item(venta_id);
CREATE INDEX idx_pedido_item_pedido    ON pedido_item(pedido_id);
CREATE INDEX idx_ingreso_item_ingreso  ON ingreso_item(ingreso_id);
CREATE INDEX idx_pedido_cliente        ON pedido(cliente_id);
CREATE INDEX idx_venta_cliente         ON venta(cliente_id);

-- Evita dos variantes "vacías" (sin talle ni color) para el mismo producto,
-- caso no cubierto por el UNIQUE(producto_id, talle, color) ya que NULL
-- nunca se considera igual a otro NULL.
CREATE UNIQUE INDEX idx_variante_sin_talle_color
  ON variante (producto_id)
  WHERE talle IS NULL AND color IS NULL;
