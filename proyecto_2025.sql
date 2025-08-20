create database e_comm3rce;
use e_comm3rce;

create table usuarios(
usuario_id int not null auto_increment primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
email varchar(100) unique not null,
contraseña varchar(90) not null,
celular varchar(40),
fecha_de_registro datetime default now(),
activo boolean default 1
);


create table roles(
rol_id int not null auto_increment primary key,
rol_nombre varchar(30)
);


create table categorias(
categorias_id int not null auto_increment primary key,
nombre_de_categoria varchar(40),
descripcion text
);


create table productos(
producto_id int not null auto_increment primary key,
vendedor_id int not null,
categorias_id int not null,
nombres_productos varchar(50) not null,
descripcion text,
precio decimal(10,5) not null,
fecha_de_publicacion datetime default now(),
activo boolean default 1,
foreign key (vendedor_id) references usuarios(usuario_id)
on update cascade
on delete cascade,
foreign key(categorias_id) references categorias(categorias_id)
);

 create table inventario(
inventario_id int auto_increment not null primary key,
producto_id int not null,
cantidad_disponible int not null default 0,
ultima_actualizacion datetime default now() on update now(),
foreign key (producto_id) references productos(producto_id)
on update cascade
on delete cascade
);


create table ordenes(
orden_id int auto_increment not null primary key,
usuario_id int not null, 
fecha_orden datetime default now(),
total decimal (10,2) not null default 0.00,
estado enum('pendiente', 'pagada', 'enviada', 'completada', 'cancelada') default 'pendiente',
foreign key (usuario_id) references usuarios(usuario_id)
on update cascade
on delete cascade
);


create table detalle_orden(
detalle_id int not null auto_increment primary key,
orden_id int not null,
producto_id int not null,
cantidad int not null default 1,
precio_unitario decimal(10,2) not null,
subtotal decimal(10,2) generated always as (cantidad * precio_unitario) stored,
foreign key (orden_id) references ordenes(orden_id)
on update cascade
on delete cascade,
foreign key (producto_id) references productos(producto_id)
on update cascade
on delete cascade
);
 
 
 create table pagos(
 pago_id int not null auto_increment primary key,
 orden_id int not null,
 fecha_de_pago datetime default now(),
 monto decimal(10,3) not null,
 metodo_de_pago enum('tarjeta_de_credito', 'tarjeta_de_debito', 'billetera_virtual', 'efectivo') not null,
 estado_pago enum ('pendiente', 'aprobado', 'rechazado') default 'pendiente',
 foreign key (orden_id) references ordenes(orden_id)
 on update cascade
 on delete cascade
 );
 
 
 create table envios(
 envio_id int not null auto_increment primary key,
 orden_id int not null,
 direccion_envio varchar(300) not null,
 ciudad varchar(110) not null,
 provincia varchar(200) not null,
 codigo_postal varchar(100) not null,
 pais varchar(70) not null default 'ARGENTINA',
 fecha_de_envio datetime default now(),
 fecha_de_entrega_estimada date,
 estado_envio enum('pendiente', 'en camino', 'entregado', 'cancelado') default 'pendiente',
 foreign key (orden_id) references ordenes(orden_id)
on update cascade
on delete cascade
);


create table comentarios(
comentario_id int not null auto_increment primary key,
producto_id int not null,
usuario_id int not null,
calificacion tinyint not null check(calificacion between 1 and 5),
opinion text,
fecha_reseña datetime default now(),
foreign key (producto_id) references productos(producto_id)
on update cascade 
on delete cascade,
foreign key (usuario_id) references usuarios (usuario_id)
on update cascade
on delete cascade
);

INSERT INTO usuarios (nombre, apellido, email, contraseña, celular)
VALUES 
('Roboute', 'Guilliman', 'guilliman@imperium.com', 'ultramarine123', '1122334455'),
('Abaddon', 'El Saqueador', 'abaddon@chaos.net', 'warmaster666', '1199887766'),
('Inquisidora', 'Greyfax', 'greyfax@ordohereticus.org', 'purgeHeretics!', '1133445566');

INSERT INTO roles (rol_nombre)
VALUES 
('Cliente'),
('Administrador'),
('Vendedor');

INSERT INTO categorias (nombre_de_categoria, descripcion)
VALUES 
('Miniaturas', 'Figuras coleccionables de ejércitos del universo Warhammer 40K'),
('Accesorios', 'Dados, reglas, medidores y otros elementos para jugar'),
('Libros', 'Novelas y códices oficiales del lore de Warhammer 40K');

INSERT INTO productos (vendedor_id, categorias_id, nombres_productos, descripcion, precio)
VALUES 
(1, 1, 'Ultramarines Primaris Squad', 'Unidad de élite de los Marines Espaciales', 49.99000),
(2, 1, 'Chaos Space Marines', 'Tropa básica de los Marines del Caos', 44.50000),
(3, 2, 'Dados Imperiales', 'Set de dados temáticos del Imperio', 15.00000),
(1, 3, 'Codex: Adeptus Astartes', 'Libro de reglas y trasfondo de los Marines Espaciales', 35.00000);

INSERT INTO inventario (producto_id, cantidad_disponible)
VALUES 
(1, 10),
(2, 8),
(3, 25),
(4, 12);

INSERT INTO ordenes (usuario_id, total, estado)
VALUES 
(1, 84.99, 'pagada'),
(2, 44.50, 'pendiente'),
(3, 35.00, 'completada');

INSERT INTO detalle_orden (orden_id, producto_id, cantidad, precio_unitario)
VALUES 
(1, 1, 1, 49.99),
(1, 3, 1, 15.00),
(2, 2, 1, 44.50),
(3, 4, 1, 35.00);

INSERT INTO pagos (orden_id, monto, metodo_de_pago, estado)
VALUES 
(1, 84.990, 'tarjeta_de_credito', 'aprobado'),
(2, 44.500, 'efectivo', 'pendiente'),
(3, 35.000, 'billetera_virtual', 'aprobado');

INSERT INTO envios (orden_id, direccion_envio, ciudad, provincia, codigo_postal)
VALUES 
(1, 'Av. Terra 40K #123', 'Macragge', 'Ultramar', '0001'),
(2, 'Fortaleza Negra S/N', 'Cadia', 'Segmentum Obscurus', '6666'),
(3, 'Templo de la Purga #77', 'Terra', 'Segmentum Solar', '1000');

INSERT INTO comentarios (producto_id, usuario_id, calificacion, opinion)
VALUES 
(1, 2, 5, 'Excelente calidad, aunque odio a los Ultramarines.'),
(2, 1, 4, 'Buen detalle, pero el caos no es lo mío.'),
(4, 3, 5, 'El códex está muy completo y bien ilustrado.');