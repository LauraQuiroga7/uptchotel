<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <title>UPTCHotels - Menú Principal</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            overflow: hidden;
            background-color: #333;
        }

        .navbar a {
            float: left;
            font-size: 16px;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        .dropdown {
            float: left;
            overflow: hidden;
        }

        .dropdown .dropbtn {
            font-size: 16px;
            border: none;
            outline: none;
            color: white;
            padding: 14px 16px;
            background-color: inherit;
            font-family: inherit;
            margin: 0;
            cursor: pointer;
        }

        .navbar a:hover,
        .dropdown:hover .dropbtn {
            background-color: #555;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 200px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .dropdown-content a {
            float: none;
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

        .dropdown-content a:hover {
            background-color: #ddd;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
</head>

<body>
    <div class="navbar">
        <div class="dropdown">
            <button class="dropbtn">Hoteles ▼</button>
            <div class="dropdown-content">
                <a href="registrarHotel">Registrar Hotel</a>
                <a href="editarHotel">Editar Hotel</a>
                <a href="eliminarHotel">Eliminar Hotel</a>
                <a href="buscarHotel">Buscar Hotel</a>
                <a href="cambiarEstadoHotel">Cambiar Estado Hotel</a>
                <a href="listarHoteles">Listar Hoteles</a>
            </div>
        </div>
        <div class="dropdown">
            <button class="dropbtn">Reservas ▼</button>
            <div class="dropdown-content">
                <a href="registrarReserva">Registrar Reserva</a>
                <a href="cambiarEstadoReserva">Cambiar Estado Reserva</a>
                <a href="reporteReservas">Reporte de Reservas</a>
            </div>
        </div>
    </div>

    <div style="padding: 20px">
        <h2>Bienvenido a UPTCHotels</h2>
        <p>Seleccione una opción del menú para comenzar.</p>
    </div>
</body>

</html>