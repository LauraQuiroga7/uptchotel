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

      .warning {
        background-color: #fff3cd;
        color: #856404;
        border: 1px solid #ffeaa7;
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
    <h2>Editar Hotel</h2>

    <!-- PASO 1: Buscar Hotel -->
    <div id="formularioBusqueda">
      <form onsubmit="return buscarHotel();">
        <label>Nombre del Hotel a Buscar:</label>
        <input type="text" id="nombreBuscar" required />

        <label>Ciudad del Hotel a Buscar:</label>
        <input type="text" id="ciudadBuscar" required />

        <input type="submit" value="Buscar Hotel" />
      </form>
    </div>

    <!-- PASO 2: Editar Hotel -->
    <div id="formularioEdicion">
      <div class="hotel-info">
        <h3>Hotel Encontrado:</h3>
        <div id="hotelEncontrado"></div>
      </div>

      <div class="mensaje warning">
        <strong>Nota:</strong> Ahora puede editar todos los campos incluyendo nombre y ciudad.
      </div>

      <form onsubmit="return editarHotel();">
        <input type="hidden" id="nombreOriginal" />
        <input type="hidden" id="ciudadOriginal" />

        <label>Nombre:</label>
        <input type="text" id="name" required />

        <label>Ciudad:</label>
        <input type="text" id="city" required />

        <label>Dirección:</label>
        <input type="text" id="address" required />

        <label>Teléfono:</label>
        <input type="text" id="phone" required />

        <label>Email:</label>
        <input type="email" id="email" required />

        <label>Capacidad:</label>
        <input type="number" id="capacity" min="1" required />

        <label>Estado:</label>
        <select id="state" required>
          <option value="true">Activo</option>
          <option value="false">Inactivo</option>
        </select>

        <input type="submit" value="Guardar Cambios" />
        <input type="button" value="Buscar Otro Hotel" onclick="volverABuscar()" />
      </form>
    </div>

    <div id="mensaje"></div>

    <br />
    <a href="${pageContext.request.contextPath}/">Volver al menú principal</a>

    <script>
      function mostrarMensaje(texto, tipo) {
        const div = document.getElementById('mensaje');
        div.className = 'mensaje ' + tipo;
        div.innerHTML = texto;
      }

     function buscarHotel() {
  const nombre = document.getElementById('nombreBuscar').value.trim();
  const ciudad = document.getElementById('ciudadBuscar').value.trim();

  // Corregir el endpoint - agregar /uptchotels/
  fetch('${pageContext.request.contextPath}/buscarEspecifico?nombre=' + encodeURIComponent(nombre) + '&ciudad=' + encodeURIComponent(ciudad))
    .then(response => {
      if (response.status === 404) {
        mostrarMensaje('No se encontró ningún hotel con ese nombre y ciudad.', 'error');
        return null;
      }
      if (!response.ok) {
        throw new Error('Error en la respuesta del servidor: ' + response.status);
      }
      return response.json();
    })
    .then(data => {
      console.log('Datos recibidos:', data); // Para debug
      if (data) {
        // Si el endpoint devuelve un array, tomar el primer elemento
        if (Array.isArray(data) && data.length > 0) {
          mostrarFormularioEdicion(data[0]);
        } else if (!Array.isArray(data)) {
          // Si devuelve un objeto directamente
          mostrarFormularioEdicion(data);
        } else {
          mostrarMensaje('No se encontró ningún hotel con ese nombre y ciudad.', 'error');
        }
      }
    })
    .catch(error => {
      console.error('Error:', error);
      mostrarMensaje('Error al buscar el hotel: ' + error.message, 'error');
    });

  return false;
}

      function mostrarFormularioEdicion(hotel) {
        console.log("Hotel recibido:", hotel);

        document.getElementById('formularioBusqueda').style.display = 'none';
        document.getElementById('formularioEdicion').style.display = 'block';

        document.getElementById('hotelEncontrado').innerHTML = `
          <p><strong>Nombre:</strong> ${hotel.name}</p>
          <p><strong>Ciudad:</strong> ${hotel.city}</p>
          <p><strong>Dirección:</strong> ${hotel.address}</p>
          <p><strong>Teléfono:</strong> ${hotel.phone}</p>
          <p><strong>Email:</strong> ${hotel.email}</p>
          <p><strong>Capacidad:</strong> ${hotel.capacity}</p>
          <p><strong>Estado:</strong> ${hotel.state ? 'Activo' : 'Inactivo'}</p>`;

        document.getElementById('nombreOriginal').value = hotel.name;
        document.getElementById('ciudadOriginal').value = hotel.city;
        document.getElementById('name').value = hotel.name;
        document.getElementById('city').value = hotel.city;
        document.getElementById('address').value = hotel.address;
        document.getElementById('phone').value = hotel.phone;
        document.getElementById('email').value = hotel.email;
        document.getElementById('capacity').value = hotel.capacity;
        document.getElementById('state').value = hotel.state.toString();
      }

      function editarHotel() {
        const nombreOriginal = document.getElementById('nombreOriginal').value;
        const ciudadOriginal = document.getElementById('ciudadOriginal').value;

        const hotelEditado = {
          name: document.getElementById('name').value.trim(),
          city: document.getElementById('city').value.trim(),
          address: document.getElementById('address').value.trim(),
          phone: document.getElementById('phone').value.trim(),
          email: document.getElementById('email').value.trim(),
          capacity: parseInt(document.getElementById('capacity').value),
          state: document.getElementById('state').value === 'true'
        };

        if (!hotelEditado.name || !hotelEditado.city || !hotelEditado.address ||
          !hotelEditado.phone || !hotelEditado.email || !hotelEditado.capacity) {
          mostrarMensaje('Todos los campos son obligatorios.', 'error');
          return false;
        }

        const cambioIdentificador = hotelEditado.name !== nombreOriginal || hotelEditado.city !== ciudadOriginal;

        if (cambioIdentificador) {
          fetch('${pageContext.request.contextPath}/uptchotels/buscar?nombre=' + encodeURIComponent(hotelEditado.name) + '&ciudad=' + encodeURIComponent(hotelEditado.city))
            .then(res => res.json())
            .then(data => {
              if (data.length > 0) {
                mostrarMensaje('Ya existe un hotel con ese nombre y ciudad.', 'error');
              } else {
                fetch('${pageContext.request.contextPath}/eliminar', {
                  method: 'DELETE',
                  headers: { 'Content-Type': 'application/json' },
                  body: JSON.stringify({ name: nombreOriginal, city: ciudadOriginal })
                })
                  .then(res => {
                    if (res.ok) {
                      crearHotelEditado(hotelEditado);
                    } else {
                      mostrarMensaje('No se pudo eliminar el hotel original.', 'error');
                    }
                  });
              }
            });
        } else {
          editarHotelDirectamente(hotelEditado);
        }

        return false;
      }

      function editarHotelDirectamente(hotelEditado) {
        fetch('${pageContext.request.contextPath}/editar', {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(hotelEditado)
        })
          .then(res => {
            if (res.ok) {
              mostrarMensaje('Hotel editado exitosamente.', 'exito');
            } else {
              mostrarMensaje('Error al editar el hotel.', 'error');
            }
          });
      }

      function crearHotelEditado(hotelEditado) {
        fetch('${pageContext.request.contextPath}/uptchotels/registrar', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(hotelEditado)
        })
          .then(res => {
            if (res.ok) {
              mostrarMensaje('Hotel actualizado con nuevo nombre/ciudad.', 'exito');
            } else {
              mostrarMensaje('Error al crear el nuevo hotel.', 'error');
            }
          });
      }

      function volverABuscar() {
        document.getElementById('formularioBusqueda').style.display = 'block';
        document.getElementById('formularioEdicion').style.display = 'none';
        document.getElementById('mensaje').innerHTML = '';
        document.getElementById('hotelEncontrado').innerHTML = '';
      }
    </script>
  </body>

  </html>