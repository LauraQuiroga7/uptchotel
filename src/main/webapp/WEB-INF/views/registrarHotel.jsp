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

      #mensaje {
        text-align: center;
        margin-top: 15px;
        font-weight: bold;
      }
    </style>
  </head>

  <body>
    <h2>Registrar Hotel</h2>

    <form id="formHotel" onsubmit="enviarFormulario(event)">
      <label>Nombre:</label>
      <input type="text" id="name" /><br />

      <label>Ciudad:</label>
      <input type="text" id="city" /><br />

      <label>Dirección:</label>
      <input type="text" id="address" /><br />

      <label>Teléfono:</label>
      <input type="text" id="phone" /><br />

      <label>Email:</label>
      <input type="email" id="email" /><br />

      <label>Capacidad:</label>
      <input type="number" id="capacity" /><br />

      <label>Activo:</label>
      <select id="state">
        <option value="true">Activo</option>
        <option value="false">Inactivo</option>
      </select><br />

      <input type="submit" value="Registrar" />
    </form>

    <p id="mensaje"></p>

    <a href="${pageContext.request.contextPath}/">Volver al menú</a>

    <script>
      async function enviarFormulario(event) {
        event.preventDefault(); // Evita que se envíe el formulario tradicionalmente

        // Validación básica
        const campos = ["name", "city", "address", "phone", "email", "capacity"];
        for (let campo of campos) {
          const valor = document.getElementById(campo).value.trim();
          if (valor === "") {
            alert("El campo '" + campo + "' no puede estar vacío.");
            return;
          }
        }

        const email = document.getElementById("email").value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
          alert("El correo electrónico no es válido.");
          return;
        }

        const capacidad = parseInt(document.getElementById("capacity").value.trim(), 10);
        if (isNaN(capacidad) || capacidad <= 0) {
          alert("La capacidad debe ser un número positivo.");
          return;
        }

        // Preparar objeto para enviar
        const hotel = {
          name: document.getElementById("name").value.trim(),
          city: document.getElementById("city").value.trim(),
          address: document.getElementById("address").value.trim(),
          phone: document.getElementById("phone").value.trim(),
          email: document.getElementById("email").value.trim(),
          capacity: parseInt(document.getElementById("capacity").value.trim(), 10),
          state: document.getElementById("state").value === "true"
        };

        try {
          const response = await fetch("${pageContext.request.contextPath}/apiRegistro", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify(hotel)
          });

          if (response.ok) {
            alert("Hotel registrado exitosamente");
            // Redireccionar al menú principal
            window.location.href = "${pageContext.request.contextPath}/";
          } else {
            const errorText = await response.text();
            alert("Error al registrar el hotel: " + errorText);
          }
        } catch (error) {
          console.error("Error de red:", error);
          alert("Ocurrió un error de red al registrar el hotel");
        }
      }
    </script>
  </body>

  </html>