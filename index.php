<?php
// Inclusión del encabezado
include './includes/header.php';
?>

<style>
    body {
        background-color: #dadada;
    }
</style>

<body>

    <!-- Contenedor de la app -->
    <div class="container-fluid">
        <?php
        require './routes/router.php';
        ?>
    </div>

    <!-- Fin Contenido -->
    <script></script>

</body>

<?php
// Inclusión del pie de página
include './includes/footer.php';
?>