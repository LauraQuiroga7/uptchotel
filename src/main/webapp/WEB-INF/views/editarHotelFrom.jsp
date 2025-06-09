<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Editar Hotel</title>
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

        input[type="text"],
        input[type="email"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
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

        .readonly {
            background-color: #f0f0f0;
            color: #666;
        }
    </style>
</head>
<body>
    <h2>Editar Hotel</h2>

    <form method="post" action="${pageContext.request.contextPath}/editarHotel">
        <label>Nombre (No editable):</label>
        <input type="text" name="nombre" value="${hotel.name}" readonly class="readonly" />

        <label>Ciudad (No editable):</label>
        <input type="text" name="ciudad" value="${hotel.city}" readonly class="readonly" />

        <label>Dirección:</label>
        <input type="text" name="direccion" value="${hotel.address}" required />

        <label>Teléfono:</label>
        <input type="text" name="telefono" value="${hotel.phone}" required />

        <label>Email:</label>
        <input type="email" name="email" value="${hotel.email}" required />

        <label>Capacidad:</label>
        <input type="number" name="capacidad" value="${hotel.capacity}" required />

        <label>Estado:</label>
        <select name="activo">
            <option value="true" ${hotel.state ? 'selected' : ''}>Activo</option>
            <option value="false" ${!hotel.state ? 'selected' : ''}>Inactivo</option>
        </select>

        <input type="submit" value="Actualizar Hotel" />
    </form>

    <a href="${pageContext.request.contextPath}/">Volver al menú principal</a>
</body>
</html>