# 🧱 Modelo de Base de Datos: Tienda de Figuras de Warhammer 40K

Este proyecto define la estructura de una base de datos para una tienda especializada en productos del universo Warhammer 40K. Está diseñada para gestionar productos, clientes, pedidos, pagos, reseñas y funcionalidades avanzadas como fidelización, promociones y control de inventario.

---

## 🔹 Tablas Principales

### 1. Productos
- `id_producto` (PK)
- `nombre`
- `descripcion`
- `precio`
- `stock`
- `id_faccion` (FK)
- `id_categoria` (FK)
- `id_marca` (FK)
- `imagen_url`
- `edicion_limitada` (booleano)
- `id_expansion` (FK)
- `puntos_fidelidad`

### 2. Categorías
- `id_categoria` (PK)
- `nombre` (Ej: Miniatura, Pintura, Accesorio, Libro de reglas)

### 3. Marcas
- `id_marca` (PK)
- `nombre` (Ej: Games Workshop, Citadel, Forge World)

### 4. Facciones
- `id_faccion` (PK)
- `nombre` (Ej: Space Marines, Orkos, Tyranids, Necrons, etc.)

### 5. Clientes
- `id_cliente` (PK)
- `nombre`
- `email`
- `telefono`
- `direccion_envio`
- `fecha_registro`
- `puntos_acumulados`
- `fecha_ultima_compra`

### 6. Pedidos
- `id_pedido` (PK)
- `id_cliente` (FK)
- `fecha_pedido`
- `estado` (Ej: pendiente, enviado, cancelado)
- `total`
- `id_usuario` (FK)
- `codigo_tracking`

### 7. Detalle_Pedido
- `id_detalle` (PK)
- `id_pedido` (FK)
- `id_producto` (FK)
- `cantidad`
- `precio_unitario`
- `descuento_aplicado`

### 8. Métodos_de_Pago
- `id_metodo` (PK)
- `nombre` (Ej: Efectivo, Tarjeta, Transferencia, MercadoPago)

### 9. Pagos
- `id_pago` (PK)
- `id_pedido` (FK)
- `id_metodo` (FK)
- `monto`
- `fecha_pago`

### 10. Reseñas
- `id_reseña` (PK)
- `id_producto` (FK)
- `id_cliente` (FK)
- `comentario`
- `puntuacion` (1 a 5)
- `fecha`

---

## 🎯 Tablas Opcionales para Escalabilidad

### Expansiones
- `id_expansion` (PK)
- `nombre`
- `descripcion`
- `fecha_lanzamiento`

### Usuarios (Administración)
- `id_usuario` (PK)
- `nombre`
- `email`
- `rol` (admin, empleado)
- `fecha_ingreso`

### Historial_Stock
- `id_historial` (PK)
- `id_producto` (FK)
- `fecha`
- `tipo_movimiento` (entrada, salida)
- `cantidad`
- `motivo` (compra, ajuste, devolución)

### Lista_Deseos
- `id_lista` (PK)
- `id_cliente` (FK)
- `id_producto` (FK)
- `fecha_agregado`

### Ofertas
- `id_oferta` (PK)
- `id_producto` (FK)
- `descripcion`
- `porcentaje_descuento`
- `fecha_inicio`
- `fecha_fin`

---

## 🧠 Ideas Adicionales

- Sistema de fidelidad con acumulación y redención de puntos.
- Notificaciones para lanzamientos, reposiciones o descuentos.
- Sistema de tags para categorizar productos por estilo o tipo de juego.
- Soporte multilenguaje para internacionalización.

---

## 📌 Objetivo

Crear una base de datos robusta, escalable y especializada para una tienda de Warhammer 40K que permita una gestión eficiente de productos, clientes, ventas y promociones, mejorando la experiencia del usuario y facilitando la administración interna.


