<?php
//* VER ERRORES
// error_reporting(E_ALL);
// ini_set('display_errors', 1);
// ini_set('log_errors', 1);
// ini_set('error_log', 'errors.log');

// Archivos de configuración    
require '../../config/database.php';
require '../../functions/funciones_backend.php';

$accion = $_POST['accion'] ?? $_GET['accion'] ?? '';

switch ($accion) {
    case 'buscar':
        $terminoBusqueda = dbEscape($_POST['busqueda'] ?? '');

        // Aquí ejecutas la consulta para buscar clientes
        $query = "SELECT * FROM clientes WHERE nombre LIKE '%$terminoBusqueda%' OR apellido LIKE '%$terminoBusqueda%'";
        $resultados = dbQuery($query);
        $clientes = dbFetchAll($resultados);

        echo json_encode($clientes);
        break;

    case 'agregar':
        break;

    case 'editar':
        break;

    case 'eliminar':
        break;

    case 'obtener_todos':
        $query = "SELECT * FROM clientes WHERE active = 1";
        $resultados = dbQuery($query);
        $todos_los_clientes = dbFetchAll($resultados);

        echo json_encode($todos_los_clientes);
        break;

    default:
        echo json_encode(['error' => 'Acción no reconocida']);
        break;
}
