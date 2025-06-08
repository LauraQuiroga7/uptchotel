<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Editar Hotel</title>
  </head>
  <body>
    <h2>Editar Hotel</h2>

    <form method="post" action="/api/hoteles/editar?_method=PUT">
      <!-- IMPORTANTE: Aquí el método original es PUT, pero HTML solo permite GET o POST.
         Usamos _method=PUT para que Spring lo interprete como PUT (si tu config lo permite). -->

      <!-- Nombre y ciudad son la clave del hotel que queremos editar -->
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
