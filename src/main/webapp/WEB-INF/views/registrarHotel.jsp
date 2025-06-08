<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8" />
    <title>Registrar Hotel</title>
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