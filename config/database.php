<?php
// Parámetros de conexión a la base de datos
$host = 'localhost';
$db_name = 'fshama_sys';
$username = 'root';
$password = '';

// Establecer conexión con la base de datos usando mysqli
$conexion = new mysqli($host, $username, $password, $db_name);

// Verificar la conexión
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Funciones para interactuar con la base de datos más rápido

/**
 * Función para ejecutar consultas SQL
 * 
 * @param string $query Consulta SQL a ejecutar
 * @return mixed Resultado de la consulta
 */
function dbQuery($query)
{
    global $conexion;
    return mysqli_query($conexion, $query);
}

/**
 * Función para obtener una fila de resultados como un array asociativo
 * 
 * @param mysqli_result $result Resultado de una consulta SQL
 * @return array Fila de resultados
 */
function dbFetchAssoc($result)
{
    return mysqli_fetch_assoc($result);
}

/**
 * Función para obtener el número de filas en un conjunto de resultados
 * 
 * @param mysqli_result $result Resultado de una consulta SQL
 * @return int Número de filas
 */
function dbNumRows($result)
{
    return mysqli_num_rows($result);
}

/**
 * Función para escapar cadenas y prevenir inyecciones SQL
 * 
 * @param string $str Cadena a escapar
 * @return string Cadena escapada
 */
function dbEscape($str)
{
    global $conexion;
    return mysqli_real_escape_string($conexion, $str);
}

/**
 * Función para obtener el ID autogenerado usado en la última consulta INSERT
 * 
 * @return int ID autogenerado
 */
function dbInsertId()
{
    global $conexion;
    return mysqli_insert_id($conexion);
}

/**
 * Función para cerrar la conexión a la base de datos
 */
function dbClose()
{
    global $conexion;
    mysqli_close($conexion);
}

/**
 * Función para obtener todas las filas de resultados en un array
 * 
 * @param mysqli_result $result Resultado de una consulta SQL
 * @return array Todas las filas de resultados
 */
function dbFetchAll($result)
{
    return mysqli_fetch_all($result, MYSQLI_ASSOC);
}

/**
 * Función para obtener una fila basada en una consulta directa
 * 
 * @param string $query Consulta SQL
 * @return array Fila de resultados
 */
function dbFetchRow($query)
{
    global $conexion;
    $result = mysqli_query($conexion, $query);
    return mysqli_fetch_assoc($result);
}

/**
 * Función para obtener un único valor de una consulta
 * 
 * @param string $query Consulta SQL
 * @return mixed Valor único
 */
function dbFetchValue($query)
{
    global $conexion;
    $result = mysqli_query($conexion, $query);
    $row = mysqli_fetch_array($result);
    return $row[0];
}

/**
 * Función para actualizar registros en la base de datos
 * 
 * @param string $table Nombre de la tabla
 * @param array $data Datos para actualizar (en formato asociativo: columna => valor)
 * @param string $condition Condición para determinar qué registros actualizar
 * @return bool Resultado de la operación (true si fue exitosa, false si hubo un error)
 */
function dbUpdate($table, $data, $condition)
{
    global $conexion;
    $setQuery = [];
    foreach ($data as $column => $value) {
        $setQuery[] = "`$column` = '" . dbEscape($value) . "'";
    }
    $query = "UPDATE `$table` SET " . implode(', ', $setQuery) . " WHERE $condition";
    return mysqli_query($conexion, $query);
}

/**
 * Realiza una consulta SQL segura usando sentencias preparadas.
 *
 * @param string $query La consulta SQL con placeholders.
 * @param array $params Los parámetros para reemplazar en la consulta.
 * @return mysqli_stmt|false El objeto de la declaración o false en caso de error.
 */
function dbQueryPreparada($query, $params = []) {
    global $conexion;

    $stmt = $conexion->prepare($query);
    if ($stmt === false) {
        return false;
    }

    if ($params) {
        $tipos = '';
        foreach ($params as $param) {
            if (is_int($param)) {
                $tipos .= 'i';
            } elseif (is_float($param)) {
                $tipos .= 'd';
            } elseif (is_string($param)) {
                $tipos .= 's';
            } else {
                $tipos .= 'b';
            }
        }

        $stmt->bind_param($tipos, ...$params);
    }

    $stmt->execute();
    return $stmt;
}