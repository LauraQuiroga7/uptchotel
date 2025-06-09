<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Cambiar Estado Hotel</title>
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
      }

      input[type="submit"]:hover {
        background-color: #0056b3;
      }

      #resultado {
        max-width: 500px;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

      p {
        margin: 10px 0;
      }
    </style>
    <script>
      function buscarHotel() {
        var nombre = document.getElementById("nombre").value;
        var ciudad = document.getElementById("ciudad").value;

        // Construir URL de la API REST para buscar
        var url =
          "/api/hoteles/buscar?nombre=" +
          encodeURIComponent(nombre) +
          "&ciudad=" +
          encodeURIComponent(ciudad);

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
              resultadoDiv.innerHTML = "<p>No se encontró el hotel.</p>";
            } else {
              // Mostrar info del hotel y formulario para cambiar estado
              var hotel = data[0]; // en teoría solo hay uno con nombre + ciudad

              var html =
                "<p><strong>Nombre:</strong> " +
                hotel.nombre +
                "</p>" +
                "<p><strong>Ciudad:</strong> " +
                hotel.ciudad +
                "</p>" +
                "<p><strong>Dirección:</strong> " +
                hotel.direccion +
                "</p>" +
                "<p><strong>Estado actual:</strong> " +
                (hotel.activo ? "Activo" : "Inactivo") +
                "</p>" +
                "<form onsubmit='return cambiarEstado(\"" +
                hotel.nombre +
                '", "' +
                hotel.ciudad +
                "\");'>" +
                "<label>Nuevo estado:</label>" +
                "<select id='nuevoEstado'>" +
                "<option value='true'>Activo</option>" +
                "<option value='false'>Inactivo</option>" +
                "</select><br><br>" +
                "<input type='submit' value='Cambiar Estado'>" +
                "</form>";

              resultadoDiv.innerHTML = html;
            }
          })
          .catch((error) => {
            document.getElementById("resultado").innerHTML =
              "<p style='color:red;'>Error al buscar hotel.</p>";
          });

        return false;
      }

      function cambiarEstado(nombre, ciudad) {
        var nuevoEstado = document.getElementById("nuevoEstado").value;

        var url =
          "/api/hoteles/cambiarEstado?nombre=" +
          encodeURIComponent(nombre) +
          "&ciudad=" +
          encodeURIComponent(ciudad) +
          "&activo=" +
          encodeURIComponent(nuevoEstado);

        fetch(url, {
          method: "PUT",
        })
          .then((response) => {
            if (response.ok) {
              document.getElementById("resultado").innerHTML =
                "<p style='color:green;'>Estado cambiado correctamente.</p>";
            } else {
              throw new Error("Error al cambiar el estado.");
            }
          })
          .catch((error) => {
            document.getElementById("resultado").innerHTML =
              "<p style='color:red;'>Error al cambiar el estado.</p>";
          });

        return false;
      }
    </script>
  </head>
  <body>
    <h2>Cambiar Estado del Hotel</h2>

    <form onsubmit="return buscarHotel();">
      <label>Nombre:</label>
      <input type="text" id="nombre" name="nombre" required /><br /><br />

      <label>Ciudad:</label>
      <input type="text" id="ciudad" name="ciudad" required /><br /><br />

      <input type="submit" value="Buscar Hotel" />
    </form>

    <h3>Resultado:</h3>
    <div id="resultado"></div>

    <br />
    <a href="/">Volver al menú principal</a>
  </body>
</html>
