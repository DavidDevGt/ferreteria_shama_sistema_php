$(document).ready(function() {
    $("#formRegistro").submit(function(e) {
        e.preventDefault();

        // Recopila los datos del formulario
        let datos = {
            action: 'register',
            username: $("#registerUsername").val(),
            email: $("#registerEmail").val(),
            password: $("#registerPassword").val()
            // Puedes agregar el rol_id aquí si es necesario
        };

        // Obtener la URL base actual
        let baseUrl = window.location.href;

        // Construir la URL completa para la solicitud AJAX
        let ajaxUrl = 'modulos/autenticacion/ajax.php';

        // Realiza la petición AJAX
        $.ajax({
            url: ajaxUrl,
            type: 'POST',
            data: datos,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message);
                    // Redirecciona o realiza cualquier otra acción después de un registro exitoso
                } else {
                    alert(response.message);
                }
            },
            error: function(xhr, status, error) {
                alert('Error en la petición: ' + error);
            }
        });
    });
});
