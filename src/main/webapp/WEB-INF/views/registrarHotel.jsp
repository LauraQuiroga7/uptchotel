<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8" />
    <title>Registrar Hotel</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4;
      }

      h2 {
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

      input[type="text"],
      input[type="email"],
      input[type="number"],
      select {
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
      }

      input[type="submit"]:hover {
        background-color: #555;
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
  </head>

  <body>
    <h2>Registrar Hotel</h2>
    <c:if test="${not empty error}">
  <p style="color:red;">${error}</p>
</c:if>
    <form action="${pageContext.request.contextPath}/registrarHotel" method="post"
      onsubmit="return validarFormulario()">
      <label>Nombre:</label>
      <input type="text" name="nombre" id="nombre" /><br /><br />

      <label>Ciudad:</label>
      <input type="text" name="ciudad" id="ciudad" /><br /><br />

      <label>Dirección:</label>
      <input type="text" name="direccion" id="direccion" /><br /><br />

      <label>Teléfono:</label>
      <input type="text" name="telefono" id="telefono" /><br /><br />

      <label>Email:</label>
      <input type="email" name="email" id="email" /><br /><br />

      <label>Capacidad:</label>
      <input type="number" name="capacidad" id="capacidad" /><br /><br />

      <label>Activo:</label>
      <select name="activo" id="activo">
        <option value="true">Activo</option>
        <option value="false">Inactivo</option>
      </select>
      <br /><br />

      <input type="submit" value="Registrar" />
    </form>
    <script>
      function validarFormulario() {
        const campos = ["nombre", "ciudad", "direccion", "telefono", "email", "capacidad"];

        for (let campo of campos) {
          const valor = document.getElementById(campo).value.trim();
          if (valor === "") {
            alert("El campo '" + campo + "' no puede estar vacío.");
            return false;
          }
        }

        const email = document.getElementById("email").value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
          alert("El correo electrónico no es válido.");
          return false;
        }

        const capacidad = parseInt(document.getElementById("capacidad").value.trim(), 10);
        if (isNaN(capacidad) || capacidad <= 0) {
          alert("La capacidad debe ser un número positivo.");
          return false;
        }

        return true; // Si todo está correcto, permite enviar el formulario
      }
    </script>

    <br />
    <a href="${pageContext.request.contextPath}/">Volver al menú</a>

  </body>

  </html>