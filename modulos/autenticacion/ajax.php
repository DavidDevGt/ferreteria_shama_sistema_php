<?php
require 'config\database.php';
require 'functions\funciones_backend.php';

// Funciones y código para el registro de usuario

function registrarUsuario($username, $password, $email, $rol_id) {
    global $conexion; // Usar la conexión desde el archivo de conexión

    // Hashear la contraseña para mayor seguridad
    $passwordHash = encriptarContrasena($password);

    // Utilizando la función dbQueryPreparada para hacer la inserción
    $query = "INSERT INTO usuarios (username, password, email, rol_id) VALUES (?, ?, ?, ?)";
    $params = [$username, $passwordHash, $email, $rol_id];
    $stmt = dbQueryPreparada($query, $params);

    // Verificar si la inserción fue exitosa
    if ($stmt && $stmt->affected_rows > 0) {
        return true;
    } else {
        return false;
    }
}

// Verificar si hay una acción definida en la solicitud POST
if (isset($_POST['action'])) {
    switch ($_POST['action']) {
        case 'register':
            // Extraer los datos enviados desde el formulario de registro
            $username = obtenerPost('username');
            $password = obtenerPost('password');
            $email = obtenerPost('email');
            $rol_id = obtenerPost('rol_id'); // Puedes definir un rol predeterminado si no lo envías desde el formulario

            // Validaciones adicionales antes de intentar registrar
            if (!validarCorreo($email)) {
                echo json_encode(['status' => 'error', 'message' => 'Correo electrónico no válido.']);
                exit;
            }

            // Intentar registrar al usuario
            $result = registrarUsuario($username, $password, $email, $rol_id);

            // Devolver una respuesta según el resultado
            if ($result) {
                echo json_encode(['status' => 'success', 'message' => 'Registro exitoso.']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Error al registrar.']);
            }
            break;

        // ... Puedes agregar más casos para otras acciones aquí ...

        default:
            echo json_encode(['status' => 'error', 'message' => 'Acción no reconocida.']);
            break;
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Acción no definida.']);
}
