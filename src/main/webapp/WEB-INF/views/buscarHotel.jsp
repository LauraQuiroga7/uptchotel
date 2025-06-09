<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Buscar Hotel</title>
    <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f4f4f4;
    }

    h2, h3 {
      text-align: center;
      color: #333;
    }

    form {
      background-color: white;
      padding: 20px;
      max-width: 500px;
      margin: auto;
      border-radius: 8px;
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
      margin-bottom: 15px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }

    input[type="submit"] {
      background-color: #333;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
    }

    input[type="submit"]:hover {
      background-color: #555;
    }

    #resultado {
      max-width: 900px;
      margin: 20px auto;
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 10px;
      border: 1px solid #ccc;
      text-align: center;
    }

    th {
      background-color: #333;
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    a {
      display: block;
      text-align: center;
      margin-top: 20px;
      color: #333;
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }
  </style>

  <script>
    function buscarHotel() {
      var nombre = document.getElementById("nombre").value;
      var ciudad = document.getElementById("ciudad").value;

      var url = "/api/hoteles/buscar?";
      if (nombre) {
        url += "nombre=" + encodeURIComponent(nombre) + "&";
      }
      if (ciudad) {
        url += "ciudad=" + encodeURIComponent(ciudad);
      }

      fetch(url)
        .then((response) => {
          if (!response.ok) {
            throw new Error("Error en la búsqueda.");
          }
          return response.json();
        })
        .then((data) => {
          var resultadoDiv = document.getElementById("resultado");
          resultadoDiv.innerHTML = "";

          if (data.length === 0) {
            resultadoDiv.innerHTML = "<p>No se encontraron hoteles.</p>";
          } else {
            var html =
              "<table><tr>" +
              "<th>Nombre</th>" +
              "<th>Ciudad</th>" +
              "<th>Dirección</th>" +
              "<th>Teléfono</th>" +
              "<th>Email</th>" +
              "<th>Capacidad</th>" +
              "<th>Activo</th>" +
              "</tr>";

            data.forEach((hotel) => {
              html +=
                "<tr>" +
                "<td>" + hotel.name + "</td>" +
                "<td>" + hotel.city + "</td>" +
                "<td>" + hotel.address + "</td>" +
                "<td>" + hotel.phone + "</td>" +
                "<td>" + hotel.email + "</td>" +
                "<td>" + hotel.capacity + "</td>" +
                "<td>" + (hotel.state ? "Sí" : "No") + "</td>" +
                "</tr>";
            });

            html += "</table>";
            resultadoDiv.innerHTML = html;
          }
        })
        .catch((error) => {
          document.getElementById("resultado").innerHTML =
            "<p style='color:red;'>Error al buscar hoteles.</p>";
        });

      return false;
    }
  </script>
    
  </head>
  <body>
    <h2>Buscar Hotel</h2>
<form action="${pageContext.request.contextPath}/api/hotel/buscar" method="get">
    <label>Nombre:</label>
    <input type="text" name="nombre" />
    <label>Ciudad:</label>
    <input type="text" name="ciudad" />
    <input type="submit" value="buscar" />
</form>


    <h3>Resultados:</h3>
    <div id="resultado"></div>

    <br />
<a href="${pageContext.request.contextPath}/">Volver al menú</a>
  </body>
</html>
