-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS ferreteria_shama;
USE ferreteria_shama;

-- Tabla de roles de empleados
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    active TINYINT(1) DEFAULT 1
);

-- Tabla de permisos
CREATE TABLE permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    active TINYINT(1) DEFAULT 1
);

-- Tabla intermedia entre roles y permisos
CREATE TABLE roles_permisos (
    rol_id INT NOT NULL,
    permiso_id INT NOT NULL,
    PRIMARY KEY (rol_id, permiso_id),
    FOREIGN KEY (rol_id) REFERENCES roles(id),
    FOREIGN KEY (permiso_id) REFERENCES permisos(id)
);

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATE,
    rol_id INT,
    active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- Tabla de sesiones de usuarios
CREATE TABLE sesiones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    fecha_inicio DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion DATE NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabla para registrar intentos fallidos de inicio de sesión
CREATE TABLE intentos_login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    ip_address VARCHAR(50) NOT NULL,
    fecha_intentos DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabla de categorías
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    active TINYINT(1) DEFAULT 1
);

-- Tabla de proveedores
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    nit VARCHAR(20),
    fecha_registro DATE,
    dias_credito INT DEFAULT 0,
    nombre_vendedor VARCHAR(255),
    active TINYINT(1) DEFAULT 1
);

-- Tabla de facturas de proveedores
CREATE TABLE facturas_proveedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT,
    numero_factura VARCHAR(50) NOT NULL,
    fecha_factura DATE NOT NULL,
    monto_total DECIMAL(10, 2) NOT NULL,
    saldo_pendiente DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores (id)
);

-- Detalles de facturas de proveedores
CREATE TABLE facturas_proveedor_d (
    id INT AUTO_INCREMENT PRIMARY KEY,
    factura_proveedor_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    marca_id INT,
    FOREIGN KEY (factura_proveedor_id) REFERENCES facturas_proveedor(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    FOREIGN KEY (marca_id) REFERENCES marcas(id)
);

-- Tabla para gestionar pagos a proveedores
CREATE TABLE pagos_proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    factura_proveedor_id INT NOT NULL,
    monto_pagado DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    forma_de_pago_id INT NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    FOREIGN KEY (factura_proveedor_id) REFERENCES facturas_proveedor(id),
    FOREIGN KEY (forma_de_pago_id) REFERENCES forma_de_pago(id)
);

-- Tabla de marcas de productos
CREATE TABLE marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    active TINYINT(1) DEFAULT 1
);

-- Tabla de productos con campos adicionales
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    imagen_url VARCHAR(500),
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fecha_creacion DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATE,
    categoria_id INT NOT NULL,
    proveedor_id INT NOT NULL,
    marca_id INT,
    active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    FOREIGN KEY (marca_id) REFERENCES marcas(id)
);

-- Tabla de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(255) UNIQUE,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active TINYINT(1) DEFAULT 1
);

-- Tabla de empleados
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    direccion TEXT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    fecha_contratacion DATE NOT NULL,
    rol_id INT,
    active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- Tabla de pedidos
CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado ENUM('Pendiente', 'Completado', 'Cancelado') NOT NULL,
    active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Detalles de pedidos
CREATE TABLE pedido_d (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de facturas
CREATE TABLE factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_factura DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Detalles de facturas
CREATE TABLE factura_d (
    id INT AUTO_INCREMENT PRIMARY KEY,
    factura_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES factura(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de órdenes de compra
CREATE TABLE orden_compra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT NOT NULL,
    fecha_orden DATE NOT NULL,
    estado ENUM('Pendiente', 'Recibido') NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

-- Detalles de órdenes de compra
CREATE TABLE orden_compra_d (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orden_compra_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orden_compra_id) REFERENCES orden_compra(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla para gestionar descuentos de productos
CREATE TABLE descuentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    porcentaje DECIMAL(5,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla para gestionar métodos de pago
CREATE TABLE forma_de_pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

-- Tabla de movimientos de inventario
CREATE TABLE movimientos_inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    tipo ENUM('Ingreso', 'Salida', 'Ajuste') NOT NULL,
    fecha_movimiento DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla para gestionar ingresos de inventario
CREATE TABLE ingreso_inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    orden_compra_id INT,
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    FOREIGN KEY (orden_compra_id) REFERENCES orden_compra(id)
);

-- Tabla para gestionar salidas de inventario
CREATE TABLE salida_inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    fecha_salida DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla para realizar ajustes de inventario
CREATE TABLE ajustes_inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cantidad_ajuste INT NOT NULL,
    fecha_ajuste DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de historial de precios
CREATE TABLE historial_precios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    precio_compra_anterior DECIMAL(10,2),
    precio_venta_anterior DECIMAL(10,2),
    fecha_cambio DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);