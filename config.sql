-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS fshama_sys;

USE fshama_sys;

-- Tabla de roles de empleados
CREATE TABLE
    roles (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de permisos
CREATE TABLE
    permisos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla intermedia entre roles y permisos
CREATE TABLE
    roles_permisos (
        rol_id INT NOT NULL,
        permiso_id INT NOT NULL,
        PRIMARY KEY (rol_id, permiso_id),
        FOREIGN KEY (rol_id) REFERENCES roles (id),
        FOREIGN KEY (permiso_id) REFERENCES permisos (id)
    );

-- Tabla de usuarios
CREATE TABLE
    usuarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        ultimo_login DATETIME,
        rol_id INT,
        active TINYINT (1) DEFAULT 1,
        FOREIGN KEY (rol_id) REFERENCES roles (id)
    );

-- Tabla de sesiones de usuarios
CREATE TABLE
    sesiones (
        id INT AUTO_INCREMENT PRIMARY KEY,
        usuario_id INT NOT NULL,
        token VARCHAR(255) NOT NULL UNIQUE,
        fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        fecha_expiracion DATETIME NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
    );

-- Tabla para registrar intentos fallidos de inicio de sesión
CREATE TABLE
    intentos_login (
        id INT AUTO_INCREMENT PRIMARY KEY,
        usuario_id INT NOT NULL,
        ip_address VARCHAR(50) NOT NULL,
        fecha_intentos DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
    );

-- Tabla de categorías
CREATE TABLE
    categorias (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT NOT NULL,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de marcas de productos
CREATE TABLE
    marcas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de unidades de medida
CREATE TABLE
    unidades_medida (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de proveedores
CREATE TABLE
    proveedores (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        direccion TEXT NOT NULL,
        telefono VARCHAR(20) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        nit VARCHAR(20),
        dias_credito INT DEFAULT 0,
        nombre_vendedor VARCHAR(255),
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de productos
CREATE TABLE
    productos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        codigo VARCHAR(10) UNIQUE,
        nombre VARCHAR(255) NOT NULL,
        descripcion TEXT NOT NULL,
        imagen_url VARCHAR(500),
        precio_compra DECIMAL(10, 2) NOT NULL,
        precio_venta DECIMAL(10, 2) NOT NULL,
        stock INT NOT NULL DEFAULT 0,
        categoria_id INT NOT NULL,
        proveedor_id INT NOT NULL,
        marca_id INT,
        unidad_medida_id INT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (categoria_id) REFERENCES categorias (id),
        FOREIGN KEY (proveedor_id) REFERENCES proveedores (id),
        FOREIGN KEY (marca_id) REFERENCES marcas (id),
        FOREIGN KEY (unidad_medida_id) REFERENCES unidades_medida (id)
    );

-- Tabla de facturas de proveedores
CREATE TABLE
    facturas_proveedor (
        id INT AUTO_INCREMENT PRIMARY KEY,
        proveedor_id INT,
        numero_factura VARCHAR(50) NOT NULL,
        fecha_factura DATETIME NOT NULL,
        monto_total DECIMAL(10, 2) NOT NULL,
        saldo_pendiente DECIMAL(10, 2) NOT NULL,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT fk_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores (id)
    );

-- Detalles de facturas de proveedores
CREATE TABLE
    facturas_proveedor_d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        factura_proveedor_id INT NOT NULL,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        precio_compra DECIMAL(10, 2) NOT NULL,
        marca_id INT,
        active TINYINT (1) DEFAULT 1,
        FOREIGN KEY (factura_proveedor_id) REFERENCES facturas_proveedor (id),
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        FOREIGN KEY (marca_id) REFERENCES marcas (id)
    );

-- Tabla de tipo de cliente (Reemplaza ENUM en clientes)
CREATE TABLE
    tipo_cliente (
        id INT AUTO_INCREMENT PRIMARY KEY,
        tipo VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT
    );

-- Departamentos
CREATE TABLE
    departamentos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE
    );

-- Municipios
CREATE TABLE
    municipios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        departamento_id INT NOT NULL,
        nombre VARCHAR(255) NOT NULL,
        FOREIGN KEY (departamento_id) REFERENCES departamentos (id)
    );

-- Aldeas
CREATE TABLE
    aldeas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        municipio_id INT NOT NULL,
        nombre VARCHAR(255) NOT NULL,
        FOREIGN KEY (municipio_id) REFERENCES municipios (id)
    );

-- Modificación de la tabla de clientes para usar tipo_cliente_id en lugar de ENUM
CREATE TABLE
    clientes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nit VARCHAR(15) NOT NULL UNIQUE,
        nombre VARCHAR(255) NOT NULL,
        apellido VARCHAR(255) NOT NULL,
        direccion_facturacion TEXT NOT NULL,
        direccion_entrega TEXT NOT NULL,
        aldea_id INT, -- Referencia a la tabla de aldeas
        municipio_id INT, -- Referencia a la tabla de municipios
        departamento_id INT, -- Referencia a la tabla de departamentos
        pais VARCHAR(255) DEFAULT 'Guatemala',
        telefono VARCHAR(20),
        email VARCHAR(255) UNIQUE,
        tipo_cliente_id INT NOT NULL,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        active TINYINT (1) DEFAULT 1,
        FOREIGN KEY (tipo_cliente_id) REFERENCES tipo_cliente (id),
        FOREIGN KEY (departamento_id) REFERENCES departamentos (id),
        FOREIGN KEY (municipio_id) REFERENCES municipios (id),
        FOREIGN KEY (aldea_id) REFERENCES aldeas (id)
    );

-- Tabla de sucursales de clientes
CREATE TABLE
    sucursales (
        id INT AUTO_INCREMENT PRIMARY KEY,
        cliente_id INT NOT NULL,
        nit_sucursal VARCHAR(15),
        nombre_sucursal VARCHAR(255) NOT NULL,
        direccion_sucursal TEXT NOT NULL,
        ciudad_sucursal VARCHAR(255),
        departamento_sucursal VARCHAR(255),
        telefono_sucursal VARCHAR(20),
        email_sucursal VARCHAR(255),
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id)
    );

-- Tabla de empleados
CREATE TABLE
    empleados (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL,
        apellido VARCHAR(255),
        direccion TEXT,
        telefono VARCHAR(20) NOT NULL,
        email VARCHAR(255) UNIQUE,
        fecha_contratacion DATETIME NOT NULL,
        rol_id INT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (rol_id) REFERENCES roles (id)
    );

-- Tabla de estado de pedidos (Reemplaza ENUM en pedido)
CREATE TABLE
    estado_pedido (
        id INT AUTO_INCREMENT PRIMARY KEY,
        estado VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT
    );

-- Tabla de métodos de envío
CREATE TABLE
    metodo_envio (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT,
        tiempo_estimado VARCHAR(255), -- Ejemplo: '24-48 horas', '3-5 días laborables', etc.
        costo DECIMAL(10, 2), -- Costo del envío
        observaciones TEXT -- Cualquier nota o detalle adicional sobre el método de envío
    );

-- Modificación de la tabla de pedidos para usar estado_pedido_id en lugar de ENUM
CREATE TABLE
    pedido (
        id INT AUTO_INCREMENT PRIMARY KEY,
        cliente_id INT NOT NULL,
        sucursal_id INT,
        fecha_pedido DATETIME NOT NULL,
        fecha_estimada_entrega DATETIME,
        estado_pedido_id INT NOT NULL,
        total DECIMAL(10, 2) NOT NULL,
        metodo_envio_id INT, -- Asumiendo que existe una tabla para métodos de envío
        observaciones_pedido TEXT,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id),
        FOREIGN KEY (sucursal_id) REFERENCES sucursales (id),
        FOREIGN KEY (estado_pedido_id) REFERENCES estado_pedido (id),
        FOREIGN KEY (metodo_envio_id) REFERENCES metodo_envio (id)
    );

-- Detalles de pedidos
CREATE TABLE
    pedido_d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        pedido_id INT NOT NULL,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        precio DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (pedido_id) REFERENCES pedido (id),
        FOREIGN KEY (producto_id) REFERENCES productos (id)
    );

-- Tabla de facturas
CREATE TABLE
    factura (
        id INT AUTO_INCREMENT PRIMARY KEY,
        pedido_id INT,
        cliente_id INT NOT NULL,
        fecha_factura DATETIME NOT NULL,
        serie VARCHAR(10),
        numero_factura INT,
        autorizacion VARCHAR(255),
        total DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id),
        FOREIGN KEY (pedido_id) REFERENCES pedido (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Detalles de facturas
CREATE TABLE
    factura_d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        factura_id INT NOT NULL,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        precio DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (factura_id) REFERENCES factura (id),
        FOREIGN KEY (producto_id) REFERENCES productos (id)
    );

-- Tabla de estado de órdenes de compra (Reemplaza ENUM en orden_compra)
CREATE TABLE
    estado_orden_compra (
        id INT AUTO_INCREMENT PRIMARY KEY,
        estado VARCHAR(255) NOT NULL UNIQUE,
        descripcion TEXT
    );

-- Modificación de la tabla de órdenes de compra para usar estado_orden_compra_id en lugar de ENUM
CREATE TABLE
    orden_compra (
        id INT AUTO_INCREMENT PRIMARY KEY,
        proveedor_id INT NOT NULL,
        fecha_orden DATETIME NOT NULL,
        estado_orden_compra_id INT NOT NULL,
        FOREIGN KEY (proveedor_id) REFERENCES proveedores (id),
        FOREIGN KEY (estado_orden_compra_id) REFERENCES estado_orden_compra (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Detalles de órdenes de compra
CREATE TABLE
    orden_compra_d (
        id INT AUTO_INCREMENT PRIMARY KEY,
        orden_compra_id INT NOT NULL,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        precio_compra DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (orden_compra_id) REFERENCES orden_compra (id),
        FOREIGN KEY (producto_id) REFERENCES productos (id)
    );

-- Tabla para gestionar descuentos de productos
CREATE TABLE
    descuentos (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        porcentaje DECIMAL(5, 2) NOT NULL,
        fecha_inicio DATETIME NOT NULL,
        fecha_fin DATETIME NOT NULL,
        active TINYINT (1) DEFAULT 1,
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla para gestionar métodos de pago
CREATE TABLE
    forma_de_pago (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        descripcion TEXT,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla para gestionar pagos a proveedores
CREATE TABLE
    pagos_proveedores (
        id INT AUTO_INCREMENT PRIMARY KEY,
        proveedor_id INT NOT NULL,
        factura_proveedor_id INT NOT NULL,
        monto_pagado DECIMAL(10, 2) NOT NULL,
        fecha_pago DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        forma_de_pago_id INT NOT NULL,
        active TINYINT (1) DEFAULT 1,
        FOREIGN KEY (proveedor_id) REFERENCES proveedores (id),
        FOREIGN KEY (factura_proveedor_id) REFERENCES facturas_proveedor (id),
        FOREIGN KEY (forma_de_pago_id) REFERENCES forma_de_pago (id)
    );

-- Tabla de movimientos de inventario
CREATE TABLE
    movimientos_inventario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        tipo ENUM ('Ingreso', 'Salida', 'Ajuste') NOT NULL,
        fecha_movimiento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        motivo TEXT,
        orden_compra_id INT,
        factura_id INT,
        ajuste_id INT,
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        FOREIGN KEY (orden_compra_id) REFERENCES orden_compra (id),
        FOREIGN KEY (factura_id) REFERENCES factura (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla para gestionar ingresos de inventario
CREATE TABLE
    ingreso_inventario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        fecha_ingreso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        orden_compra_id INT,
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        FOREIGN KEY (orden_compra_id) REFERENCES orden_compra (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla para gestionar salidas de inventario
CREATE TABLE
    salida_inventario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        fecha_salida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        motivo TEXT NOT NULL,
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla para realizar ajustes de inventario
CREATE TABLE
    ajustes_inventario (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        cantidad_ajuste INT NOT NULL,
        fecha_ajuste DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        motivo TEXT NOT NULL,
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de historial de precios
CREATE TABLE
    historial_precios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        precio_compra_anterior DECIMAL(10, 2),
        precio_venta_anterior DECIMAL(10, 2),
        fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (producto_id) REFERENCES productos (id)
    );

-- Tablas auxiliares por si crece la ferretería, de momento las creo pero no las uso mucho
-- Tabla de unidades de mayoreo (fardo, caja, palet, etc.)
CREATE TABLE
    unidades_mayoreo (
        id INT AUTO_INCREMENT PRIMARY KEY,
        tipo VARCHAR(255) NOT NULL, -- Ejemplo: Fardo, Caja, Palet o Contenedor
        cantidad_unidades INT NOT NULL, -- Ejemplo: 1000 tornillos en un fardo
        producto_id INT NOT NULL,
        fecha_compra DATETIME NOT NULL,
        active TINYINT (1) DEFAULT 1,
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de logística y envío
CREATE TABLE
    logistica_envio (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre_agencia VARCHAR(255) NOT NULL,
        tiempo_estimado_envio VARCHAR(255),
        costo DECIMAL(10, 2),
        observaciones TEXT,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de almacenes o bodegas
CREATE TABLE
    almacenes (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(255) NOT NULL UNIQUE,
        direccion TEXT,
        ciudad VARCHAR(255),
        departamento VARCHAR(255),
        pais VARCHAR(255) DEFAULT 'Guatemala',
        telefono VARCHAR(20),
        capacidad_maxima DECIMAL(10, 2),
        capacidad_actual DECIMAL(10, 2) DEFAULT 0,
        active TINYINT (1) DEFAULT 1,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Tabla de ubicaciones de producto dentro de un almacén
CREATE TABLE
    ubicaciones_almacen (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producto_id INT NOT NULL,
        almacen_id INT NOT NULL,
        cantidad DECIMAL(10, 2) NOT NULL,
        estante VARCHAR(50),
        fila VARCHAR(50),
        columna VARCHAR(50),
        FOREIGN KEY (producto_id) REFERENCES productos (id),
        FOREIGN KEY (almacen_id) REFERENCES almacenes (id),
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Índices opcionales para mejorar la velocidad de consultas
CREATE INDEX idx_username ON usuarios (username);

CREATE INDEX idx_email ON usuarios (email);

CREATE INDEX idx_email_prov ON proveedores (email);

CREATE INDEX idx_email_cli ON clientes (email);

CREATE INDEX idx_nit_cli ON clientes (nit);

CREATE INDEX idx_producto_codigo ON productos (codigo);

-- Vistas para reportes
-- Clientes activos
CREATE VIEW
    vista_clientes_activos AS
SELECT
    c.id AS cliente_id,
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    c.email,
    MAX(f.fecha_factura) AS ultima_compra
FROM
    clientes c
    JOIN factura f ON c.id = f.cliente_id
WHERE
    c.active = 1
GROUP BY
    c.id;

-- Historial de compras por proveedor
CREATE VIEW
    vista_historial_compras_proveedor AS
SELECT
    pr.nombre AS nombre_proveedor,
    fp.id AS factura_proveedor_id,
    fp.fecha_factura,
    SUM(fpd.precio_compra * fpd.cantidad) AS total_compra
FROM
    proveedores pr
    JOIN facturas_proveedor fp ON pr.id = fp.proveedor_id
    JOIN facturas_proveedor_d fpd ON fp.id = fpd.factura_proveedor_id
GROUP BY
    pr.nombre,
    fp.id;

-- Ver pedidos pendientes
CREATE VIEW
    vista_pedidos_pendientes AS
SELECT
    pe.id AS pedido_id,
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    pe.fecha_pedido,
    ep.estado
FROM
    pedido pe
    JOIN clientes c ON pe.cliente_id = c.id
    JOIN estado_pedido ep ON pe.estado_pedido_id = ep.id
WHERE
    ep.estado = 'Pendiente';

