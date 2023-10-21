<?php include './includes/header.php'; ?>

<!-- Contenido -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h1 class="display-4 text-center">Sistema de Inventario FSHAMA</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <p class="lead text-center">Bienvenido al sistema de inventario de la Ferretería Shama.</p>
            <button id="btnTestSweetAlert" class="btn btn-primary">Probar SweetAlert2</button>
            <p class="lead text-center">Ola k ase</p>
        </div>
    </div>
</div>
<!-- Fin Contenido -->
<script>
    $(document).ready(function () {
        $('#btnTestSweetAlert').click(function () {
            if (typeof Swal === 'function') {
                Swal.fire('SweetAlert2', '¡SweetAlert2 está funcionando!', 'success');
            } else {
                alert('SweetAlert2 no está importado');
            }
        });
    });

    // Realizamos una petición GET a JSONPlaceholder
    axios.get('https://jsonplaceholder.typicode.com/posts/1')
        .then(function (response) {
            // La petición fue exitosa, mostramos los datos en la consola
            console.log('Datos obtenidos con Axios:', response.data);
        })
        .catch(function (error) {
            // Hubo un error en la petición
            console.error('Error al hacer la solicitud con Axios:', error);
        });

    // if (window.jQuery) {
    //     console.log("jQuery está cargado");
    // } else {
    //     console.log("jQuery no está cargado");
    // }


</script>

<?php include './includes/footer.php'; ?>