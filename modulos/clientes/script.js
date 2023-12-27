"use strict";

// Función para realizar una búsqueda de clientes al cargar la página
$(document).ready(function () {
  const termino = $("#busquedaCliente").val();
  buscarClientes(termino);
});

// Función para realizar una búsqueda de clientes
function buscarClientes(termino, pagina = 1) {
  $.ajax({
    url: "modulos/clientes/ajax.php",
    type: "POST",
    dataType: "json",
    data: {
      accion: "buscar",
      busqueda: termino,
      pagina: pagina,
    },
    success: function (respuesta) {
      if (respuesta && respuesta.datos) {
        mostrarResultados(respuesta.datos);
        crearPaginacion(
          "paginacionClientes",
          respuesta.total_paginas,
          respuesta.pagina_actual,
          function (paginaSeleccionada) {
            buscarClientes(termino, paginaSeleccionada);
          }
        );
      } else {
        console.error("Formato de respuesta inesperado:", respuesta);
      }
    },
    error: function (xhr, status, error) {
      console.error("Error en la petición AJAX:", error);
    },
  });
}

// Función para mostrar los resultados de la búsqueda
function mostrarResultados(clientes) {
  const tbody = $("#resultadoClientes");
  tbody.empty();

  if (!clientes || clientes.length === 0) {
    tbody.append('<tr><td colspan="8">No se encontraron clientes.</td></tr>');
    return;
  }

  clientes.forEach((cliente) => {
    tbody.append(`
          <tr data-id-cliente="${cliente.id}">
              <td>${cliente.nit}</td>
              <td>${cliente.nombre}</td>
              <td>${cliente.apellido}</td>
              <td>${cliente.direccion_facturacion}</td>
              <td>${cliente.direccion_entrega}</td>
              <td>${cliente.telefono}</td>
              <td>${cliente.email}</td>
              <td class="text-center">
                  <div class="btn-group">
                      <button class="btn btn-sm btn-success" id="editarCliente">
                          <i class="las la-edit"></i> Editar
                      </button>
                      <button class="btn btn-sm btn-danger" id="eliminarCliente">
                          <i class="las la-trash-alt"></i> Eliminar
                      </button>
                  </div>
              </td>
          </tr>
      `);
  });
}

// Evento de clic en el botón de búsqueda
$("#buscarClienteBtn").click(function () {
  const termino = $("#busquedaCliente").val();
  buscarClientes(termino);
});

// Evento de tecla presionada para buscar al escribir
$("#busquedaCliente").keyup(function (e) {
  const termino = $(this).val();
  buscarClientes(termino);
});
