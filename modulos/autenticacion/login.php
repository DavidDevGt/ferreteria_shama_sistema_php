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
                    <form action="ruta_a_tu_script_de_login.php" method="POST">
                        <div class="mb-3">
                            <label for="username" class="form-label">Usuario</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="las la-user"></i></span>
                                <input type="text" class="form-control" id="username" name="username"
                                    placeholder="Ingresa tu usuario" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="las la-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password"
                                    placeholder="Ingresa tu contraseña" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning btn-block">Ingresar</button>
                    </form>
                    <div class="mt-3">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#passwordRecoveryModal">¿Olvidaste tu
                            contraseña?</a><br>
                        <a href="index.php?modulo=registro">¿No tienes cuenta? Regístrate aquí.</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Recuperación de Contraseña -->
<div class="modal fade" id="passwordRecoveryModal" tabindex="-1" aria-labelledby="passwordRecoveryModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordRecoveryModalLabel">Recuperación de Contraseña</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Tabs de Pasos -->
                <ul class="nav nav-tabs" id="recoveryTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" id="email-tab" data-bs-toggle="tab" href="#email" role="tab">Paso 1:
                            Correo</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="token-tab" data-bs-toggle="tab" href="#token" role="tab">Paso 2:
                            Token</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="change-tab" data-bs-toggle="tab" href="#change" role="tab">Paso 3:
                            Cambiar</a>
                    </li>
                </ul>

                <!-- Contenido de Tabs -->
                <div class="tab-content mt-3">
                    <!-- Paso 1: Ingreso de Correo -->
                    <div class="tab-pane fade show active" id="email" role="tabpanel">
                        <form id="sendTokenForm">
                            <div class="mb-3">
                                <label for="recoveryEmail" class="form-label">Ingresa tu correo electrónico:</label>
                                <input type="email" class="form-control" id="recoveryEmail" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Enviar Token</button>
                        </form>
                    </div>
                    <!-- Paso 2: Ingreso de Token -->
                    <div class="tab-pane fade" id="token" role="tabpanel">
                        <form id="verifyTokenForm">
                            <div class="mb-3">
                                <label for="verificationToken" class="form-label">Ingresa el token recibido:</label>
                                <input type="text" class="form-control" id="verificationToken" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Verificar Token</button>
                        </form>
                    </div>

                    <!-- Paso 3: Cambio de Contraseña -->
                    <div class="tab-pane fade" id="change" role="tabpanel">
                        <form id="changePasswordForm">
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">Nueva Contraseña:</label>
                                <input type="password" class="form-control" id="newPassword" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmNewPassword" class="form-label">Confirmar Nueva Contraseña:</label>
                                <input type="password" class="form-control" id="confirmNewPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Cambiar Contraseña</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<script src="modulos\autenticacion\script.js"></script>