-- Modificación de tabla usuarios: Cambiando el tipo de dato de DATE a DATETIME
ALTER TABLE usuarios
    MODIFY fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY ultimo_login DATETIME;

-- Modificación de tabla sesiones: Cambiando el tipo de dato de DATE a DATETIME
ALTER TABLE sesiones
    MODIFY fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY fecha_expiracion DATETIME NOT NULL;

-- Modificación de tabla intentos_login: Cambiando el tipo de dato de DATE a DATETIME
ALTER TABLE intentos_login
    MODIFY fecha_intentos DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Modificación de tabla proveedores: Cambiando el tipo de dato de DATE a DATETIME
ALTER TABLE proveedores
    MODIFY fecha_registro DATETIME;

-- Modificación de tabla productos: Cambiando el tipo de dato de DATE a DATETIME
ALTER TABLE productos
    MODIFY fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFY fecha_modificacion DATETIME;

-- Modificación de tabla clientes: Cambiando el tipo de dato de DATE a DATETIME
ALTER TABLE clientes
    MODIFY fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Índices para mejorar la velocidad de las consultas
CREATE INDEX idx_username ON usuarios(username);
CREATE INDEX idx_email ON usuarios(email);
CREATE INDEX idx_email_prov ON proveedores(email);
CREATE INDEX idx_email_cli ON clientes(email);
CREATE INDEX idx_nit_cli ON clientes(nit);
CREATE INDEX idx_producto_codigo ON productos(codigo);
