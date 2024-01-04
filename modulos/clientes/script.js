"use strict";

guardarClienteBtn = $("#guardarClienteBtn");

// Función para realizar una búsqueda de clientes al cargar la página para mostrar todos los clientes
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
                          <i class="las la-edit"></i>
                      </button>
                      <button class="btn btn-sm btn-danger" id="eliminarCliente">
                          <i class="las la-trash-alt"></i>
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

// Modal de edicio y creación de clientes

// Evento para abrir el modal en modo de agregar nuevo cliente
$("#agregarClienteBtn").click(function () {
  limpiarFormularioCliente();
  $("#modalClientes").modal("show");
});

// Evento para abrir el modal en modo de edición
$(document).on("click", "#editarCliente", function () {
  const idCliente = $(this).closest("tr").data("id-cliente");
  cargarDatosCliente(idCliente);
});

function cargarDatosCliente(idCliente) {
  $.ajax({
    url: "modulos/clientes/ajax.php",
    type: "POST",
    dataType: "json",
    data: {
      accion: "obtener_por_id",
      id_cliente: idCliente,
    },
    success: function (cliente) {
      $("#nit").val(cliente.nit);
      $("#nombre").val(cliente.nombre);
      $("#apellido").val(cliente.apellido);
      $("#direccionFacturacion").val(cliente.direccion_facturacion);
      $("#direccionEntrega").val(cliente.direccion_entrega);
      $("#telefono").val(cliente.telefono);
      $("#email").val(cliente.email);
      $("#tipoClienteId").val(cliente.tipo_cliente_id);

      $("#modalClientes").data("id-cliente", cliente.id);
    },
    error: function (error) {
      console.error("Error al cargar datos del cliente", error);
    },
  });
}

// Función para limpiar el formulario de clientes
function limpiarFormularioCliente() {
  $("#formCliente")[0].reset();
}

$("#guardarClienteBtn").click(function () {
  const idCliente = $("#modalClientes").data("id-cliente");
  const cliente = $("#formCliente").serialize();

  $.ajax({
    url: "modulos/clientes/ajax.php",
    type: "POST",
    dataType: "json",
    data: {
      accion: idCliente ? "editar" : "agregar",
      id_cliente: idCliente,
      cliente: cliente,
    },
    success: function (respuesta) {
      // Código para manejar la respuesta
      $("#modalClientes").modal("hide");
      buscarClientes(""); // Actualizar la lista de clientes
    },
    error: function (error) {
      console.error("Error al guardar el cliente", error);
    },
  });
});
