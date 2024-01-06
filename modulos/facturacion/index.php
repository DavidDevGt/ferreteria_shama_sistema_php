<!-- Paso 1: Encabezados -->
<div class="p-4 m-4 bg-white rounded">
    <h2>Información del Encabezado</h2>
    <form id="headerInfoForm" class="row">
        <div class="mb-3 col-3">
            <label for="nitInput" class="form-label">NIT</label>
            <input type="text" class="form-control" id="nitInput" placeholder="Ingrese NIT">
        </div>
        <div class="mb-3 col-3">
            <label for="nameInput" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nameInput" placeholder="Nombre del Emisor/Receptor">
        </div>
        <div class="mb-3 col-3">
            <label for="nameInput" class="form-label">Dirección Facturación</label>
            <input type="text" class="form-control" id="nameInput" placeholder="Nombre del Emisor/Receptor">
        </div>
        <div class="mb-3 col-3">
            <label for="nameInput" class="form-label">Dirección Entrega</label>
            <input type="text" class="form-control" id="nameInput" placeholder="Nombre del Emisor/Receptor">
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
    <button type="button" class="btn btn-primary" onclick="addItem()">Agregar Ítem</button>
    <button type="button" class="btn btn-success" onclick="goToElectronicSignature()">Siguiente</button>
</div>

<!-- Paso 3: Firma Electrónica -->
<div class="p-4 m-4 bg-white rounded">
    <h2>Firma Electrónica</h2>
    <p>Resumen de la factura:</p>
    <div id="invoiceSummary">
        <!-- Resumen de la factura se generará aquí -->
    </div>
    <div class="mb-3">
        <label for="signaturePad" class="form-label">Firma Aquí</label>
        <canvas id="signaturePad" class="border"></canvas>
    </div>
    <button type="button" class="btn btn-danger" onclick="finalizeInvoice()">Finalizar</button>
</div>