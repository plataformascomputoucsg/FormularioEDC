<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Formulario de Inscripción</title>
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
      <form id="inscripcionForm" enctype="multipart/form-data">
        <!-- Tipo de Programa -->
        <div class="field-group">
          <label>Requiere Diplomados/Programas o Cursos/Talleres</label>
          <div class="select-wrapper">
            <select id="tipoPrograma" name="tipoPrograma" required>
              <option value="" disabled selected>Seleccionar</option>
              <c:forEach var="tipo" items="${tiposCurso}">
                <option value="${tipo.codigo}">${tipo.descripcion}</option>
              </c:forEach>
            </select>
          </div>
        </div>

        <!-- Curso -->
        <div class="field-group">
          <label>Curso</label>
          <div class="select-wrapper select-container">
            <select id="cursoSelect" name="curso" required>
              <option value="" disabled selected>Seleccionar</option>
            </select>
            <div id="cursoLoader" class="loader-inline"></div>
          </div>
        </div>

        <!-- ====== DATOS PERSONALES ====== -->
        <h2 class="section-title">Datos Personales</h2>

        <div class="row">
          <div class="field-group">
            <label>Tipo de identificación</label>
            <div class="select-wrapper">
              <select
                id="tipoIdentificacion"
                name="tipoIdentificacion"
                required
              >
                <option value="" disabled selected>Ingresar</option>
                <c:forEach var="tipo" items="${tiposIdentificacion}">
                  <option value="${tipo.codigo}">${tipo.descripcion}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <div class="field-group">
            <label>N° De Identificación:</label>
            <input
              id="numIdentificacion"
              name="numIdentificacion"
              type="text"
              placeholder="Ingresar"
              maxlength="10"
              pattern="[0-9]{10}"
              title="Ingrese 10 dígitos numéricos"
              inputmode="numeric"
              required
            />
            <span id="errorIdentificacion" class="validation-message"></span>
          </div>
        </div>

        <div class="field-group">
          <label>Apellidos</label>
          <span class="helper-text"
            >Por favor, ingrese su apellido exactamente como desea que aparezcan
            en su certificado. Esta información se utilizará para la emisión
            oficial, por lo que es importante escribirlo sin errores y con la
            correcta acentuación.</span
          >
          <input
            id="apellidos"
            name="apellidos"
            type="text"
            placeholder="Ingresar"
            pattern="[A-Za-zÁÉÍÓÚáéíóúÑñÜü\s]+"
            title="Solo se permiten letras"
            required
          />
        </div>

        <div class="field-group">
          <label>Nombres</label>
          <span class="helper-text"
            >Por favor, ingrese su nombre exactamente como desea que aparezcan
            en su certificado. Esta información se utilizará para la emisión
            oficial, por lo que es importante escribirlo sin errores y con la
            correcta acentuación.</span
          >
          <input
            id="nombres"
            name="nombres"
            type="text"
            placeholder="Ingresar"
            pattern="[A-Za-zÁÉÍÓÚáéíóúÑñÜü\s]+"
            title="Solo se permiten letras"
            required
          />
        </div>

        <div class="row">
          <div class="field-group">
            <label>Celular</label>
            <input
              id="celular"
              name="celular"
              type="tel"
              placeholder="Ingresar"
              pattern="[0-9]+"
              maxlength="10"
              title="Solo se permiten números"
              inputmode="numeric"
              required
            />
          </div>
          <div class="field-group">
            <label>Correo</label>
            <input
              id="correo"
              name="correo"
              type="email"
              placeholder="Ingresar"
              required
            />
          </div>
        </div>

        <div class="row">
          <div class="field-group">
            <label>Estado civil</label>
            <div class="select-wrapper">
              <select id="estadoCivil" name="estadoCivil" required>
                <option value="" disabled selected>Seleccionar</option>
                <option value="S">SOLTERO (A)</option>
                <option value="C">CASADO (A)</option>
                <option value="D">DIVORCIADO (A)</option>
                <option value="V">VIUDO (A)</option>
                <option value="U">UNIDO (A)</option>
              </select>
            </div>
          </div>
          <div class="field-group">
            <label>Sexo</label>
            <div class="select-wrapper">
              <select id="sexo" name="sexo" required>
                <option value="" disabled selected>Seleccionar</option>
                <option value="M">MASCULINO</option>
                <option value="F">FEMENINO</option>
              </select>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="field-group">
            <label>Nacionalidad</label>
            <div class="select-wrapper">
              <select id="nacionalidad" name="nacionalidad" required>
                <option value="" disabled selected>Seleccionar</option>
                <c:forEach var="nac" items="${nacionalidades}">
                  <option value="${nac.codigo}">${nac.descripcion}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <!-- <div class="field-group">
            <label>Género</label>
            <div class="select-wrapper">
              <select id="genero" name="genero" required>
                <option value="" disabled selected>Seleccionar</option>
                <option value="masculino">Masculino</option>
                <option value="femenino">Femenino</option>
                <option value="no_binario">No binario</option>
                <option value="prefiero_no_decir">Prefiero no decir</option>
              </select>
            </div>
          </div> -->
        </div>

        <div class="field-group">
          <label>Dirección</label>
          <input
            id="direccionPersonal"
            name="direccionPersonal"
            type="text"
            placeholder="Ingresar"
            title="Ingrese su dirección"
            required
          />
        </div>

        <!-- ====== DATOS PARA LA FACTURACIÓN ====== -->
        <h2 class="section-title">Datos Para La Facturación</h2>

        <!-- Checkbox: usar datos personales -->
        <div class="checkbox-row">
          <label class="checkbox-label">
            <input type="checkbox" id="usarDatosPersonales" />
            <span class="checkbox-custom"></span>
            Usar mis datos personales para facturar
          </label>
        </div>

        <div class="important-note">
          <strong
            >IMPORTANTE: En caso de solicitar su factura a nombre de un tercero,
            deberá compartir con su asesor los siguientes documentos:</strong
          >
          <ul>
            <li>
              RUC PERSONAL: PDF del RUC de la persona y un correo electrónico
              para notificaciones.
            </li>
            <li>
              RUC EMPRESA: PDF del RUC de la empresa, copia de cédula del
              representante legal y papeleta de votación y un correo electrónico
              para notificaciones.
            </li>
          </ul>
        </div>

        <div class="field-group">
          <label>Tipo</label>
          <div class="select-wrapper">
            <select id="tipoFacturacion" name="tipoFacturacion">
              <option value="" disabled selected>Seleccionar</option>
              <option value="CONSUMIDOR FINAL">CONSUMIDOR FINAL</option>
              <option value="PERSONA">PERSONA</option>
              <option value="EMPRESA">EMPRESA</option>
            </select>
          </div>
        </div>

        <div class="row">
          <div class="field-group">
            <label>Nombre O Razón Social</label>
            <input
              id="nombreRazonSocial"
              name="nombreRazonSocial"
              type="text"
              placeholder="Ingresar"
              pattern="[A-Za-zÁÉÍÓÚáéíóúÑñÜü0-9\s.,&-]+"
              title="Ingrese un nombre o razón social válido"
            />
          </div>
          <div class="field-group">
            <label>Ruc</label>
            <input
              id="ruc"
              name="ruc"
              type="text"
              placeholder="Ingresar"
              maxlength="13"
              pattern="[0-9]{13}"
              title="Ingrese 13 dígitos numéricos"
              inputmode="numeric"
            />
          </div>
        </div>

        <div class="field-group">
          <label>Dirección</label>
          <input
            id="direccionFacturacion"
            name="direccionFacturacion"
            type="text"
            placeholder="Ingresar"
            title="Ingrese su dirección"
          />
        </div>

        <div class="row">
          <div class="field-group">
            <label>Teléfono</label>
            <input
              id="telefonoFacturacion"
              name="telefonoFacturacion"
              type="tel"
              placeholder="Ingresar"
              pattern="[0-9]+"
              maxlength="10"
              title="Solo se permiten números"
              inputmode="numeric"
            />
          </div>
          <div class="field-group">
            <label>Email</label>
            <input
              id="emailFacturacion"
              name="emailFacturacion"
              type="email"
              placeholder="Ingresar"
            />
          </div>
        </div>

        <!-- ====== DOCUMENTOS ====== -->
        <h2 class="section-title">Documentos</h2>

        <div class="field-group">
          <label>Copia de cédula</label>
          <div class="file-input-wrapper">
            <span class="file-placeholder" id="filePlaceholder"
              >Seleccionar</span
            >
            <svg
              class="file-icon"
              xmlns="http://www.w3.org/2000/svg"
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="#888"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path
                d="M21.44 11.05l-9.19 9.19a6 6 0 01-8.49-8.49l9.19-9.19a4 4 0 015.66 5.66l-9.2 9.19a2 2 0 01-2.83-2.83l8.49-8.48"
              />
            </svg>
            <input
              id="copiaCedula"
              name="copiaCedula"
              type="file"
              accept=".pdf,application/pdf"
              required
            />
          </div>
          <span
            id="errorCedula"
            class="validation-message error"
            style="display: none"
          ></span>
        </div>

        <!-- ====== DISTRIBUCIÓN DE PAGOS DEL EVENTO ====== -->
        <h2 class="section-title">Distribución De Pagos Del Evento</h2>

        <div class="row">
          <div class="field-group">
            <label>Valor del evento</label>
            <input type="text" value="$1000" readonly />
          </div>
          <div class="field-group">
            <label>Valor mínimo a pagar de la primer cuota</label>
            <input type="text" value="$100" readonly />
          </div>
        </div>

        <div class="row">
          <div class="field-group">
            <label>Saldo pendiente en cuotas</label>
            <input type="text" value="$900" readonly />
          </div>
          <div class="field-group">
            <label>Número de cuotas</label>
            <input type="text" value="6" readonly />
          </div>
        </div>

        <!-- Submit -->
        <button type="submit" id="btnSubmit" class="btn-submit">
          Realizar Inscripción
        </button>

        <!-- Mensaje de error global -->
        <div
          id="errorGlobal"
          class="validation-message error"
          style="display: none; margin-top: 12px"
        ></div>
      </form>

      <!-- Pantalla de éxito -->
      <div id="successScreen" class="success-screen" style="display: none">
        <div class="success-icon">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="60"
            height="60"
            viewBox="0 0 24 24"
            fill="none"
            stroke="#B31549"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <path d="M20 6L9 17l-5-5" />
          </svg>
        </div>
        <h2 class="success-title">Preinscripción realizada</h2>
        <p class="success-message">
          Al correo registrado se envió una alerta para confirmar tu inscripción
          al curso y generar la orden de pago para realizar el pago del monto
          mínimo.
        </p>
      </div>
    </div>

    <script>
      const tipoId = document.getElementById("tipoIdentificacion");
      const numId = document.getElementById("numIdentificacion");
      const tipoPrograma = document.getElementById("tipoPrograma");
      const cursoSelect = document.getElementById("cursoSelect");
      const cursoLoader = document.getElementById("cursoLoader");
      const copiaCedula = document.getElementById("copiaCedula");
      const filePlaceholder = document.getElementById("filePlaceholder");

      const MAX_FILE_SIZE = 1 * 1024 * 1024; // 1 MB
      const errorCedula = document.getElementById("errorCedula");

      // --- Mostrar nombre del archivo y validar tipo/tamaño ---
      copiaCedula.addEventListener("change", function () {
        errorCedula.style.display = "none";
        if (this.files.length > 0) {
          const file = this.files[0];
          if (
            file.type !== "application/pdf" &&
            !file.name.toLowerCase().endsWith(".pdf")
          ) {
            errorCedula.textContent = "Solo se permiten archivos PDF.";
            errorCedula.style.display = "block";
            this.value = "";
            filePlaceholder.textContent = "Seleccionar";
            return;
          }
          if (file.size > MAX_FILE_SIZE) {
            errorCedula.textContent =
              "El archivo supera el tamaño máximo de 1 MB.";
            errorCedula.style.display = "block";
            this.value = "";
            filePlaceholder.textContent = "Seleccionar";
            return;
          }
          filePlaceholder.textContent = file.name;
        } else {
          filePlaceholder.textContent = "Seleccionar";
        }
      });

      // --- Carga dinámica de cursos ---
      tipoPrograma.addEventListener("change", function () {
        const val = this.value;
        cursoSelect.innerHTML =
          '<option value="" disabled selected>Seleccionar</option>';

        if (val) {
          cursoLoader.style.display = "block";
          fetch(
            "${pageContext.request.contextPath}/api/cursos?tipoCurso=" + val,
          )
            .then((response) => response.json())
            .then((data) => {
              data.forEach((curso) => {
                const option = document.createElement("option");
                option.value = curso.codigo;
                option.textContent = curso.descripcion;
                cursoSelect.appendChild(option);
              });
              cursoLoader.style.display = "none";
            })
            .catch((error) => {
              console.error("Error cargando cursos:", error);
              cursoLoader.style.display = "none";
            });
        }
      });

      // --- Ajuste dinámico por tipo de identificación ---
      tipoId.addEventListener("change", function () {
        numId.value = "";
        var selectedText = this.options[this.selectedIndex].text.toLowerCase();

        if (selectedText.includes("cedula")) {
          numId.maxLength = 10;
          numId.pattern = "[0-9]+";
          numId.title = "Ingrese 10 dígitos numéricos";
          numId.inputMode = "numeric";
          numId.placeholder = "Ingresar cédula (10 dígitos)";
        } else {
          numId.maxLength = 20;
          numId.pattern = "[A-Za-z0-9]+";
          numId.title = "Ingrese un pasaporte alfanumérico";
          numId.inputMode = "text";
          numId.placeholder = "Ingresar identificación";
        }
      });

      numId.addEventListener("input", function () {
        var selectedText = tipoId.options[tipoId.selectedIndex]
          ? tipoId.options[tipoId.selectedIndex].text.toLowerCase()
          : "";
        if (selectedText.includes("cedula")) {
          this.value = this.value.replace(/[^0-9]/g, "");
        } else {
          this.value = this.value.replace(/[^A-Za-z0-9]/g, "");
        }
      });

      // --- Validación de cédula contra Oracle ---
      const errorSpan = document.getElementById("errorIdentificacion");
      numId.addEventListener("blur", function () {
        const valor = this.value.trim();
        const tipo = tipoId.value;
        const selectedText = tipoId.options[tipoId.selectedIndex]
          ? tipoId.options[tipoId.selectedIndex].text.toLowerCase()
          : "";

        if (selectedText.includes("cedula") && valor.length === 10) {
          fetch(
            "${pageContext.request.contextPath}/api/validarIdentificacion?empresa=1&tipoIdent=" +
              tipo +
              "&identificacion=" +
              valor,
          )
            .then((response) => response.json())
            .then((data) => {
              let cleanMessage = (data.mensaje || "")
                .replace(/\.{2,}/g, "")
                .replace(/d\S*gito/gi, "dígito")
                .replace(/cedula/gi, "cédula")
                .trim();

              if (cleanMessage.length > 0) {
                cleanMessage =
                  cleanMessage.charAt(0).toUpperCase() + cleanMessage.slice(1);
              }

              errorSpan.className = "validation-message";

              if (data.valido) {
                errorSpan.textContent = "Cédula correcta";
                errorSpan.classList.add("success");
                numId.style.borderColor = "#28a745";

                // --- Auto-llenado: buscar participante existente ---
                fetch(
                  "${pageContext.request.contextPath}/api/buscarParticipante?empresa=1&tipoIdent=" +
                    tipo +
                    "&identificacion=" +
                    valor,
                )
                  .then((r) => r.json())
                  .then((p) => {
                    if (!p.encontrado) return;

                    function setField(id, val) {
                      const el = document.getElementById(id);
                      if (el && val != null) {
                        el.value = val;
                        el.style.borderColor = "#28a745";
                      }
                    }
                    function setSelect(id, val) {
                      const el = document.getElementById(id);
                      if (!el || val == null) return;
                      const upper = String(val).toUpperCase().trim();
                      for (let i = 0; i < el.options.length; i++) {
                        if (
                          el.options[i].value.toUpperCase().trim() === upper
                        ) {
                          el.selectedIndex = i;
                          el.style.borderColor = "#28a745";
                          break;
                        }
                      }
                    }

                    setField("nombres", p.nombres);
                    setField("apellidos", p.apellidos);
                    setField("celular", p.celular);
                    setField("correo", p.correo);
                    setField("direccionPersonal", p.direccion);
                    setSelect("estadoCivil", p.estadoCivil);
                    setSelect("sexo", p.sexo);
                    setSelect("nacionalidad", p.codNacionalidad);
                  })
                  .catch((err) =>
                    console.error("Error al buscar participante:", err),
                  );
              } else {
                errorSpan.textContent =
                  cleanMessage || "Identificación inválida";
                errorSpan.classList.add("error");
                numId.style.borderColor = "#B31549";
              }
            })
            .catch((error) => {
              console.error("Error en validación:", error);
            });
        }
      });

      // --- Checkbox: copiar datos personales a facturación ---
      const chkUsarDatos = document.getElementById("usarDatosPersonales");

      function copiarDatosPersonales() {
        const nombre = (
          document.getElementById("nombres").value.trim() +
          " " +
          document.getElementById("apellidos").value.trim()
        ).trim();
        const celular = document.getElementById("celular").value.trim();
        const correo = document.getElementById("correo").value.trim();
        const direccion = document
          .getElementById("direccionPersonal")
          .value.trim();

        const campoNombre = document.getElementById("nombreRazonSocial");
        const campoTelefono = document.getElementById("telefonoFacturacion");
        const campoEmail = document.getElementById("emailFacturacion");
        const campoDireccion = document.getElementById("direccionFacturacion");

        if (chkUsarDatos.checked) {
          campoNombre.value = nombre;
          campoTelefono.value = celular;
          campoEmail.value = correo;
          campoDireccion.value = direccion;

          campoNombre.disabled = true;
          campoTelefono.disabled = true;
          campoEmail.disabled = true;
          campoDireccion.disabled = true;
        } else {
          campoNombre.value = "";
          campoTelefono.value = "";
          campoEmail.value = "";
          campoDireccion.value = "";

          campoNombre.disabled = false;
          campoTelefono.disabled = false;
          campoEmail.disabled = false;
          campoDireccion.disabled = false;
        }
      }

      chkUsarDatos.addEventListener("change", copiarDatosPersonales);

      // --- Envío del formulario vía AJAX ---
      const form = document.getElementById("inscripcionForm");
      const successScreen = document.getElementById("successScreen");
      const btnSubmit = document.getElementById("btnSubmit");
      const errorGlobal = document.getElementById("errorGlobal");

      form.addEventListener("submit", function (e) {
        e.preventDefault();

        if (!form.checkValidity()) {
          form.reportValidity();
          return;
        }

        // Re-validar archivo antes de enviar
        if (copiaCedula.files.length > 0) {
          const file = copiaCedula.files[0];
          if (
            file.type !== "application/pdf" &&
            !file.name.toLowerCase().endsWith(".pdf")
          ) {
            errorCedula.textContent = "Solo se permiten archivos PDF.";
            errorCedula.style.display = "block";
            return;
          }
          if (file.size > MAX_FILE_SIZE) {
            errorCedula.textContent =
              "El archivo supera el tamaño máximo de 1 MB.";
            errorCedula.style.display = "block";
            return;
          }
        }

        // Deshabilitar botón para evitar doble envío
        btnSubmit.disabled = true;
        btnSubmit.textContent = "Enviando...";
        errorGlobal.style.display = "none";

        // Los campos disabled no se incluyen en FormData: los habilitamos momentáneamente
        const camposFacturacion = [
          document.getElementById("nombreRazonSocial"),
          document.getElementById("telefonoFacturacion"),
          document.getElementById("emailFacturacion"),
          document.getElementById("direccionFacturacion"),
        ];
        camposFacturacion.forEach((c) => {
          if (c.disabled) c.disabled = false;
        });

        const formData = new FormData(form);

        fetch("${pageContext.request.contextPath}/formulario", {
          method: "POST",
          body: formData,
        })
          .then((response) => response.json())
          .then((data) => {
            if (data.exito) {
              form.style.display = "none";
              successScreen.style.display = "flex";
            } else {
              errorGlobal.textContent =
                data.mensaje || "Ocurrió un error al enviar el formulario.";
              errorGlobal.style.display = "block";
              btnSubmit.disabled = false;
              btnSubmit.textContent = "Realizar Inscripción";
            }
          })
          .catch((error) => {
            console.error("Error al enviar el formulario:", error);
            errorGlobal.textContent =
              "Error de conexión. Por favor, intente nuevamente.";
            errorGlobal.style.display = "block";
            btnSubmit.disabled = false;
            btnSubmit.textContent = "Realizar Inscripción";
          });
      });
    </script>

    <script
      async
      src="http://localhost:3000/browser-sync/browser-sync-client.js?v=2.29.3"
    ></script>
  </body>
</html>
