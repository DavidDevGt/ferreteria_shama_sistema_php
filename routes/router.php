<?php
require __DIR__ . '/../resources/altorouter/vendor/autoload.php';

$router = new AltoRouter();

$router->setBasePath('/fshama-erp');

// Rutas

$router->map('GET', '/', function () {
    require __DIR__ . '/../modulos/inicio.php';
});

$router->map('GET', '/categorias', function () {
    require __DIR__ . '/../modulos/categorias/index.php';
});

$router->map('GET', '/clientes', function () {
    require __DIR__ . '/../modulos/clientes/index.php';
});

$router->map('GET', '/empleados', function () {
    require __DIR__ . '/../modulos/empleados/index.php';
});

$router->map('GET', '/productos', function () {
    require __DIR__ . '/../modulos/productos/index.php';
});

$router->map('GET', '/login', function () {
    require __DIR__ . '/../modulos/autenticacion/login.php';
});

// Match de la ruta actual
$match = $router->match();

// Llamada al callback de la ruta
if ($match && is_callable($match['target'])) {
    call_user_func($match['target']);
} else {
    // No se encontró ruta
    http_response_code(404);
    require __DIR__ . '/../modulos/404.php';
}
