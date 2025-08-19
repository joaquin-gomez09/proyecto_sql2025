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
 estado enum ('pendiente', 'aprobado', 'rechazado') default 'pendiente',
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
 estado enum('pendiente', 'en camino', 'entregado', 'cancelado') default 'pendiente',
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