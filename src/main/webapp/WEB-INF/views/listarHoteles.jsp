<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Hoteles</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .activo {
            color: green;
            font-weight: bold;
        }

        .inactivo {
            color: red;
            font-weight: bold;
        }

        a {
            display: block;
            width: fit-content;
            margin: 0 auto;
            margin-top: 30px;
            text-align: center;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Lista de Hoteles</h2>

    <table>
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Ciudad</th>
                <th>Dirección</th>
                <th>Teléfono</th>
                <th>Email</th>
                <th>Capacidad</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="hotel" items="${listaHoteles}">
                <tr>
                    <td>${hotel.name}</td>
                    <td>${hotel.city}</td>
                    <td>${hotel.address}</td>
                    <td>${hotel.phone}</td>
                    <td>${hotel.email}</td>
                    <td>${hotel.capacity}</td>
                    <td>
                        <span class="${hotel.state ? 'activo' : 'inactivo'}">
                            ${hotel.state ? 'Activo' : 'Inactivo'}
                        </span>
                    </td>
                   
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
<a href="${pageContext.request.contextPath}/">Volver al menú</a>
</body>
</html>
