<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Hoteles</title>
    <style>
        body {
            font-family: Arial;
            margin: 40px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        table, th, td {
            border: 1px solid #666;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .activo { color: green; }
        .inactivo { color: red; }
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
    <a href="/">Volver al menú</a>
</body>
</html>
