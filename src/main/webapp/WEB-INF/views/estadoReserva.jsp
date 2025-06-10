<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Cambiar Estado de Reserva</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
      background-color: #f4f4f4;
    }
    form {
      background-color: white;
      padding: 20px;
      max-width: 500px;
      margin: auto;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    label {
      display: block;
      margin-top: 10px;
      font-weight: bold;
    }
    input, select {
      width: 100%;
      padding: 8px;
      margin-top: 5px;
      margin-bottom: 15px;
    }
    input[type="submit"] {
      background-color: #333;
      color: white;
      cursor: pointer;
    }
    input[type="submit"]:hover {
      background-color: #555;
    }
  </style>
</head>
<body>
  <h2>Cambiar Estado de Reserva</h2>

<form action="${pageContext.request.contextPath}/uptchotels/reservas/cambiarEstadoFormulario" method="post">
    <label for="hotel">Nombre del Hotel:</label>
    <input type="text" name="hotel" required>

    <label for="ciudad">Ciudad del Hotel:</label>
    <input type="text" name="ciudad" required>

    <label for="documento">Documento del Cliente:</label>
    <input type="text" name="documento" required>

    <label for="estado">Nuevo Estado:</label>
    <select name="estado" required>
      <option value="Registrada">Registrada</option>
      <option value="Cancelada">Cancelada</option>
      <option value="Check-in">Check-in</option>
      <option value="Check-out">Check-out</option>
      <option value="Finalizada">Finalizada</option>
    </select>

    <input type="submit" value="Actualizar Estado">
  </form>

  <br>
<a href="${pageContext.request.contextPath}/">Volver al menú</a>
</body>
</html>
