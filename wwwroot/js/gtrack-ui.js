// GTrack - detalles de interfaz: toasts, confirmaciones y botones con carga
(function () {
    'use strict';

    var ICONOS = {
        success: 'bi-check-circle-fill',
        danger: 'bi-x-circle-fill',
        warning: 'bi-exclamation-triangle-fill',
        info: 'bi-info-circle-fill'
    };

    // ---------- Toasts ----------
    function contenedor() {
        var c = document.getElementById('toast-container');
        if (!c) {
            c = document.createElement('div');
            c.id = 'toast-container';
            c.className = 'toast-stack';
            c.setAttribute('aria-live', 'polite');
            document.body.appendChild(c);
        }
        return c;
    }

    function cerrarToast(t) {
        if (!t || t.dataset.cerrando) return;
        t.dataset.cerrando = '1';
        t.classList.add('saliendo');
        setTimeout(function () { t.remove(); }, 300);
    }

    function copiarTexto(texto, boton) {
        function listo() {
            boton.innerHTML = '<i class="bi bi-check2"></i> Copiado';
        }
        if (navigator.clipboard && window.isSecureContext) {
            navigator.clipboard.writeText(texto).then(listo, function () { });
        } else {
            var ta = document.createElement('textarea');
            ta.value = texto;
            ta.style.position = 'fixed';
            ta.style.opacity = '0';
            document.body.appendChild(ta);
            ta.select();
            try { document.execCommand('copy'); listo(); } catch (e) { }
            ta.remove();
        }
    }

    function toast(mensaje, tipo) {
        tipo = ICONOS[tipo] ? tipo : 'info';
        var t = document.createElement('div');
        t.className = 'gt-toast gt-' + tipo;
        t.setAttribute('role', tipo === 'danger' ? 'alert' : 'status');

        var icono = document.createElement('i');
        icono.className = 'bi ' + ICONOS[tipo] + ' gt-toast-icon';

        var cuerpo = document.createElement('div');
        cuerpo.className = 'gt-toast-body';
        var texto = document.createElement('div');
        texto.textContent = mensaje;
        cuerpo.appendChild(texto);

        // Si el mensaje trae un código de pedido, ofrecer copiarlo
        var m = /c[oó]digo\s+([A-Z0-9]{8})\b/i.exec(mensaje);
        if (m) {
            var btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'gt-toast-copiar';
            btn.innerHTML = '<i class="bi bi-clipboard"></i> Copiar código';
            btn.addEventListener('click', function () { copiarTexto(m[1].toUpperCase(), btn); });
            cuerpo.appendChild(btn);
            t.style.setProperty('--gt-dur', '10s');
        }

        var cerrar = document.createElement('button');
        cerrar.type = 'button';
        cerrar.className = 'gt-toast-close';
        cerrar.setAttribute('aria-label', 'Cerrar');
        cerrar.innerHTML = '&times;';
        cerrar.addEventListener('click', function () { cerrarToast(t); });

        var barra = document.createElement('div');
        barra.className = 'gt-toast-bar';
        barra.addEventListener('animationend', function () { cerrarToast(t); });

        t.appendChild(icono);
        t.appendChild(cuerpo);
        t.appendChild(cerrar);
        t.appendChild(barra);
        contenedor().appendChild(t);
        return t;
    }

    // Convierte los mensajes de página (TempData) en toasts
    function convertirAlertas() {
        document.querySelectorAll('.alert').forEach(function (a) {
            if (a.closest('.modal') || a.closest('form') || a.hasAttribute('data-no-toast') || a.classList.contains('d-none')) return;
            if (a.querySelector('.validation-summary-errors, [data-valmsg-summary]')) return;
            var texto = a.textContent.replace(/\s+/g, ' ').trim();
            if (!texto) return;
            var tipo = 'info';
            ['success', 'danger', 'warning', 'info'].forEach(function (t) {
                if (a.classList.contains('alert-' + t)) tipo = t;
            });
            a.remove();
            toast(texto, tipo);
        });
    }

    // ---------- Confirmación ----------
    var confirmacionPendiente = null;

    function mostrarConfirmacion(op) {
        var modalEl = document.getElementById('modal-confirmacion');
        if (!modalEl || !window.bootstrap) {
            // Sin modal disponible: se usa el aviso del navegador
            if (window.confirm(op.mensaje)) op.onOk();
            return;
        }
        var tipo = op.tipo || 'danger';
        var iconos = { danger: 'bi-exclamation-triangle text-danger', warning: 'bi-exclamation-triangle text-warning', primary: 'bi-question-circle text-primary' };
        document.getElementById('confirmacion-icono').className = 'bi ' + (iconos[tipo] || iconos.danger) + ' fs-1 d-block mb-2';
        document.getElementById('confirmacion-titulo').textContent = op.titulo || '¿Estás seguro?';
        document.getElementById('confirmacion-mensaje').textContent = op.mensaje || '';
        var ok = document.getElementById('confirmacion-ok');
        ok.textContent = op.textoOk || 'Confirmar';
        ok.className = 'btn rounded-pill flex-fill btn-' + (tipo === 'primary' ? 'primary' : tipo === 'warning' ? 'warning' : 'danger');
        confirmacionPendiente = op.onOk;
        bootstrap.Modal.getOrCreateInstance(modalEl).show();
    }

    document.addEventListener('DOMContentLoaded', function () {
        var ok = document.getElementById('confirmacion-ok');
        if (ok) {
            ok.addEventListener('click', function () {
                var accion = confirmacionPendiente;
                confirmacionPendiente = null;
                var modalEl = document.getElementById('modal-confirmacion');
                bootstrap.Modal.getOrCreateInstance(modalEl).hide();
                if (accion) accion();
            });
        }
        convertirAlertas();
    });

    // Formularios o botones con data-confirm="mensaje" piden confirmación antes de enviarse
    document.addEventListener('submit', function (e) {
        var form = e.target;
        if (!(form instanceof HTMLFormElement)) return;
        if (form.dataset.confirmado === '1') { form.dataset.confirmado = ''; return; }

        var sub = e.submitter || null;
        var origen = (sub && sub.dataset.confirm) ? sub : (form.dataset.confirm ? form : null);
        if (!origen) return;

        e.preventDefault();
        e.stopPropagation();
        mostrarConfirmacion({
            mensaje: origen.dataset.confirm,
            titulo: origen.dataset.confirmTitulo,
            tipo: origen.dataset.confirmTipo,
            textoOk: origen.dataset.confirmOk,
            onOk: function () {
                form.dataset.confirmado = '1';
                if (form.requestSubmit) { form.requestSubmit(sub || undefined); } else { form.submit(); }
            }
        });
    }, true);

    // ---------- Botones con estado de carga ----------
    document.addEventListener('submit', function (e) {
        var form = e.target;
        if (!(form instanceof HTMLFormElement) || form.hasAttribute('data-no-spinner')) return;
        var sub = e.submitter || form.querySelector('button[type="submit"], input[type="submit"]');
        setTimeout(function () {
            // Si la validación u otro código canceló el envío, no se toca el botón
            if (e.defaultPrevented || !sub || sub.disabled || sub.tagName !== 'BUTTON') return;
            sub.dataset.textoOriginal = sub.innerHTML;
            sub.disabled = true;
            sub.innerHTML = '<span class="spinner-border spinner-border-sm me-2" aria-hidden="true"></span>Procesando…';
        }, 0);
    });

    window.addEventListener('pageshow', function (e) {
        if (!e.persisted) return;
        document.querySelectorAll('button[data-texto-original]').forEach(function (b) {
            b.innerHTML = b.dataset.textoOriginal;
            b.disabled = false;
            delete b.dataset.textoOriginal;
        });
    });

    window.gtrack = { toast: toast, confirmar: mostrarConfirmacion };
})();
