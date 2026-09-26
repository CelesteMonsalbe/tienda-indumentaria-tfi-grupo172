-- =========================================================
-- Datos de prueba — cubren el recorrido vertical
-- (login → producto → variantes → ingreso → venta → movimiento)
-- y el escenario de reserva/pedido mayorista.
-- =========================================================

-- Usuarios (password_hash es un placeholder; el backend genera el hash real)
INSERT INTO usuario (nombre, email, password_hash, rol) VALUES
  ('Dueño', 'admin@tienda.com', 'reemplazar_por_hash_real', 'administrador'),
  ('Vendedora 1', 'vendedora1@tienda.com', 'reemplazar_por_hash_real', 'operativo');

-- Proveedor
INSERT INTO proveedor (nombre, contacto) VALUES
  ('Textil Flores SRL', '011-4444-5555');

-- Productos
INSERT INTO producto (nombre, descripcion, precio_venta) VALUES
  ('Remera básica algodón', 'Remera lisa de algodón peinado', 8500.00),
  ('Pantalón engomado tiro alto', 'Pantalón engomado, tiro alto, elastizado', 15000.00);

-- Variantes (talle/color)
INSERT INTO variante (producto_id, talle, color, cantidad_disponible) VALUES
  (1, 'S', 'Negro', 5),
  (1, 'M', 'Negro', 8),
  (1, 'M', 'Blanco', 3),
  (2, '38', 'Negro', 4),
  (2, '40', 'Negro', 6);

-- Ingreso de mercadería (variantes 1 y 2) + movimientos de ingreso
INSERT INTO ingreso (proveedor_id, usuario_id) VALUES (1, 1);

INSERT INTO ingreso_item (ingreso_id, variante_id, cantidad_recibida, cantidad_fallada, precio_compra) VALUES
  (1, 1, 5, 0, 4200.00),
  (1, 2, 8, 0, 4200.00);

INSERT INTO movimiento_stock (variante_id, tipo, cantidad, usuario_id, referencia_tipo, referencia_id) VALUES
  (1, 'ingreso', 5, 1, 'ingreso', 1),
  (2, 'ingreso', 8, 1, 'ingreso', 1);

-- Venta minorista de ejemplo (variante 1: talle S negro)
INSERT INTO venta (cliente_id, total, descuento, usuario_id) VALUES
  (NULL, 8500.00, 0, 2);

INSERT INTO venta_item (venta_id, variante_id, cantidad, precio_unitario_aplicado) VALUES
  (1, 1, 1, 8500.00);

UPDATE variante SET cantidad_disponible = cantidad_disponible - 1 WHERE id = 1;

INSERT INTO movimiento_stock (variante_id, tipo, cantidad, usuario_id, referencia_tipo, referencia_id) VALUES
  (1, 'venta', 1, 2, 'venta', 1);

-- Cliente mayorista + pedido pendiente (variante 3: talle M blanco), reserva de 3 unidades
INSERT INTO cliente (nombre, cuit, contacto, direccion_envio) VALUES
  ('Boutique Rosario', '30-12345678-9', '341-555-1234', 'San Martín 1234, Rosario');

INSERT INTO pedido (cliente_id, estado, direccion_envio, monto_sena, saldo_pendiente) VALUES
  (1, 'pendiente', 'San Martín 1234, Rosario', 5000.00, 10000.00);

INSERT INTO pedido_item (pedido_id, variante_id, cantidad, precio_unitario_aplicado) VALUES
  (1, 3, 3, 8500.00);

UPDATE variante
  SET cantidad_disponible = cantidad_disponible - 3, cantidad_reservada = cantidad_reservada + 3
  WHERE id = 3;

INSERT INTO movimiento_stock (variante_id, tipo, cantidad, usuario_id, referencia_tipo, referencia_id) VALUES
  (3, 'reserva', 3, 1, 'pedido', 1);
