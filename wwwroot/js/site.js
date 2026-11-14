// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

// CU-28 / RN-2-CU28: avisar si hay formularios con cambios sin guardar al cerrar sesión
document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById('modal-cerrar-sesion');
    if (!modal) return;

    var hayCambios = false;
    document.querySelectorAll('main form:not([data-sin-aviso])').forEach(function (f) {
        f.addEventListener('input', function () { hayCambios = true; });
        f.addEventListener('submit', function () { hayCambios = false; });
    });

    modal.addEventListener('show.bs.modal', function () {
        var aviso = document.getElementById('aviso-cambios');
        if (aviso) aviso.classList.toggle('d-none', !hayCambios);
    });
});