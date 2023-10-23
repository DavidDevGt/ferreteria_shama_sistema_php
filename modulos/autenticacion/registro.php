    <div class="container-fluid">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-lg-8 d-flex mt-5">

                <!-- Contenedor principal del Registro -->
                <div class="d-flex w-100 bg-white p-5 rounded shadow-lg justify-content-between">

                    <!-- Logotipo y texto a la izquierda -->
                    <div class="d-flex flex-column justify-content-center align-items-center w-50">
                        <img src="assets\img\fshama.svg" class="img-fluid" style="max-width: 300px;" alt="ferreteria shama">
                        <h2 class="text-center mt-3">Ferretería Shama</h2>
                    </div>

                    <!-- Formulario de registro a la derecha -->
                    <div class="w-50">
                        <h3 class="mb-4">Registrarme</h3>
                        <form id="formRegistro" action="ajax.php" method="POST">
                            <div class="mb-3">
                                <label for="registerUsername" class="form-label">Nombre de Usuario</label>
                                <input type="text" class="form-control" id="registerUsername" name="registerUsername" placeholder="Ingresa tu nombre de usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="registerEmail" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="registerEmail" name="registerEmail" placeholder="Ingresa tu correo" required>
                            </div>
                            <div class="mb-3">
                                <label for="registerPassword" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="registerPassword" name="registerPassword" placeholder="Crea una contraseña" required>
                            </div>
                            <button type="submit" class="btn btn-warning btn-block">Registrar</button>
                        </form>
                        <div class="mt-3">
                            <a href="index.php?view=login">¿Ya tienes cuenta? Iniciar sesión</a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script src="modulos\autenticacion\script.js"></script>