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
        $resultados_por_pagina = 10;

        // Modifica tu consulta para incluir paginación
        $query = "SELECT * FROM clientes WHERE nombre LIKE '%$terminoBusqueda%' OR apellido LIKE '%$terminoBusqueda%'";
        $resultados_format = paginarResultados($query, $pagina, $resultados_por_pagina);

        echo json_encode($resultados_format);
        break;


    case 'agregar':
        parse_str($_POST['cliente'], $datosCliente);

        $nit = dbEscape($datosCliente['nit']);
        $nombre = dbEscape($datosCliente['nombre']);
        $apellido = dbEscape($datosCliente['apellido']);
        $direccion_facturacion = dbEscape($datosCliente['direccion_facturacion']);
        $direccion_entrega = dbEscape($datosCliente['direccion_entrega']);
        $telefono = dbEscape($datosCliente['telefono']);
        $email = dbEscape($datosCliente['email']);
        $tipo_cliente_id = dbEscape($datosCliente['tipo_cliente_id']);

        $query = "INSERT INTO clientes (nit, nombre, apellido, direccion_facturacion, direccion_entrega, telefono, email, tipo_cliente_id) VALUES ('$nit', '$nombre', '$apellido', '$direccion_facturacion', '$direccion_entrega', '$telefono', '$email', '$tipo_cliente_id')";
        $resultado = dbQuery($query);

        if ($resultado) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Error al agregar el cliente']);
        }
        break;

    case 'editar':
        parse_str($_POST['cliente'], $datosCliente);

        $id_cliente = dbEscape($datosCliente['id_cliente']);
        $nit = dbEscape($datosCliente['nit']);
        $nombre = dbEscape($datosCliente['nombre']);
        $apellido = dbEscape($datosCliente['apellido']);
        $direccion_facturacion = dbEscape($datosCliente['direccion_facturacion']);
        $direccion_entrega = dbEscape($datosCliente['direccion_entrega']);
        $telefono = dbEscape($datosCliente['telefono']);
        $email = dbEscape($datosCliente['email']);
        $tipo_cliente_id = dbEscape($datosCliente['tipo_cliente_id']);

        $query = "UPDATE clientes SET nit = '$nit', nombre = '$nombre', apellido = '$apellido', direccion_facturacion = '$direccion_facturacion', direccion_entrega = '$direccion_entrega', telefono = '$telefono', email = '$email', tipo_cliente_id = '$tipo_cliente_id' WHERE id_cliente = $id_cliente";
        $resultado = dbQuery($query);

        if ($resultado) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Error al editar el cliente']);
        }
        break;

    case 'eliminar':
        $id_cliente = dbEscape($_POST['id_cliente']);
        $resultado = dbSoftDelete('clientes', "id = $id_cliente");

        if ($resultado) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['error' => 'Error al eliminar el cliente']);
        }
        break;

    case 'obtener_por_id':
        $id_cliente = dbEscape($_POST['id_cliente']);

        $query = "SELECT * FROM clientes WHERE id = $id_cliente";
        $resultado = dbQuery($query);

        if ($cliente = dbFetchAssoc($resultado)) {
            echo json_encode($cliente);
        } else {
            echo json_encode(['error' => 'Cliente no encontrado']);
        }
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
