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

<form action="${pageContext.request.contextPath}/registrarHotel" method="post">
      <label>Nombre:</label> <input type="text" name="nombre" /><br /><br />
      <label>Ciudad:</label> <input type="text" name="ciudad" /><br /><br />
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

      <input type="submit" value="Registrar" />
    </form>

    <br />
    <a href="/">Volver al menú principal</a>
  </body>

  </html>