<!-- Paso 1: Encabezados -->
<div class="p-4 m-4 bg-white rounded">
    <h2>Información del Encabezado</h2>
    <form id="headerInfoForm">
        <div class="row">
            <div class="mb-3 col-3">
                <label for="emisorReceptorInput" class="form-label">Nombres</label>
                <input type="text" class="form-control" id="emisorReceptorInput" placeholder="Nombre del Emisor/Receptor">
            </div>
            <div class="mb-3 col-3">
                <label for="nitInput" class="form-label">NIT</label>
                <input type="text" class="form-control" id="nitInput" placeholder="Ingrese NIT">
            </div>
            <div class="mb-3 col-3">
                <label for="direccionEntregaInput" class="form-label">Dirección de Entrega</label>
                <input type="text" class="form-control" id="direccionEntregaInput" placeholder="Dirección de Entrega">
            </div>
            <div class="mb-3 col-3">
                <label for="direccionFacturacionInput" class="form-label">Dirección de Facturación</label>
                <input type="text" class="form-control" id="direccionFacturacionInput" placeholder="Dirección de Facturación">
            </div>
        </div>
        <div class="row">
            <div class="mb-3 col-3">
                <label for="fechaInput" class="form-label">Fecha</label>
                <input type="date" class="form-control" id="fechaInput" placeholder="Fecha">
            </div>
            <div class="mb-3 col-3">
                <label for="numeroFacturaInput" class="form-label">Número de Factura</label>
                <input type="text" class="form-control" id="numeroFacturaInput" placeholder="Número de Factura">
            </div>
            <div class="mb-3 col-3"></div>
            <div class="mb-3 col-3"></div>

        </div>
        <!-- Otros campos según sea necesario -->
        <button type="button" class="btn btn-primary" onclick="goToInvoiceDetails()">Siguiente</button>
    </form>
</div>

<!-- Paso 2: Detalles de la Factura -->
<div class="p-4 m-4 bg-white rounded">
    <h2>Detalles de la Factura</h2>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Producto/Servicio</th>
                <th scope="col">Cantidad</th>
                <th scope="col">Precio</th>
                <th scope="col">Subtotal</th>
                <th scope="col">Acciones</th>
            </tr>
        </thead>
        <tbody id="invoiceDetails">
            <!-- Las filas se agregarán dinámicamente aquí -->
        </tbody>
    </table>
    <button type="button" class="btn btn-primary" onclick="addItem()">Agregar Item</button>
    <button type="button" class="btn btn-success" onclick="goToElectronicSignature()">Siguiente</button>
</div>

<!-- Paso 3: Firma Electrónica -->
<div class="p-4 m-4 bg-white rounded">
    <h2>Firma Electrónica</h2>
    <button type="button" class="btn btn-danger" onclick="firmarInvoice()">Firmar FEL</button>
</div>