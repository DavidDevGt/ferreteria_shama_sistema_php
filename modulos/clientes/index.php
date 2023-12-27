

<!-- Modal -->
<div class="modal fade" id="modalClientes" tabindex="-1" aria-labelledby="modalClientesLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalClientesLabel">Agregar/Editar Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formCliente">
                    <div class="row">
                        <!-- Columna izquierda -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="nit" class="form-label">NIT</label>
                                <input type="text" class="form-control" id="nit" name="nit">
                            </div>
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre">
                            </div>
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido">
                            </div>
                            <div class="mb-3">
                                <label for="direccionFacturacion" class="form-label">Dirección de Facturación</label>
                                <input type="text" class="form-control" id="direccionFacturacion" name="direccion_facturacion">
                            </div>
                        </div>
                        <!-- Columna derecha -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="direccionEntrega" class="form-label">Dirección de Entrega</label>
                                <input type="text" class="form-control" id="direccionEntrega" name="direccion_entrega">
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                            <div class="mb-3">
                                <label for="tipoClienteId" class="form-label">Tipo de Cliente</label>
                                <select class="form-select" id="tipoClienteId" name="tipo_cliente_id">
                                    <!-- Opciones del tipo de cliente -->
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="guardarClienteBtn">Guardar Cliente</button>
            </div>
        </div>
    </div>
</div>

<div class="p-4 m-4 bg-white rounded">
    <h2>Lista de Clientes</h2>

    <div class="input-group mt-5">
        <input type="text" id="busquedaCliente" placeholder="Buscar Cliente..." class="form-control">
        <button class="btn btn-outline-secondary" type="button" id="buscarClienteBtn">
            <i class="las la-search"></i> Buscar Cliente
        </button>
    </div>

    <div class="table-responsive mt-3" id="tablaClientesActivos">
        <table class="table table-bordered table-hover" id="tabla_clientes">
            <thead class="table-dark">
                <tr>
                    <th>NIT</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Dirección de Facturación</th>
                    <th>Dirección de Entrega</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th class="text-center">Acciones</th>
                </tr>
            </thead>
            <tbody id="resultadoClientes">
                <!-- Aquí se mostrarían los datos de los clientes -->
            </tbody>
            <tfooter>
                <tr>
                    <td colspan="8" id="paginacionClientes">
                        <!-- Aquí se mostraría la paginación -->
                    </td>
                </tr>
            </tfooter>
        </table>
    </div>
    <!-- Botón para abrir el modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalClientes">
    Agregar Cliente
</button>
</div>

<script src="modulos\clientes\script.js"></script>

<style>
    #tabla_clientes {
        font-size: 12px;
    }
</style>