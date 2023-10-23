<?php
session_start();

$rutasPermitidas = [
    'categorias' => 'modulos/categorias/index.php',
    'clientes' => 'modulos/clientes/index.php',
    'empleados' => 'modulos/empleados/index.php',
    'facturas' => 'modulos/facturas/index.php',
    'ordenes_compra' => 'modulos/ordenes_compra/index.php',
    'pedidos' => 'modulos/pedidos/index.php',
    'productos' => 'modulos/productos/index.php',
    'proveedores' => 'modulos/proveedores/index.php',
    'reportes' => 'modulos/reportes/index.php',
    'login' => 'modulos/autenticacion/login.php',
    'registro' => 'modulos/autenticacion/registro.php',
    'ola' => 'modulos/autenticacion/ajax.php',
    //... otras rutas
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