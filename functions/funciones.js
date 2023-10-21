/**
 * Formatea un número al formato de moneda Quetzal (GTQ).
 * 
 * @param {number} numero El número a formatear.
 * @return {string} El número formateado con el símbolo de Quetzal y dos decimales.
 */
function formatoQuetzal(numero) {
    return 'Q' + numero.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
}

/**
 * Función para ocultar o mostrar un elemento por su ID.
 * 
 * @param {string} id El ID del elemento.
 */
function toggleElemento(id) {
    let elemento = document.getElementById(id);
    if (elemento.style.display === 'none') {
        elemento.style.display = 'block';
    } else {
        elemento.style.display = 'none';
    }
}

/**
 * Función para cambiar el contenido de un elemento por su ID.
 * 
 * @param {string} id El ID del elemento.
 * @param {string} contenido El nuevo contenido del elemento.
 */
function cambiarContenido(id, contenido) {
    document.getElementById(id).innerHTML = contenido;
}

/**
 * Función para agregar una clase CSS a un elemento por su ID.
 * 
 * @param {string} id El ID del elemento.
 * @param {string} clase La clase CSS que se desea agregar.
 */
function agregarClase(id, clase) {
    document.getElementById(id).classList.add(clase);
}

/**
 * Función para eliminar una clase CSS de un elemento por su ID.
 * 
 * @param {string} id El ID del elemento.
 * @param {string} clase La clase CSS que se desea eliminar.
 */
function quitarClase(id, clase) {
    document.getElementById(id).classList.remove(clase);
}

/**
 * Función para verificar si un elemento tiene una clase CSS específica.
 * 
 * @param {string} id El ID del elemento.
 * @param {string} clase La clase CSS que se desea verificar.
 * @return {boolean} True si el elemento tiene la clase, False en caso contrario.
 */
function tieneClase(id, clase) {
    return document.getElementById(id).classList.contains(clase);
}

/**
 * Función para desplazarse suavemente hacia un elemento en la página.
 * 
 * @param {string} id El ID del elemento al que se desea desplazar.
 */
function desplazarseSuavemente(id) {
    let elemento = document.getElementById(id);
    elemento.scrollIntoView({ behavior: 'smooth' });
}
