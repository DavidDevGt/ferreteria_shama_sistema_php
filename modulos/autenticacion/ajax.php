<?php
require '../../config/database.php';
require '../../functions/funciones_backend.php';

// Funciones y código para el registro de usuario

function registrarUsuario($username, $password, $email, $rol_id)
{
    global $conexion;

    // Verificar si el correo o el nombre de usuario ya existen
    $query = "SELECT username, email FROM usuarios WHERE username = ? OR email = ?";
    $params = [$username, $email];
    $stmt = dbQueryPreparada($query, $params);

    if ($stmt !== false) {
        $stmt->execute();
        $stmt->store_result();
        $numRows = $stmt->num_rows;

        if ($numRows > 0) {
            return ['status' => 'error', 'message' => 'El correo o el nombre de usuario ya existen en la base de datos.'];
        }

        // Hashear la contraseña para mayor seguridad
        $passwordHash = encriptarContrasena($password);

        // Insertar el nuevo usuario
        $insertQuery = "INSERT INTO usuarios (username, password, email, rol_id) VALUES (?, ?, ?, ?)";
        $insertParams = [$username, $passwordHash, $email, $rol_id];
        $insertStmt = dbQueryPreparada($insertQuery, $insertParams);

        if ($insertStmt !== false) {
            $insertStmt->execute();

            if ($insertStmt->affected_rows > 0) {
                return ['status' => 'success', 'message' => 'Registro exitoso.'];
            } else {
                return ['status' => 'error', 'message' => 'Error al registrar.'];
            }
        } else {
            return ['status' => 'error', 'message' => 'Error en la base de datos al insertar el nuevo usuario.'];
        }
    } else {
        return ['status' => 'error', 'message' => 'Error en la base de datos al verificar la existencia del usuario.'];
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

            // Registrar al usuario
            $result = registrarUsuario($username, $password, $email, $rol_id);

            // Iniciar una sesión si el registro es exitoso
            if ($result) {
                session_start();
                $_SESSION['usuario'] = $username; // Guardar el nombre de usuario en la sesión, puedes agregar más datos si es necesario
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
