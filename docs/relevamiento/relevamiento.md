# Relevamiento con el cliente — 2.ª etapa

*Trabajo Final — Sistema de gestión para local de indumentaria*

**Fecha:** [fecha de la entrevista]
**Entrevistado:** dueño del local (cliente del proyecto)
**Objetivo:** relevar las reglas de negocio reales del comercio para fundamentar el modelo de datos y las decisiones de diseño de la 2.ª entrega.

## 1. Identificación de productos y variantes

- Sin código propio ni código de proveedor: se identifican mediante nombres descriptivos que diferencian tela, estampa o diseño (por ejemplo: "Pantalón engomado tiro alto", "Top encaje de flores").
- Los nombres a veces se abrevian, y de forma distinta según quién registre, lo que constituye una fuente de inconsistencias del sistema actual.
- La curva de talles depende del producto: existen productos sin talle, con talles S/M/L y con talles numéricos (1/2/3 o 36/38/40).
- El precio no varía entre variantes de un mismo producto. Cuando una diferencia de materiales lo justifica, se trata directamente como un producto diferente.

**Implicancias para el sistema**

- Identificador interno generado por el sistema, pero búsqueda y operación diaria por nombre, con texto parcial.
- El alta de productos debe prevenir duplicados por nombres similares.
- El modelo de variantes debe admitir curvas de talle flexibles por producto, incluyendo la ausencia de talle.
- El precio se define a nivel producto.

## 2. Control de stock e ingresos

- Al ingresar mercadería se cuenta el total de unidades y, cuando es posible, también por talle y color; en ocasiones, por falta de tiempo, solo se registra el total.
- Los productos fallados se restan del total y se apartan, guardándose en depósito como cualquier otro producto a la espera de venderse como oferta cuando sea la ocasión.
- El registro se realiza en cuaderno. Parte de las unidades se destinan al mostrador y el resto se almacena en depósito, en bolsas identificadas con nombre y cantidad.
- Las diferencias entre stock físico y registrado suelen originarse en errores del proveedor: se anota la diferencia, se informa al proveedor y, si se resuelve, se suma la cantidad faltante.
- Los cambios de prenda ocurren únicamente por fallas de taller y no se lleva conteo de ellos.
- No se realizan devoluciones de clientes; la política se informa en el momento de la venta.

**Implicancias para el sistema**

- Stock controlado por variante, con movimientos que expliquen su evolución: ingreso, venta, reserva, liberación, ajuste por diferencia (con motivo y estado de resolución) y falla detectada en ingreso.
- El stock fallado es una existencia diferenciada, gestionada por cantidad al igual que el stock disponible.
- No se requiere modelar devoluciones de clientes.
- Ubicación de stock única por defecto para el MVP; la gestión de múltiples ubicaciones queda como evolución futura, fuera del alcance inicial.
- Queda planteada una decisión de diseño sobre los ingresos sin discriminación por variante (ver sección 7).

## 3. Regla de reserva de stock (pedidos mayoristas)

- Al realizar un pedido, la mercadería se reserva de inmediato: se separa físicamente del stock a la venta, con confirmación pendiente del cliente.
- La reserva vence al final del día: si el cliente no confirma ni deja seña, el pedido se desarma y las unidades vuelven a estar disponibles.
- La seña constituye un pago parcial del pedido, no una mera confirmación.
- Debido a la separación física, no ocurre que se venda mercadería comprometida en un pedido.
- Ante un eventual faltante: se consulta reposición con el proveedor o, más habitualmente, se ofrecen disculpas al cliente y se modifica el pedido con su consentimiento.

**Implicancias para el sistema**

- El pedido genera una reserva de stock desde su creación (estado "pendiente"), que descuenta disponibilidad sin constituir venta.
- Sin confirmación ni seña al cierre del día: se libera la reserva (movimiento de liberación) y se cancela el pedido.
- El pedido debe registrar los pagos asociados: la seña como pago parcial con su monto, y el saldo pendiente hasta la cancelación total.

## 4. Precios, mínimos y descuentos

- Se maneja una única lista de precios para venta minorista y mayorista.
- La diferencia entre canales está dada por mínimos de compra: en el local, un mínimo de prendas por operación (por ejemplo, 3); para envíos, un monto o cantidad mínima.
- Se realizan descuentos discrecionales por compras de monto elevado o por antigüedad del cliente, a criterio del dueño.
- Los precios se actualizan según factores económicos (costo de telas, tipo de cambio), sin frecuencia fija, también a criterio del dueño.
- El mínimo de compra no se valida de forma obligatoria: existen excepciones habituales (por ejemplo, un cliente que olvidó una unidad en su pedido del día), por lo que las vendedoras requieren libertad para operar por debajo del mínimo.

**Implicancias para el sistema**

- No se requieren listas de precios múltiples.
- La venta y el pedido deben admitir un descuento manual.
- Toda operación debe conservar el precio aplicado al momento de realizarse: las modificaciones posteriores del catálogo no alteran operaciones históricas.
- La venta de unidades falladas en oferta usa los mismos mecanismos (descuento manual y precio conservado), egresando del stock fallado.
- Los mínimos de compra no se validan de forma bloqueante: a lo sumo, una advertencia no vinculante, dejando la decisión final a la vendedora.

## 5. Reportes requeridos

- El dueño necesita principalmente: ganancias por ventas y estado del stock.
- Se releva además la necesidad de conocer cuánto se vende por día y por semana, por producto, talle y color.

**Implicancias para el sistema**

- Tres reportes prioritarios para el MVP: ventas por período con detalle por producto/talle/color, estado de stock por variante, y ganancias.
- El reporte de ganancias requiere registrar el precio de compra en el módulo de proveedores, dato de acceso restringido al perfil administrador.
- Se posterga cualquier tablero adicional hasta validar estos tres con el uso real.

## 6. Procesos relevados

**a) Venta minorista (mostrador)**

- El cliente ingresa y se le consulta qué necesita; se muestran los productos y se seleccionan.
- Se cuenta la cantidad de prendas, se suma el total por unidad y se cobra.
- Habitualmente no se registra qué productos se vendieron, únicamente el monto cobrado.
- Se repone lo vendido desde el depósito; si falta stock, se avisa y la reposición queda a criterio del dueño.

**b) Pedido mayorista**

- El pedido ingresa por WhatsApp; se verifica stock de lo solicitado y se confirma al cliente.
- Se informa el precio total. Si el cliente acepta, se solicitan datos de facturación y envío, y se envían los datos de pago.
- Confirmado el pago, se empaqueta y prepara el envío: antes de las 13 h se despacha en el día; en caso contrario, al día siguiente.
- Se recibe el número de seguimiento y se transmite al cliente. Finalmente se repone la mercadería.

**c) Ingreso de mercadería**

- Se cuenta la cantidad total recibida.
- Los fallados se restan y se apartan, quedando en depósito para su venta posterior como oferta.
- Si el tiempo lo permite y el producto lo amerita, se cuenta también por talle y color.
- Se registra en cuaderno. Se separan unidades para el mostrador y el resto se guarda en depósito en bolsas identificadas con nombre y total.

## 7. Hallazgos principales

**7.1 El detalle de la venta minorista no se registra**

- El proceso actual captura el monto cobrado pero no qué productos, talles y colores se vendieron.
- El reporte de ventas por variante, requerido por el propio negocio, es imposible de producir con el proceso actual: el dato no existe.
- El sistema no digitaliza el registro de ventas existente, sino que introduce un registro que hoy no se realiza.
- Esto convierte a la velocidad y simplicidad de la pantalla de venta en un requisito crítico: el registro por ítem debe insumir segundos para ser adoptado por las vendedoras.

**7.2 Ingresos sin discriminación por variante**

- En ocasiones el ingreso se cuenta solo por total, lo que genera una tensión con el control de stock por variante.
- Alternativa (a): exigir siempre la discriminación por variante, resolviendo la carga mediante una interfaz de grilla talle × color que la haga inmediata.
- Alternativa (b): admitir ingresos provisorios por total, marcados como pendientes de discriminación.
- Se propone la alternativa (a), dado que (b) reintroduce la inconsistencia que el sistema busca eliminar. A validar con el tutor.

**7.3 Stock fallado como existencia diferenciada**

- Las unidades falladas se apartan pero permanecen en el negocio: se guardan en depósito como cualquier otro producto, a la espera de venderse como oferta cuando sea la ocasión.
- El sistema debe distinguir tres clases de existencias por variante: disponible, reservado (pedidos pendientes) y fallado/apartado.
- El stock fallado se gestiona por cantidad, igual que el disponible, y se acompaña de una descripción de la falla (por ejemplo, "costura descosida en el lateral") que permite identificar el modelo y la falla al momento de ofrecerlo en venta.
- La venta de oferta egresa del stock fallado con precio propio.
