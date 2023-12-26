<?php
$request = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$rutas = [
    '/categorias' => 'modulos/categorias/index.php',
    '/clientes' => 'modulos/clientes/index.php',
    '/empleados' => 'modulos/empleados/index.php',
    // Agrega aquí todas las rutas que necesites
];

if (array_key_exists($request, $rutas)) {
    require __DIR__ . '/' . $rutas[$request];
} else {
    http_response_code(404);
    echo 'Not Found';
}