<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    </style>
  </head>
  <body>
    <h2>Editar Hotel</h2>

    <form method="post" action="/api/hoteles/editar?_method=PUT">
  
      <label>Nombre:</label>
      <input type="text" name="nombre" required /><br /><br />
      <label>Ciudad:</label>
      <input type="text" name="ciudad" required /><br /><br />

      <!-- Campos a modificar -->
      <label>Dirección:</label>
      <input type="text" name="direccion" /><br /><br />
      <label>Teléfono:</label> <input type="text" name="telefono" /><br /><br />
      <label>Email:</label> <input type="email" name="email" /><br /><br />
      <label>Capacidad:</label>
      <input type="number" name="capacidad" /><br /><br />
      <label>Activo:</label>
      <select name="activo">
        <option value="true">Activo</option>
        <option value="false">Inactivo</option>
      </select>
      <br /><br />

      <input type="submit" value="Editar Hotel" />
    </form>

    <br />
    <a href="/">Volver al menú principal</a>
  </body>
</html>
