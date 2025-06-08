<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Buscar Hotel</title>
    <script>
      function buscarHotel() {
        var nombre = document.getElementById("nombre").value;
        var ciudad = document.getElementById("ciudad").value;

        // Construir URL de la API REST con parámetros
        var url = "/api/hoteles/buscar?";
        if (nombre) {
          url += "nombre=" + encodeURIComponent(nombre) + "&";
        }
        if (ciudad) {
          url += "ciudad=" + encodeURIComponent(ciudad);
        }

        // Hacer la llamada AJAX (fetch)
        fetch(url)
          .then((response) => {
            if (!response.ok) {
              throw new Error("Error en la búsqueda.");
            }
            return response.json();
          })
          .then((data) => {
            // Mostrar resultados
            var resultadoDiv = document.getElementById("resultado");
            resultadoDiv.innerHTML = ""; // Limpiar resultados anteriores

            if (data.length === 0) {
              resultadoDiv.innerHTML = "<p>No se encontraron hoteles.</p>";
            } else {
              var html =
                "<table border='1'><tr>" +
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
                  "<td>" +
                  hotel.nombre +
                  "</td>" +
                  "<td>" +
                  hotel.ciudad +
                  "</td>" +
                  "<td>" +
                  hotel.direccion +
                  "</td>" +
                  "<td>" +
                  hotel.telefono +
                  "</td>" +
                  "<td>" +
                  hotel.email +
                  "</td>" +
                  "<td>" +
                  hotel.capacidad +
                  "</td>" +
                  "<td>" +
                  (hotel.activo ? "Sí" : "No") +
                  "</td>" +
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

        // No enviar el formulario (cancelamos submit normal)
        return false;
      }
    </script>
  </head>
  <body>
    <h2>Buscar Hotel</h2>

    <form onsubmit="return buscarHotel();">
      <label>Nombre:</label>
      <input type="text" id="nombre" name="nombre" /><br /><br />

      <label>Ciudad:</label>
      <input type="text" id="ciudad" name="ciudad" /><br /><br />

      <input type="submit" value="Buscar" />
    </form>

    <h3>Resultados:</h3>
    <div id="resultado"></div>

    <br />
    <a href="/">Volver al menú principal</a>
  </body>
</html>
