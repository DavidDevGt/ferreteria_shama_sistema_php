-- Datos para configurar el sistema
-- Insertar usuarios de prueba
INSERT INTO
    usuarios (username, password, email)
VALUES
    ('admin', 'password', 'admin@example.com'),
    ('vendedor', 'password', 'vendedor@example.com');

-- Insertar tipos de cliente
INSERT INTO
    tipo_cliente (tipo, descripcion)
VALUES
    ('Empresa', 'Cliente empresarial'),
    ('Minorista', 'Cliente individual'),
    ('Mayorista', 'Cliente mayorista');

-- Insertar categorías
INSERT INTO
    categorias (nombre, descripcion)
VALUES
    ('Herramientas', 'Herramientas manuales y eléctricas'),
    ('Ferretería', 'Artículos de ferretería'),
    ('Plomería', 'Artículos de plomería'),
    ('Electricidad', 'Artículos de electricidad'),
    ('Jardinería', 'Artículos de jardinería'),
    ('Pisos', 'Pisos y azulejos'),
    ('Madera', 'Madera y productos de madera'),
    ('Iluminación', 'Iluminación y lámparas'),
    ('Cerrajería', 'Artículos de cerrajería'),
    ('Seguridad', 'Artículos de seguridad'),
    ('Pinturas', 'Pinturas y accesorios para pintar');

-- Insertar marcas
INSERT INTO
    marcas (nombre, descripcion)
VALUES
    ('Bosch', 'Herramientas eléctricas de alta calidad'),
    ('Truper', 'Herramientas manuales y accesorios'),
    ('Sherwin-Williams', 'Pinturas y recubrimientos');

-- Insertar permisos
INSERT INTO
    permisos (nombre, descripcion)
VALUES
    (
        'gestionar_clientes',
        'Permiso para gestionar clientes'
    ),
    (
        'gestionar_productos',
        'Permiso para gestionar productos'
    ),
    (
        'gestionar_pedidos',
        'Permiso para gestionar pedidos'
    ),
    (
        'gestionar_facturas',
        'Permiso para gestionar facturas'
    ),
    (
        'gestionar_proveedores',
        'Permiso para gestionar proveedores'
    ),
    (
        'gestionar_empleados',
        'Permiso para gestionar empleados'
    ),
    (
        'gestionar_inventario',
        'Permiso para gestionar inventario'
    ),
    ('realizar_ventas', 'Permiso para realizar ventas'),
    ('ver_reportes', 'Permiso para ver reportes'),
    (
        'configurar_sistema',
        'Permiso para configurar el sistema'
    );

-- Insertar roles y asignar permisos
-- Administrador (acceso total)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    ('Administrador', 'Administrador del sistema');

INSERT INTO
    roles_permisos (rol_id, permiso_id)
SELECT
    1,
    id
FROM
    permisos;

-- Gerencia (acceso a reportes y configuración del sistema)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    ('Gerencia', 'Gerencia de la empresa');

INSERT INTO
    roles_permisos (rol_id, permiso_id)
VALUES
    (
        2,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'ver_reportes'
        )
    ),
    (
        2,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'configurar_sistema'
        )
    );

-- Contador (gestión de facturas y reportes)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    ('Contador', 'Contador de la empresa');

INSERT INTO
    roles_permisos (rol_id, permiso_id)
VALUES
    (
        3,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'gestionar_facturas'
        )
    ),
    (
        3,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'ver_reportes'
        )
    );

-- Bodeguero (gestión de inventario)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    ('Bodeguero', 'Empleado encargado de bodega');

INSERT INTO
    roles_permisos (rol_id, permiso_id)
VALUES
    (
        4,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'gestionar_inventario'
        )
    );

-- Mostrador (ventas y gestión de clientes)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    (
        'Mostrador',
        'Empleado encargado de ventas en mostrador'
    );

INSERT INTO
    roles_permisos (rol_id, permiso_id)
VALUES
    (
        5,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'realizar_ventas'
        )
    ),
    (
        5,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'gestionar_clientes'
        )
    );

-- Cajero (gestión de facturas y ventas)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    (
        'Cajero',
        'Empleado encargado de caja y facturación'
    );

INSERT INTO
    roles_permisos (rol_id, permiso_id)
VALUES
    (
        6,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'gestionar_facturas'
        )
    ),
    (
        6,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'realizar_ventas'
        )
    );

-- Vendedor (ventas y gestión de clientes)
INSERT INTO
    roles (nombre, descripcion)
VALUES
    ('Vendedor', 'Empleado encargado de ventas');

INSERT INTO
    roles_permisos (rol_id, permiso_id)
VALUES
    (
        7,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'realizar_ventas'
        )
    ),
    (
        7,
        (
            SELECT
                id
            FROM
                permisos
            WHERE
                nombre = 'gestionar_clientes'
        )
    );


INSERT INTO departamentos (nombre)
VALUES 
('Alta Verapaz'), 
('Baja Verapaz'), 
('Chimaltenango'), 
('Chiquimula'), 
('El Progreso'), 
('Escuintla'), 
('Guatemala'), 
('Huehuetenango'), 
('Izabal'), 
('Jalapa'), 
('Jutiapa'), 
('Peten'), 
('Quetzaltenango'), 
('Quiche'), 
('Retalhuleu'), 
('Sacatepequez'), 
('San Marcos'), 
('Santa Rosa'), 
('Solola'), 
('Suchitepequez'), 
('Totonicapan'), 
('Zacapa');


INSERT INTO municipios (departamento_id, nombre)
VALUES 
(1, 'Cobán'), 
(2, 'Salamá'), 
(3, 'Chimaltenango'), 
(4, 'Chiquimula'), 
(5, 'Guastatoya'), 
(6, 'Escuintla'), 
(7, 'Guatemala'), 
(8, 'Huehuetenango'), 
(9, 'Puerto Barrios'), 
(10, 'Jalapa'), 
(11, 'Jutiapa'), 
(12, 'Flores'), 
(13, 'Quetzaltenango'), 
(14, 'Santa Cruz del Quiche'), 
(15, 'Retalhuleu'), 
(16, 'Antigua Guatemala'), 
(17, 'San Marcos'), 
(18, 'Cuilapa'), 
(19, 'Sololá'), 
(20, 'Mazatenango'), 
(21, 'Totonicapán'), 
(22, 'Zacapa');

INSERT INTO aldeas (municipio_id, nombre)
VALUES 
-- Alta Verapaz (Cobán)
(1, 'San Pedro Carchá'), 
(1, 'Santa Cruz Verapaz'), 

-- Baja Verapaz (Salamá)
(2, 'San Jerónimo'), 
(2, 'Rabinal'), 

-- Chimaltenango
(3, 'Tecpán Guatemala'), 
(3, 'Patzún'), 

-- Chiquimula
(4, 'Esquipulas'), 
(4, 'Camotán'), 

-- El Progreso
(5, 'Sanarate'), 
(5, 'San Agustín Acasaguastlán'), 

-- Escuintla
(6, 'Palín'), 
(6, 'San Vicente Pacaya'), 

-- Guatemala
(7, 'Villa Nueva'), 
(7, 'Mixco'), 

-- Huehuetenango
(8, 'Malacatancito'), 
(8, 'Santa Bárbara'), 

-- Izabal
(9, 'Morales'), 
(9, 'Livingston'), 

-- Jalapa
(10, 'San Pedro Pinula'), 
(10, 'San Luis Jilotepeque'), 

-- Jutiapa
(11, 'Asunción Mita'), 
(11, 'El Progreso'), 

-- Peten
(12, 'San Benito'), 
(12, 'Sayaxché'), 

-- Quetzaltenango
(13, 'Salcajá'), 
(13, 'Almolonga'), 

-- Quiche
(14, 'Santa María Nebaj'), 
(14, 'San Andrés Sajcabajá'), 

-- Retalhuleu
(15, 'San Sebastián'), 
(15, 'Santa Cruz Muluá'), 

-- Sacatepequez
(16, 'Jocotenango'), 
(16, 'Sumpango'), 

-- San Marcos
(17, 'San Pedro Sacatepéquez'), 
(17, 'San Cristóbal Cucho'), 

-- Santa Rosa
(18, 'Cuilapa'), 
(18, 'Barberena'), 

-- Solola
(19, 'Panajachel'), 
(19, 'San Lucas Tolimán'), 

-- Suchitepequez
(20, 'Mazatenango'), 
(20, 'Cuyotenango'), 

-- Totonicapan
(21, 'Momostenango'), 
(21, 'San Cristóbal Totonicapán'), 

-- Zacapa
(22, 'Estanzuela'), 
(22, 'Gualán');


INSERT INTO clientes (nit, nombre, apellido, direccion_facturacion, direccion_entrega, aldea_id, municipio_id, departamento_id, pais, telefono, email, tipo_cliente_id)
VALUES 
('234567891', 'Ana', 'López', 'Dirección Facturación 2', 'Dirección Entrega 2', 2, 2, 2, 'Guatemala', '23456789', 'ana.lopez@example.com', 2),
('345678912', 'Carlos', 'González', 'Dirección Facturación 3', 'Dirección Entrega 3', 3, 3, 3, 'Guatemala', '34567890', 'carlos.gonzalez@example.com', 3),
('456789123', 'Luisa', 'Martínez', 'Dirección Facturación 4', 'Dirección Entrega 4', 1, 1, 4, 'Guatemala', '45678901', 'luisa.martinez@example.com', 1),
('567891234', 'Pedro', 'Hernández', 'Dirección Facturación 5', 'Dirección Entrega 5', 2, 2, 5, 'Guatemala', '56789012', 'pedro.hernandez@example.com', 2);
