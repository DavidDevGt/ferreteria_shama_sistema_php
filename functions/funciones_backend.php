<?php

/**
 * Formatea un número al formato de moneda Quetzal (GTQ).
 *
 * @param float $numero El número a formatear.
 * @return string El número formateado con el símbolo de Quetzal y dos decimales.
 */
function formatoQuetzal($numero) {
    return 'Q' . number_format($numero, 2, '.', ',');
}

/**
 * Función para generar un string aleatorio
 *
 * @param int $longitud La longitud del string, le puse 10 por defecto.
 * @return string El string generado.
 */
function generarStringRandom($longitud = 10) {
    $caracteres = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $string = '';
    for ($i = 0; $i < $longitud; $i++) {
        $string .= $caracteres[rand(0, strlen($caracteres) - 1)];
    }
    return $string;
}

/**
 * Función para verificar si un correo es válido.
 *
 * @param string $email El correo a verificar.
 * @return bool True si es válido, False en caso contrario.
 */
function validarCorreo($correo) {
    return filter_var($correo, FILTER_VALIDATE_EMAIL);
}

/**
 * Función para encriptar una contraseña.
 *
 * @param string $contrasena La contraseña a encriptar.
 * @return string La contraseña encriptada.
 */
function encriptarContrasena($contrasena) {
    return password_hash($contrasena, PASSWORD_DEFAULT);
}

/**
 * Función para verificar una contraseña con su versión encriptada.
 *
 * @param string $contrasena La contraseña a verificar.
 * @param string $hash El hash con el que comparar.
 * @return bool True si coinciden, False en caso contrario.
 */
function verificarContrasena($contrasena, $hash) {
    return password_verify($contrasena, $hash);
}

/**
 * Función para obtener la dirección IP del cliente.
 *
 * @return string La dirección IP.
 */
function obtenerIP() {
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        return $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        return $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        return $_SERVER['REMOTE_ADDR'];
    }
}

/**
 * Función para generar un token CSRF.
 *
 * @return string El token CSRF.
 */
function generarTokenCSRF() {
    if (!session_id()) {
        session_start();
    }
    $token = bin2hex(random_bytes(32));
    $_SESSION['csrf_token'] = $token;
    return $token;
}

/**
 * Función para verificar un token CSRF.
 *
 * @param string $token El token a verificar.
 * @return bool True si es válido, False en caso contrario.
 */
function verificarTokenCSRF($token) {
    if (!session_id()) {
        session_start();
    }
    return isset($_SESSION['csrf_token']) && $token === $_SESSION['csrf_token'];
}

/**
 * Función para convertir una fecha al formato español.
 * 
 * @param string $fecha Fecha en formato "Y-m-d" o "Y-m-d H:i:s".
 * @return string Fecha en formato "d-m-Y" o "d-m-Y H:i:s".
 */
function convertirFechaEspanol($fecha) {
    $date = new DateTime($fecha);
    return $date->format('d-m-Y H:i:s');
}

/**
 * Función para obtener la diferencia de días entre dos fechas.
 *
 * @param string $fechaInicio Fecha inicial.
 * @param string $fechaFin Fecha final.
 * @return int Diferencia en días.
 */
function obtenerDiferenciaDias($fechaInicio, $fechaFin) {
    $inicio = new DateTime($fechaInicio);
    $fin = new DateTime($fechaFin);
    $diferencia = $inicio->diff($fin);
    return $diferencia->days;
}

/**
 * Función para redireccionar a otra página.
 *
 * @param string $url La URL a la que se quiere redirigir.
 */
function redireccionar($url) {
    header("Location: $url");
    exit;
}

/**
 * Función para limpiar un string (evitar inyecciones SQL y XSS).
 *
 * @param string $dato El dato a limpiar.
 * @return string El dato limpio.
 */
function limpiarDato($dato) {
    $dato = stripslashes($dato);
    $dato = htmlspecialchars($dato);
    return $dato;
}

/**
 * Función para generar un código de producto único con el formato ABCD-123.
 *
 * @param int $longitud La longitud del código, por defecto es 7.
 * @return string El código generado.
 */
function generarCodigoProducto($longitud = 7) {
    $codigo = '';
    $caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $numCaracteres = strlen($caracteres);

    // Verificar si la longitud solicitada es válida
    if ($longitud <= 0 || $longitud > $numCaracteres) {
        throw new Exception("Longitud inválida");
    }

    // Generar los primeros 4 caracteres del código
    $caracteresAleatorios = array_rand(str_split($caracteres), 4);
    foreach ($caracteresAleatorios as $indice) {
        $codigo .= $caracteres[$indice];
    }

    // Generar los últimos 3 dígitos del código
    $codigo .= '-' . rand(100, 999);

    return $codigo;
}