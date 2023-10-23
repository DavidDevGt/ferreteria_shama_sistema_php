// Olvidaste la contraseña - Modal
document.querySelector('a[href="#"]').addEventListener('click', function (e) {
    e.preventDefault();
    var myModal = new bootstrap.Modal(document.getElementById('passwordRecoveryModal'));
    myModal.show();
});