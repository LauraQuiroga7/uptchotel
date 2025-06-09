<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Eliminar Hotel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        form {
            background-color: #fff;
            max-width: 500px;
            margin: 20px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #c82333;
        }

        a {
            display: block;
            text-align: center;
            margin: 20px;
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            text-decoration: underline;
        }

        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
    <script>
        function confirmarEliminacion() {
            return confirm("¿Está seguro de que desea eliminar este hotel? Esta acción no se puede deshacer.");
        }
    </script>
</head>
<body>
    <h2>Eliminar Hotel</h2>

    <form method="post" action="${pageContext.request.contextPath}/eliminarHotel" onsubmit="return confirmarEliminacion()">
        <div class="warning">
            <strong>¡Advertencia!</strong><br>
            Esta acción eliminará permanentemente el hotel del sistema.
        </div>

        <label>Nombre del Hotel:</label>
        <input type="text" name="nombre" required />

        <label>Ciudad del Hotel:</label>
        <input type="text" name="ciudad" required />

        <input type="submit" value="Eliminar Hotel" />
    </form>

    <a href="${pageContext.request.contextPath}/">Volver al menú principal</a>
</body>
</html>