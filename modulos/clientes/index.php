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
</div>

<script src="modulos\clientes\script.js"></script>

<style>
    #tabla_clientes {
        font-size: 12px;
    }
</style>