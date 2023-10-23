<?php
session_start();

define('RUTA_CATEGORIAS', 'modulos/categorias/index.php');
define('RUTA_CLIENTES', 'modulos/clientes/index.php');
define('RUTA_EMPLEADOS', 'modulos/empleados/index.php');
define('RUTA_FACTURAS', 'modulos/facturas/index.php');
define('RUTA_ORDENES_COMPRA', 'modulos/ordenes_compra/index.php');
define('RUTA_PEDIDOS', 'modulos/pedidos/index.php');
define('RUTA_PRODUCTOS', 'modulos/productos/index.php');
define('RUTA_PROVEEDORES', 'modulos/proveedores/index.php');
define('RUTA_REPORTES', 'modulos/reportes/index.php');
define('RUTA_LOGIN', 'modulos/autenticacion/login.php');
define('RUTA_REGISTRO', 'modulos/autenticacion/registro.php');

$rutasPermitidas = [
    'categorias' => RUTA_CATEGORIAS,
    'clientes' => RUTA_CLIENTES,
    'empleados' => RUTA_EMPLEADOS,
    'facturas' => RUTA_FACTURAS,
    'ordenes_compra' => RUTA_ORDENES_COMPRA,
    'pedidos' => RUTA_PEDIDOS,
    'productos' => RUTA_PRODUCTOS,
    'proveedores' => RUTA_PROVEEDORES,
    'reportes' => RUTA_REPORTES,
    'login' => RUTA_LOGIN,
    'registro' => RUTA_REGISTRO,
];

// Obtener el módulo
$modulo = $_GET['modulo'] ?? null;

// Verificación de autenticación
if (!isset($_SESSION['usuario']) && !in_array($modulo, ['login', 'registro', 'ola'])) {
    header('Location: index.php?modulo=login');
    exit;
}

// Enrutamiento
if ($modulo && isset($rutasPermitidas[$modulo])) {
    include $rutasPermitidas[$modulo];
} else {
    include 'modulos/404.php';
}
