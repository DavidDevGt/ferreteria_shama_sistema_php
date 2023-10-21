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