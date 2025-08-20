# 🧱 Modelo de Base de Datos: Tienda Online Warhammer 40K

Este proyecto define la estructura de una base de datos relacional en **MySQL** para una tienda especializada en productos del universo **Warhammer 40K**. Está diseñada para gestionar usuarios, roles, productos, inventario, órdenes, pagos, envíos y reseñas, con integridad referencial y escalabilidad.

---

## 🔹 Tablas Principales

### 1. `usuarios`
Gestión de clientes, vendedores y administradores.

- `usuario_id` (PK)  
- `nombre`  
- `apellido`  
- `email`  
- `contraseña`  
- `celular`  
- `fecha_de_registro`  
- `activo`  

### 2. `roles`
Define los tipos de usuario.

- `rol_id` (PK)  
- `rol_nombre` (Ej: Cliente, Vendedor, Administrador)

### 3. `categorias`
Clasificación de productos.

- `categorias_id` (PK)  
- `nombre_de_categoria`  
- `descripcion`

### 4. `productos`
Catálogo de artículos disponibles.

- `producto_id` (PK)  
- `vendedor_id` (FK → usuarios)  
- `categorias_id` (FK → categorias)  
- `nombres_productos`  
- `descripcion`  
- `precio`  
- `fecha_de_publicacion`  
- `activo`

### 5. `inventario`
Control de stock por producto.

- `inventario_id` (PK)  
- `producto_id` (FK → productos)  
- `cantidad_disponible`  
- `ultima_actualizacion`

### 6. `ordenes`
Registro de compras realizadas.

- `orden_id` (PK)  
- `usuario_id` (FK → usuarios)  
- `fecha_orden`  
- `total`  
- `estado` (pendiente, pagada, enviada, completada, cancelada)

### 7. `detalle_orden`
Detalle de cada producto en una orden.

- `detalle_id` (PK)  
- `orden_id` (FK → ordenes)  
- `producto_id` (FK → productos)  
- `cantidad`  
- `precio_unitario`  
- `subtotal` (calculado automáticamente)

### 8. `pagos`
Información de transacciones.

- `pago_id` (PK)  
- `orden_id` (FK → ordenes)  
- `fecha_de_pago`  
- `monto`  
- `metodo_de_pago` (tarjeta_de_credito, tarjeta_de_debito, billetera_virtual, efectivo)  
- `estado` (pendiente, aprobado, rechazado)

### 9. `envios`
Datos logísticos de entrega.

- `envio_id` (PK)  
- `orden_id` (FK → ordenes)  
- `direccion_envio`  
- `ciudad`  
- `provincia`  
- `codigo_postal`  
- `pais`  
- `fecha_de_envio`  
- `fecha_de_entrega_estimada`  
- `estado` (pendiente, en camino, entregado, cancelado)

### 10. `comentarios`
Reseñas de productos por parte de los usuarios.

- `comentario_id` (PK)  
- `producto_id` (FK → productos)  
- `usuario_id` (FK → usuarios)  
- `calificacion` (1 a 5)  
- `opinion`  
- `fecha_reseña`

---

## 📥 Inserciones de Ejemplo

```sql
-- Usuarios
INSERT INTO usuarios (nombre, apellido, email, contraseña, celular)
VALUES 
('Roboute', 'Guilliman', 'guilliman@imperium.com', 'ultramarine123', '1122334455'),
('Abaddon', 'El Saqueador', 'abaddon@chaos.net', 'warmaster666', '1199887766'),
('Inquisidora', 'Greyfax', 'greyfax@ordohereticus.org', 'purgeHeretics!', '1133445566');

-- Roles
INSERT INTO roles (rol_nombre)
VALUES ('Cliente'), ('Administrador'), ('Vendedor');

-- Categorías
INSERT INTO categorias (nombre_de_categoria, descripcion)
VALUES 
('Miniaturas', 'Figuras coleccionables de ejércitos del universo Warhammer 40K'),
('Accesorios', 'Dados, reglas, medidores y otros elementos para jugar'),
('Libros', 'Novelas y códices oficiales del lore de Warhammer 40K');

-- Productos
INSERT INTO productos (vendedor_id, categorias_id, nombres_productos, descripcion, precio)
VALUES 
(1, 1, 'Ultramarines Primaris Squad', 'Unidad de élite de los Marines Espaciales', 49.99000),
(2, 1, 'Chaos Space Marines', 'Tropa básica de los Marines del Caos', 44.50000),
(3, 2, 'Dados Imperiales', 'Set de dados temáticos del Imperio', 15.00000),
(1, 3, 'Codex: Adeptus Astartes', 'Libro de reglas y trasfondo de los Marines Espaciales', 35.00000);

-- Inventario
INSERT INTO inventario (producto_id, cantidad_disponible)
VALUES (1, 10), (2, 8), (3, 25), (4, 12);

-- Órdenes
INSERT INTO ordenes (usuario_id, total, estado)
VALUES (1, 84.99, 'pagada'), (2, 44.50, 'pendiente'), (3, 35.00, 'completada');

-- Detalle de Órdenes
INSERT INTO detalle_orden (orden_id, producto_id, cantidad, precio_unitario)
VALUES 
(1, 1, 1, 49.99),
(1, 3, 1, 15.00),
(2, 2, 1, 44.50),
(3, 4, 1, 35.00);

-- Pagos
INSERT INTO pagos (orden_id, monto, metodo_de_pago, estado)
VALUES 
(1, 84.990, 'tarjeta_de_credito', 'aprobado'),
(2, 44.500, 'efectivo', 'pendiente'),
(3, 35.000, 'billetera_virtual', 'aprobado');

-- Envíos
INSERT INTO envios (orden_id, direccion_envio, ciudad, provincia, codigo_postal)
VALUES 
(1, 'Av. Terra 40K #123', 'Macragge', 'Ultramar', '0001'),
(2, 'Fortaleza Negra S/N', 'Cadia', 'Segmentum Obscurus', '6666'),
(3, 'Templo de la Purga #77', 'Terra', 'Segmentum Solar', '1000');

-- Comentarios
INSERT INTO comentarios (producto_id, usuario_id, calificacion, opinion)
VALUES 
(1, 2, 5, 'Excelente calidad, aunque odio a los Ultramarines.'),
(2, 1, 4, 'Buen detalle, pero el caos no es lo mío.'),
(4, 3, 5, 'El códex está muy completo y bien ilustrado.');
```

---

## 🧠 Ideas Futuras

- Sistema de fidelidad con puntos acumulables por compra.  
- Lista de deseos por usuario.  
- Ofertas temporales con descuentos por producto.  
- Historial de movimientos de inventario.  
- Notificaciones por email para lanzamientos y promociones.  
- Soporte multilenguaje para expansión internacional.

---

## 🎯 Objetivo

Diseñar una base de datos sólida, escalable y especializada para una tienda temática de Warhammer 40K que permita una gestión eficiente de productos, usuarios, ventas y logística, mejorando la experiencia del cliente y facilitando la administración del negocio.

---
