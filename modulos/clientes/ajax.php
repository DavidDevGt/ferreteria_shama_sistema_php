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
        $pagina = $_POST['pagina'] ?? 1;
        $resultados_por_pagina = 3;    
    
        // Modifica tu consulta para incluir paginación
        $query = "SELECT * FROM clientes WHERE nombre LIKE '%$terminoBusqueda%' OR apellido LIKE '%$terminoBusqueda%'";
        $resultados_format = paginarResultados($query, $pagina, $resultados_por_pagina);
    
        echo json_encode($resultados_format);
        break;
    

    case 'agregar':
        break;

    case 'editar':
        break;

    case 'eliminar':
        break;
    
    case 'obtener_por_id':
        break;

    case 'obtener_todos':
        $pagina = $_POST['pagina'] ?? 1;
        $resultados_por_pagina = 10;

        $query = "SELECT * FROM clientes WHERE active = 1";
        $resultados_format = paginarResultados($query, $pagina, $resultados_por_pagina);

        echo json_encode($resultados_format);
        break;

    default:
        echo json_encode(['error' => 'Acción no reconocida']);
        break;
}
