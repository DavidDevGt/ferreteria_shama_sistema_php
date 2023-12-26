        <div class="row justify-content-center align-items-center h-100">
            <div class="col-lg-8 d-flex mt-3">

                <!-- Contenedor principal -->
                <div class="d-flex w-100 bg-white p-5 rounded shadow-lg justify-content-between">

                    <!-- Logotipo y texto a la izquierda -->
                    <div class="d-flex flex-column justify-content-center align-items-center w-50">
                        <img src="assets\img\fshama.svg" class="img-fluid" style="max-width: 300px;" alt="ferreteria shama">
                        <h2 class="text-center mt-3">Ferretería Shama ERP</h2>
                    </div>

                    <!-- Formulario de inicio de sesión a la derecha -->
                    <div class="w-50">
                        <h3 class="mb-4">Inicio de Sesión</h3>
                        <form id="loginForm">
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
                    </div>

                </div>
            </div>
        </div>

        <script src="modulos\autenticacion\script.js"></script>