<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Valor a Pagar</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/styles.css"
    />
  </head>

  <body>
    <div class="form-container">
      <h1 class="page-title">Valor a pagar</h1>

      <!-- ====== PAGOS DEL EVENTO ====== -->
      <div id="pagoSection">
        <h2 class="section-title">Pagos Del Evento</h2>

        <div class="field-group">
          <label>Valor a pagar de la primera cuota</label>
          <input
            id="valorPrimeraCuota"
            type="text"
            placeholder="$0"
            inputmode="numeric"
          />
        </div>

        <!-- Desglose dinámico de cuotas -->
        <div id="desgloseCuotas" class="desglose-cuotas">
          <div class="desglose-row">
            <span class="desglose-label"
              ><strong>Saldo pendiente de pago</strong></span
            >
            <span id="saldoPendiente" class="desglose-value">$0</span>
          </div>
        </div>

        <p class="confirm-text">
          Estás seguro que deseas generar la orden de pago con estos valores
        </p>

        <button id="btnConfirmar" type="button" class="btn-submit">
          Confirmar
        </button>
      </div>

      <!-- ====== ORDEN GENERADA ====== -->
      <div id="ordenSection" style="display: none">
        <h2 class="orden-title">Orden generada correctamente</h2>

        <!-- Espacio para la orden de pago generada desde el backend -->
        <div id="ordenContenido" class="orden-placeholder">
          <p class="orden-placeholder-text">Cargando orden de pago...</p>
        </div>

        <p class="orden-info">
          Una vez realizado este pago, un asesor se pondrá en contacto contigo
          para coordinar el valor restante y definir las cuotas pendientes.<br />
          La factura será emitida con los datos registrados en un plazo de 72
          horas laborables.
        </p>

        <div class="row btn-row">
          <button
            type="button"
            class="btn-submit btn-secondary"
            id="btnOtrasFormas"
          >
            Otras formas de pago
          </button>
          <button type="button" class="btn-submit" id="btnPagarLinea">
            Pagar en línea
          </button>
        </div>
      </div>

      <!-- Modal: Contactar al agente -->
      <div id="modalAgente" class="modal-overlay" style="display: none">
        <div class="modal-box">
          <div class="modal-header">
            <h3 class="modal-title">Contactar al agente</h3>
            <button type="button" class="modal-close" id="btnCerrarModal">
              &times;
            </button>
          </div>
          <div class="modal-body">
            <p>
              Si deseas pagar por otras formas de pago, descarga la orden y
              realiza el pago de forma presencial. Un asesor te contactará para
              dar seguimiento a tu pago.
            </p>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn-submit btn-modal-listo"
              id="btnListo"
            >
              Listo
            </button>
          </div>
        </div>
      </div>
    </div>

    <script>
      // ===== Datos que vendrán desde el backend =====
      const VALOR_EVENTO = 1000;
      const NUM_CUOTAS = 7;
      // ===============================================

      const inputValor = document.getElementById("valorPrimeraCuota");
      const desglose = document.getElementById("desgloseCuotas");
      const saldoPendienteEl = document.getElementById("saldoPendiente");
      const btnConfirmar = document.getElementById("btnConfirmar");
      const pagoSection = document.getElementById("pagoSection");
      const ordenSection = document.getElementById("ordenSection");

      function parseMonto(val) {
        return parseFloat(val.replace(/[^0-9.]/g, "")) || 0;
      }

      function formatMoney(val) {
        return "$" + val.toFixed(0);
      }

      function actualizarDesglose() {
        const primeraCuota = parseMonto(inputValor.value);
        const saldo = Math.max(VALOR_EVENTO - primeraCuota, 0);
        const cuotasRestantes = NUM_CUOTAS - 1;
        const valorCuota = cuotasRestantes > 0 ? saldo / cuotasRestantes : 0;

        // Nombres de cuotas
        const nombres = [
          "Segunda",
          "Tercera",
          "Cuarta",
          "Quinta",
          "Sexta",
          "Séptima",
          "Octava",
          "Novena",
          "Décima",
          "Undécima",
          "Duodécima",
        ];

        // Limpiar desglose previo (mantener saldo pendiente)
        desglose.innerHTML = "";

        // Saldo pendiente
        const saldoRow = document.createElement("div");
        saldoRow.className = "desglose-row";
        saldoRow.innerHTML = `<span class="desglose-label"><strong>Saldo pendiente de pago</strong></span>
                                  <span class="desglose-value">\${formatMoney(saldo)}</span>`;
        desglose.appendChild(saldoRow);

        // Cuotas individuales
        for (let i = 0; i < cuotasRestantes; i++) {
          const nombre = i < nombres.length ? nombres[i] : `Cuota \${i + 2}`;
          const row = document.createElement("div");
          row.className = "desglose-row";
          row.innerHTML = `<span class="desglose-label"><strong>\${nombre} cuota</strong></span>
                                 <span class="desglose-value">\${formatMoney(valorCuota)}</span>`;
          desglose.appendChild(row);
        }
      }

      // Formatear input mientras escribe
      inputValor.addEventListener("input", function () {
        let raw = this.value.replace(/[^0-9]/g, "");
        if (raw) {
          this.value = "$" + raw;
        } else {
          this.value = "";
        }
        actualizarDesglose();
      });

      // Al confirmar
      btnConfirmar.addEventListener("click", function () {
        const primeraCuota = parseMonto(inputValor.value);

        if (primeraCuota <= 0) {
          alert("Ingrese un valor válido para la primera cuota.");
          return;
        }

        if (primeraCuota > VALOR_EVENTO) {
          alert(
            "El valor no puede superar el valor del evento ($" +
              VALOR_EVENTO +
              ").",
          );
          return;
        }

        pagoSection.style.display = "none";
        ordenSection.style.display = "block";
      });

      // Inicializar
      actualizarDesglose();

      // Modal: Otras formas de pago
      const modal = document.getElementById("modalAgente");
      const btnOtrasFormas = document.getElementById("btnOtrasFormas");
      const btnCerrarModal = document.getElementById("btnCerrarModal");
      const btnListo = document.getElementById("btnListo");

      btnOtrasFormas.addEventListener("click", function () {
        modal.style.display = "flex";
      });

      btnCerrarModal.addEventListener("click", function () {
        modal.style.display = "none";
      });

      btnListo.addEventListener("click", function () {
        modal.style.display = "none";
      });

      modal.addEventListener("click", function (e) {
        if (e.target === modal) {
          modal.style.display = "none";
        }
      });
    </script>
  </body>
</html>
