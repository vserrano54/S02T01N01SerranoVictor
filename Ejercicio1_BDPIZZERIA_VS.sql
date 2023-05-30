CREATE DATABASE `BDPIZZERIA_VS`;

USE `BDPIZZERIA_VS`;

CREATE TABLE `TBL_PROVINCIA`
(
	ID_PROVINCIA INT UNSIGNED AUTO_INCREMENT NOT NULL,
    PROVINCIA VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY(ID_PROVINCIA)
);

CREATE TABLE `TBL_LOCALIDAD`
(
	ID_LOCALIDAD INT UNSIGNED AUTO_INCREMENT NOT NULL,
    LOCALIDAD VARCHAR(100) UNIQUE NOT NULL,
    ID_PROVINCIA INT UNSIGNED,
    PRIMARY KEY(ID_LOCALIDAD),
	CONSTRAINT FK_PROVINCIA_LOCALIDAD
	FOREIGN KEY (ID_PROVINCIA) REFERENCES TBL_PROVINCIA(ID_PROVINCIA)
);

CREATE TABLE `TBL_CLIENTE`
(
	ID_CLIENTE INT UNSIGNED AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(100) NOT NULL,
    APELLIDO VARCHAR(100) NOT NULL,
	DIRECCION VARCHAR(150) NOT NULL,
    CODIGOPOSTAL VARCHAR(10) NOT NULL,
    ID_PROVINCIA INT UNSIGNED,
    ID_LOCALIDAD INT UNSIGNED,
    TELEFONO VARCHAR(9) NOT NULL,
    PRIMARY KEY(ID_CLIENTE),
	CONSTRAINT FK_CLIENTE_PROVINCIA
	FOREIGN KEY (ID_PROVINCIA) REFERENCES TBL_PROVINCIA(ID_PROVINCIA),
    CONSTRAINT FK_CLIENTE_LOCALIDAD
	FOREIGN KEY (ID_LOCALIDAD) REFERENCES TBL_LOCALIDAD(ID_LOCALIDAD)
);

CREATE TABLE `TBL_PRODUCTO`
(
	ID_PRODUCTO INT UNSIGNED AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(60) NOT NULL,
    DESCRIPCION VARCHAR(100) NOT NULL,
    IMAGEN BLOB,
    PRECIO FLOAT UNSIGNED NOT NULL,
    PRIMARY KEY(ID_PRODUCTO)
);

CREATE TABLE `TBL_CATEGORIA`
(
	ID_CATEGORIA INT UNSIGNED AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(100) NOT NULL,
    PRIMARY KEY(ID_CATEGORIA)
);

CREATE TABLE `TBL_PRODUCTO_CATEGORIA`
(
	ID_PRODCUTO_CATEGORIA INT UNSIGNED AUTO_INCREMENT NOT NULL,
    ID_PRODUCTO INT UNSIGNED UNIQUE,
    ID_CATEGORIA INT UNSIGNED,
    PRIMARY KEY(ID_PRODCUTO_CATEGORIA),
    CONSTRAINT FK_TBL_PRODUCTO_CATEGORIA_TBL_PRODUCTO
	FOREIGN KEY (ID_PRODUCTO) REFERENCES TBL_PRODUCTO(ID_PRODUCTO),
	CONSTRAINT FK_TBL_PRODUCTO_CATEGORIA_TBL_CATEGORIA
	FOREIGN KEY (ID_CATEGORIA) REFERENCES TBL_CATEGORIA(ID_CATEGORIA)
);

CREATE TABLE `TBL_EMPLEADO`
(
	ID_EMPLEADO INT UNSIGNED AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(100) NOT NULL,
    APELLIDO VARCHAR(100) NOT NULL,
    NIF VARCHAR(9) NOT NULL,
    TELEFONO VARCHAR(9) NOT NULL,
    TIPO_EMPLEADO ENUM('COCINERO','REPARTIDOR'),
    PRIMARY KEY(ID_EMPLEADO)
);

CREATE TABLE `TBL_PEDIDO`
(
	ID_PEDIDO INT UNSIGNED AUTO_INCREMENT NOT NULL,
    FECHA DATE NOT NULL,
    HORA_SOLICITUD TIME NOT NULL,
    HORA_ENTREGA TIME,
    TIPO_MONTURA ENUM('REPARTO A DOMICILIO','RECOGER EN TIENDA'),
    ID_CLIENTE INT UNSIGNED NOT NULL,
    ID_EMPLEADO INT UNSIGNED NOT NULL,
    PRIMARY KEY(ID_PEDIDO),
    CONSTRAINT FK_PEDIDO_CLIENTE
	FOREIGN KEY (ID_CLIENTE) REFERENCES TBL_CLIENTE(ID_CLIENTE),
	CONSTRAINT FK_PEDIDO_EMPLEADO
	FOREIGN KEY (ID_EMPLEADO) REFERENCES TBL_EMPLEADO(ID_EMPLEADO)
);

CREATE TABLE `TBL_DETALLE_PEDIDO`
(
	ID_DETALLE INT UNSIGNED AUTO_INCREMENT NOT NULL, 
    ID_PEDIDO INT UNSIGNED,
    ID_PRODUCTO INT UNSIGNED NOT NULL,
    CANTIDAD INT UNSIGNED NOT NULL,
    PRECIO FLOAT NOT NULL,
    PRIMARY KEY(ID_DETALLE),
    CONSTRAINT FK_DETALLE_PEDIDO_PEDIDO
	FOREIGN KEY (ID_PEDIDO) REFERENCES TBL_PEDIDO(ID_PEDIDO),
	CONSTRAINT FK_DETALLE_PEDIDO_PRODUCTO
	FOREIGN KEY (ID_PRODUCTO) REFERENCES TBL_PRODUCTO(ID_PRODUCTO)
);



CREATE TABLE `TBL_TIENDA`
(
	ID_TIENDA INT UNSIGNED AUTO_INCREMENT NOT NULL,
    DIRECCION VARCHAR(150) NOT NULL,
    CODIGOPOSTAL VARCHAR(10) NOT NULL,
    ID_PROVINCIA INT UNSIGNED,
    ID_LOCALIDAD INT UNSIGNED,
    PRIMARY KEY(ID_TIENDA),
	CONSTRAINT FK_TIENDA_PROVINCIA
	FOREIGN KEY (ID_PROVINCIA) REFERENCES TBL_PROVINCIA(ID_PROVINCIA),
    CONSTRAINT FK_TIENDA_LOCALIDAD
	FOREIGN KEY (ID_LOCALIDAD) REFERENCES TBL_LOCALIDAD(ID_LOCALIDAD)
);

CREATE TABLE `TBL_TIENDA_EMPLEADO`
(
	ID_TIENDA_EMPLEADO INT UNSIGNED AUTO_INCREMENT NOT NULL,
    ID_TIENDA INT UNSIGNED,
    ID_EMPLEADO INT UNSIGNED UNIQUE,
    PRIMARY KEY(ID_TIENDA_EMPLEADO),
    CONSTRAINT FK_TBL_TIENDA_EMPLEADO_TBL_TIENDA
	FOREIGN KEY (ID_TIENDA) REFERENCES TBL_TIENDA(ID_TIENDA),
	CONSTRAINT FK_TBL_TIENDA_EMPLEADO_TBL_EMPLEADO
	FOREIGN KEY (ID_EMPLEADO) REFERENCES TBL_EMPLEADO(ID_EMPLEADO)
);

CREATE TABLE `TBL_TIENDA_PEDIDO`
(
	ID_TIENDA_PEDIDO INT UNSIGNED AUTO_INCREMENT NOT NULL,
    ID_TIENDA INT UNSIGNED,
    ID_PEDIDO INT UNSIGNED UNIQUE,
    PRIMARY KEY(ID_TIENDA_PEDIDO),
    CONSTRAINT FK_TBL_TIENDA_PEDIDO_TBL_TIENDA
	FOREIGN KEY (ID_TIENDA) REFERENCES TBL_TIENDA(ID_TIENDA),
	CONSTRAINT FK_TBL_TIENDA_PEDIDO_TBL_PEDIDO
	FOREIGN KEY (ID_PEDIDO) REFERENCES TBL_PEDIDO(ID_PEDIDO)
);



INSERT INTO TBL_PROVINCIA(PROVINCIA) VALUES ('Barcelona');
INSERT INTO TBL_PROVINCIA(PROVINCIA) VALUES ('Girona');
INSERT INTO TBL_PROVINCIA(PROVINCIA) VALUES ('Lleida');
INSERT INTO TBL_PROVINCIA(PROVINCIA) VALUES ('Tarragona');

INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Ciudad Barcelona',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Hospitalet de Llobregat',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Badalona',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Terrassa',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Sabadell',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Mataró',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Santa Coloma de Gramenet',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Cornellà de Llobregat',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Sant Cugat del Vallès',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Sant Boi de Llobregat',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Manresa',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Rubí',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Viladecans',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Vilanova i la Geltrú',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('El Prat de Llobregat',1);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Castelldefels',1);

INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Ciudad Girona',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Figueres',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Blanes',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Lloret de Mar',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Palamós',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Olot',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Salt',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Roses',2);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Palafrugell',2);

INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Ciudad Lleida',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Mollerussa',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Balaguer',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Tàrrega',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Alcarràs',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Solsona',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('La Seu dUrgell',3);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Cervera',3);

INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Ciudad Tarragona',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Reus',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Salou',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('El Vendrell',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Tortosa',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Cambrils',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Vila-seca',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Amposta',4);
INSERT INTO TBL_LOCALIDAD(LOCALIDAD,ID_PROVINCIA) VALUES ('Calafell',4);

INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('María Carmen', 'Rodríguez','calle rossello, 136','08036',1,1,'683495598');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('José', 'González','calle santander, 74','08020',1,1, '693495578');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('Manuel', 'Fernández','carretera montmelo granollers , 56','08403',1,1,'663497552');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('Francisco', 'Lopez','calle del templer guiu, 45','08184',1,1,'641429552');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('Isabel', 'Martinez','calle josep pla, 78','08019',1,1,'683215598');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('Lucia', 'Díaz','Carre Francesc Layret, 30','08911',1,3,'683495935');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('María Pilar', 'Zánchez','Pg Llorenc Serra, 8','08911',1,7,'683485593');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('Ana', 'Ruiz','Passeig del Vapor Gran, 21','08221',1,4,'683695578');
INSERT INTO TBL_CLIENTE(NOMBRE, APELLIDO, DIRECCION, CODIGOPOSTAL, ID_PROVINCIA, ID_LOCALIDAD, TELEFONO)
VALUES('Carlos', 'Gomez','C María Auxiliadora, 191','08224',1,4,'683155517');

INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Margarita','Pizza',null,8.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Pepperoni','Pizza',null,8.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Hawaiana','Pizza',null,7.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Cuatro Quesos','Pizza',null,6.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Napolitana','Pizza',null,7.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Barbacoa','Pizza',null,9.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Vegetariana','Pizza',null,6.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Marinera','Pizza',null,7.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Carbonara','Pizza',null,6.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Diavola','Pizza',null,8.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Hamburguesa clásica','Hamburguesa',null,5.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Cheeseburger','Hamburguesa',null,4.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Bacon Burger','Hamburguesa',null,3.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Hamburguesa con champiñones','Hamburguesa',null,4.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Hamburguesa de pollo','Hamburguesa',null,3.5);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Hamburguesa vegetariana','Hamburguesa',null,4.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Coca-Cola 12 onza','Bebida',null,2.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Pepsi 12 onza','Bebida',null,2.0);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Sprite 12 onza','Bebida',null,1.80);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('Fanta 12 onza','Bebida',null,1.80);
INSERT INTO TBL_PRODUCTO(NOMBRE, DESCRIPCION, IMAGEN, PRECIO)
VALUES ('7UP 12 onza','Bebida',null,1.80);

INSERT INTO TBL_CATEGORIA(NOMBRE) VALUES ('Comida');
INSERT INTO TBL_CATEGORIA(NOMBRE) VALUES ('Bebidas');
INSERT INTO TBL_CATEGORIA(NOMBRE) VALUES ('Enzaladas');


INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('JOSE', 'SALGADO','78619179G', '601448891',1);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('SERGIO', 'LOPEZ','75511647W', '620558894',1);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('DAVID', 'CRUZ','51413357P', '658558887',1);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('MAURICIO', 'SERRANO','35091936P', '638559987',1);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('ROGER', 'PEREZ','76803103P', '618550981',2);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('MARCOS', 'GONZALEZ','71504105A', '608850983',2);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('RAQUEL', 'DIAZ','31212341F', '616850991',2);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('MARIA', 'JIMENEZ','15616323J', '622850967',2);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('TANIA', 'PEREZ','55308043N', '645850951',2);
INSERT INTO TBL_EMPLEADO(NOMBRE, APELLIDO, NIF, TELEFONO, TIPO_EMPLEADO)
 VALUES ('JENNY', 'LOPEZ','49839093W', '678850957',2);

INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (1,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (2,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (3,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (4,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (5,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (6,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (7,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (8,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (9,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (10,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (11,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (12,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (13,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (14,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (15,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (16,1);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (17,2);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (18,2);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (19,2);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (20,2);
INSERT INTO TBL_PRODUCTO_CATEGORIA(ID_PRODUCTO, ID_CATEGORIA)
VALUES (21,2);

INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','9:40','10:40',1,1,5);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA,  TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','9:55','10:55',2,2,6);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','13:00','14:00',1,3,7);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','15:00','16:00',1,4,8);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','18:00','19:00',2,5,9);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','19:00','20:00',2,7,10);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','19:30','20:30',2,8,5);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','17:30','18:30',1,9,6);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-20','18:30','19:30',1,1,7);

INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','9:40','10:40',1,1,8);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','9:55','10:55',2,2,9);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','13:00','14:00',1,3,10);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','15:00','16:00',2,4,5);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','18:00','19:00',2,5,6);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','19:00','20:00',1,6,7);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','19:30','20:30',1,7,8);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','17:30','18:30',2,8,9);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-01-22','18:30','19:30',2,9,10);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','9:40','10:40',1,1,5);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','9:55','10:55',2,2,6);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','13:00','14:00',1,3,7);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','15:00','14:00',1,4,8);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','18:00','19:00',2,5,9);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','19:00','20:00',2,6,10);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','19:30','20:30',1,7,5);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','17:30','18:30',1,8,6);
INSERT INTO TBL_PEDIDO(FECHA, HORA_SOLICITUD, HORA_ENTREGA, TIPO_MONTURA,ID_CLIENTE, ID_EMPLEADO) VALUES ('2023-02-02','18:30','19:30',2,9,7);
/*PRECIO DE LOS PRODUCTOR*/
SELECT @PRECIOPROD1:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =1);
SELECT @PRECIOPROD2:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =2);
SELECT @PRECIOPROD3:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =3);
SELECT @PRECIOPROD4:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =4);
SELECT @PRECIOPROD5:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =5);
SELECT @PRECIOPROD6:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =6);
SELECT @PRECIOPROD7:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =7);
SELECT @PRECIOPROD8:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =8);
SELECT @PRECIOPROD9:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =9);
SELECT @PRECIOPROD10:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =10);
SELECT @PRECIOPROD11:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =11);
SELECT @PRECIOPROD12:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =12);
SELECT @PRECIOPROD13:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =13);
SELECT @PRECIOPROD14:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =14);
SELECT @PRECIOPROD15:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =15);
SELECT @PRECIOPROD16:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =16);
SELECT @PRECIOPROD17:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =17);
SELECT @PRECIOPROD18:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =18);
SELECT @PRECIOPROD19:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =19);
SELECT @PRECIOPROD20:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =20);
SELECT @PRECIOPROD21:=(SELECT PRECIO FROM TBL_PRODUCTO WHERE ID_PRODUCTO =21);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (1,1,2,@PRECIOPROD1);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (1,11,1,@PRECIOPROD11);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (1,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (2,3,2,@PRECIOPROD3);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (2,20,2,@PRECIOPROD20);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (3,12,3,@PRECIOPROD12);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (3,18,3,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (4,4,1,@PRECIOPROD4);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (4,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (5,2,1,@PRECIOPROD2);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (5,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (6,6,1,@PRECIOPROD6);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (6,18,1,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (7,8,1,@PRECIOPROD8);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (7,20,1,@PRECIOPROD20);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (8,14,1,@PRECIOPROD14);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (8,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (9,15,1,@PRECIOPROD15);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (9,18,1,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (10,2,1,@PRECIOPROD2);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (10,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (11,14,1,@PRECIOPROD14);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (11,19,1,@PRECIOPROD19);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (12,2,1,@PRECIOPROD2);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (12,20,1,@PRECIOPROD20);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (13,5,1,@PRECIOPROD5);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (13,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (14,11,1,@PRECIOPROD11);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (14,18,1,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (15,7,1,@PRECIOPROD7);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (15,18,1,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (16,3,2,@PRECIOPROD3);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (16,20,2,@PRECIOPROD20);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (17,12,3,@PRECIOPROD12);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (17,18,3,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (18,4,1,@PRECIOPROD4);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (18,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (19,2,1,@PRECIOPROD2);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (19,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (20,6,1,@PRECIOPROD6);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (20,18,1,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (21,8,1,@PRECIOPROD8);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (22,20,1,@PRECIOPROD20);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (23,14,1,@PRECIOPROD14);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (23,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (24,15,1,@PRECIOPROD15);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (24,18,1,@PRECIOPROD18);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (25,8,1,@PRECIOPROD8);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (25,20,1,@PRECIOPROD20);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (26,14,1,@PRECIOPROD14);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (26,17,1,@PRECIOPROD17);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (27,15,1,@PRECIOPROD15);
INSERT INTO TBL_DETALLE_PEDIDO(ID_PEDIDO,ID_PRODUCTO,CANTIDAD,PRECIO) 
VALUES (27,18,1,@PRECIOPROD18);

 INSERT INTO TBL_TIENDA(DIRECCION, CODIGOPOSTAL,ID_PROVINCIA,ID_LOCALIDAD)
 VALUES ('Gran Via de les Corts Catalanes, 972','08020',1,1);
 INSERT INTO TBL_TIENDA(DIRECCION, CODIGOPOSTAL,ID_PROVINCIA,ID_LOCALIDAD)
 VALUES ('Passatge de Simó, 21','08025',1,1);


INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(1,1);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(1,2);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(1,5);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(1,6);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(1,7);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(2,3);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(2,4);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(2,8);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(2,9);
INSERT INTO TBL_TIENDA_EMPLEADO(ID_TIENDA, ID_EMPLEADO) VALUES(2,10);


INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,1);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,2);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,3);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,4);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,5);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,6);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,7);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,8);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,9);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,10);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,11);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,12);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,13);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,14);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,15);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,16);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,17);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,18);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,19);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,20);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,21);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,22);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,23);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (2,24);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,25);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,26);
INSERT INTO TBL_TIENDA_PEDIDO(ID_TIENDA, ID_PEDIDO) VALUES (1,27);

/*
Lista cuántos productos de categoría 'Bebidas' se han vendido en una determinada localidad.
Voy a tomar la ID_LOCALIDAD = 1 que corresponde la Ciuddad de Barcelon 
que se encuentra en el ID_PROVINCIA = 1 Barcelona.
*/
/*
SELECT * FROM TBL_LOCALIDAD;
SELECT * FROM TBL_CLIENTE;
SELECT * FROM TBL_PEDIDO;
SELECT * FROM TBL_DETALLE_PEDIDO;
SELECT * FROM TBL_CATEGORIA;
SELECT * FROM TBL_EMPLEADO;
*/