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
        $terminoBusqueda = $_POST['busqueda'] ?? '';
        
        $resultadosBusqueda = "Resultado";

        echo json_encode($resultadosBusqueda);
        break;
    case 'agregar':
        break;
    case 'editar':
        break;
    case 'eliminar':
        break;
    case 'obtener':
        break;
    default:
        echo json_encode(['error' => 'Acción no reconocida']);
        break;
}
