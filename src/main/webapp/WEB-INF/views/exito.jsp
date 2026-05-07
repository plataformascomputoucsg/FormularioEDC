<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Exitoso</title>
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .success-card {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px auto;
            font-size: 2.5rem;
            color: #ffffff;
        }

        .success-card h1 {
            font-size: 1.75rem;
            color: #1a1a2e;
            margin-bottom: 16px;
        }

        .data-table {
            width: 100%;
            margin: 24px 0;
            border-collapse: collapse;
            text-align: left;
        }

        .data-table th {
            color: #6c757d;
            font-weight: 600;
            padding: 10px 12px;
            border-bottom: 1px solid #dee2e6;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .data-table td {
            color: #343a40;
            padding: 10px 12px;
            border-bottom: 1px solid #f1f3f5;
            font-size: 0.95rem;
        }

        .btn-back {
            display: inline-block;
            padding: 12px 32px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: opacity 0.2s ease;
            margin-top: 8px;
        }

        .btn-back:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>

<div class="success-card">
    <div class="success-icon">&#10003;</div>
    <h1>¡Registro Exitoso!</h1>
    <p>Los datos fueron enviados correctamente.</p>

    <c:if test="${registroDTO != null}">
        <table class="data-table">
            <tr>
                <th>Campo</th>
                <th>Valor</th>
            </tr>
            <tr>
                <td>Nombre</td>
                <td><c:out value="${registroDTO.nombre}" /></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><c:out value="${registroDTO.email}" /></td>
            </tr>
            <tr>
                <td>Mensaje</td>
                <td><c:out value="${registroDTO.mensaje}" /></td>
            </tr>
        </table>
    </c:if>

    <a href="${pageContext.request.contextPath}/formulario" class="btn-back">Nuevo Registro</a>
</div>

<!-- BrowserSync: auto-reload en desarrollo (quitar en producción) -->
<script async src="http://localhost:3000/browser-sync/browser-sync-client.js?v=2.29.3"></script>
</body>
</html>
