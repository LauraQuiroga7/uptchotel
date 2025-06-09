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
        width: 100%;
      }

      input[type="submit"]:hover {
        background-color: #0056b3;
      }

      input[type="button"] {
        background-color: #6c757d;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        margin-top: 10px;
      }

      input[type="button"]:hover {
        background-color: #545b62;
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

      .mensaje {
        text-align: center;
        padding: 10px;
        margin: 20px auto;
        max-width: 500px;
        border-radius: 5px;
      }

      .exito {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
      }

      .error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }

      .info {
        background-color: #d1ecf1;
        color: #0c5460;
        border: 1px solid #bee5eb;
      }

      #formularioBusqueda {
        display: block;
      }

      #formularioEdicion {
        display: none;
      }

      .hotel-info {
        background-color: #e9ecef;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
      }

      .hotel-info h3 {
        margin-top: 0;
        color: #495057;
      }
    </style>
  </head>
  <body>
    <h2>Buscar Hotel</h2>

    <form action="${pageContext.request.contextPath}/searchHotel" method="get">
    <label>Nombre:</label>
    <input type="text" name="nombre" />
    <label>Ciudad:</label>
    <input type="text" name="ciudad" />
    <input type="submit" value="buscar" />
</form>
    <br />
<a href="${pageContext.request.contextPath}/">Volver al menú</a>
  </body>
</html>