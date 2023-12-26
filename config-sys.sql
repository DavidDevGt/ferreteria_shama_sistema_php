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