$(document).ready(function() {
    // Capturar el evento submit del formulario
    $("#formRegistro").submit(function(e) {
        e.preventDefault();  // Evita que el formulario se envíe de la manera predeterminada

        // Recopila los datos del formulario
        let datos = {
            action: 'register',
            username: $("#registerUsername").val(),
            email: $("#registerEmail").val(),
            password: $("#registerPassword").val()
            // Puedes agregar el rol_id aquí si es necesario
        };

        // Realiza la petición AJAX
        $.ajax({
            url: 'ajax.php',
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
