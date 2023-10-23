<div class="container-fluid h-100">
    <div class="row justify-content-center align-items-center h-100">
        <div class="col-lg-8 d-flex mt-5">

            <!-- Logo a la izquierda -->
            <div class="d-flex w-100 bg-white p-5 rounded shadow-lg justify-content-between">
                <!-- Logotipo y texto a la izquierda -->
                <div class="d-flex justify-content-center align-items-center">
                    <img src="assets\img\fshama.svg" alt="ferreteria shama" style="max-width: 300px;">
                </div>

                <!-- Formulario de inicio de sesión a la derecha -->
                <div style="width: 50%;">
                    <h3 class="mb-4">Inicio de Sesión</h3>
                    <form action="ajax.php" method="POST">
                        <div class="mb-3">
                            <label for="username" class="form-label">Usuario</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="las la-user"></i></span>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Ingresa tu usuario" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="las la-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Ingresa tu contraseña" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning btn-block">Ingresar</button>
                    </form>
                    <div class="mt-3">
                        <a href="#">¿Olvidaste tu contraseña?</a><br>
                        <a href="index.php?modulo=registro">¿No tienes cuenta? Regístrate aquí.</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="modulos\autenticacion\script.js"></script>