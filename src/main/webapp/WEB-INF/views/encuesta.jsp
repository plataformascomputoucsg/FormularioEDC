<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encuesta de Satisfacción</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/estilos.css">
</head>
<body>

<div class="contenedor">

<form>

<label>Tipo De Capacitación</label>
<select id="tipoPrograma" required>
  <option value="" disabled selected>Seleccione...</option>
  <c:forEach var="tipo" items="${tiposCurso}">
    <option value="${tipo.codigo}">${tipo.descripcion}</option>
  </c:forEach>
</select>

<label>Curso</label>
<div class="select-container">
  <select id="cursoSelect" required>
    <option value="" disabled selected>Seleccione...</option>
  </select>
  <div id="cursoLoader" class="loader-inline"></div>
</div>

<label>N° De Cédula:</label>
<input 
type="text"
placeholder="Ingresar"
maxlength="10"
pattern="[0-9]{10}"
title="La cédula debe tener exactamente 10 números"
oninput="this.value=this.value.replace(/[^0-9]/g,'')"
required>

<h3>1. Grupo de preguntas</h3>

<label>¿Pregunta?</label>
<select required>
  <option value="" disabled selected>Ingresar</option>
  <option>Opcion de respuesta 1</option>
  <option>Opcion de respuesta 2</option>
  <option>Opcion de respuesta 3</option>
</select>

<label>¿Pregunta?</label>
<select required>
  <option value="" disabled selected>Ingresar</option>
  <option>Opcion de respuesta 1</option>
  <option>Opcion de respuesta 2</option>
  <option>Opcion de respuesta 3</option>
</select>

<label>¿Pregunta?</label>
<select required>
  <option value="" disabled selected>Ingresar</option>
  <option>Opcion de respuesta 1</option>
  <option>Opcion de respuesta 2</option>
  <option>Opcion de respuesta 3</option>
</select>

<label>¿Pregunta?</label>
<select required>
  <option value="" disabled selected>Ingresar</option>
  <option>Opcion de respuesta 1</option>
  <option>Opcion de respuesta 2</option>
  <option>Opcion de respuesta 3</option>
</select>

<label>¿Pregunta?</label>
<select required>
  <option value="" disabled selected>Ingresar</option>
  <option>Opcion de respuesta 1</option>
  <option>Opcion de respuesta 2</option>
  <option>Opcion de respuesta 3</option>
</select>

<button type="submit">Enviar</button>

</form>

</div>

    <script>
      const tipoPrograma = document.getElementById("tipoPrograma");
      const cursoSelect = document.getElementById("cursoSelect");
      const cursoLoader = document.getElementById("cursoLoader");

      tipoPrograma.addEventListener("change", function () {
        const val = this.value;
        // Limpiar cursos actuales
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
    </script>
  </body>
</html>
