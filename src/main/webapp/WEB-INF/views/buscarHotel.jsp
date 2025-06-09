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

    <!-- PASO 2: Editar Hotel (se muestra después de encontrar el hotel) -->
    <div id="formularioEdicion">
      <div class="hotel-info">
        <h3>Hotel Encontrado:</h3>
        <div id="hotelEncontrado"></div>
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
      function buscarHotel() {
        const nombre = document.getElementById('nombreBuscar').value.trim();
        const ciudad = document.getElementById('ciudadBuscar').value.trim();

        if (!nombre || !ciudad) {
          mostrarMensaje('Por favor ingrese nombre y ciudad del hotel.', 'error');
          return false;
        }

        // Buscar el hotel usando la API
        fetch('${pageContext.request.contextPath}/uptchotels/buscar?nombre=' + encodeURIComponent(nombre) + '&ciudad=' + encodeURIComponent(ciudad))
        .then(response => response.json())
        .then(data => {
          if (data.length === 0) {
            mostrarMensaje('No se encontró ningún hotel con ese nombre y ciudad.', 'error');
          } else {
            // Hotel encontrado, llenar el formulario de edición
            const hotel = data[0]; // Tomar el primer resultado
            mostrarFormularioEdicion(hotel);
          }
        })
        .catch(error => {
          console.error('Error:', error);
          mostrarMensaje('Error al buscar el hotel.', 'error');
        });

        return false;
      }

      function mostrarFormularioEdicion(hotel) {
        // Ocultar formulario de búsqueda y mostrar formulario de edición
        document.getElementById('formularioBusqueda').style.display = 'none';
        document.getElementById('formularioEdicion').style.display = 'block';

        // Mostrar información del hotel encontrado
        document.getElementById('hotelEncontrado').innerHTML = 
          '<p><strong>Nombre:</strong> ' + hotel.name + '</p>' +
          '<p><strong>Ciudad:</strong> ' + hotel.city + '</p>' +
          '<p><strong>Dirección:</strong> ' + hotel.address + '</p>' +
          '<p><strong>Teléfono:</strong> ' + hotel.phone + '</p>' +
          '<p><strong>Email:</strong> ' + hotel.email + '</p>' +
          '<p><strong>Capacidad:</strong> ' + hotel.capacity + '</p>' +
          '<p><strong>Estado:</strong> ' + (hotel.state ? 'Activo' : 'Inactivo') + '</p>';

        // Guardar datos originales para identificar el hotel
        document.getElementById('nombreOriginal').value = hotel.name;
        document.getElementById('ciudadOriginal').value = hotel.city;

        // Llenar formulario con datos actuales
        document.getElementById('name').value = hotel.name;
        document.getElementById('city').value = hotel.city;
        document.getElementById('address').value = hotel.address;
        document.getElementById('phone').value = hotel.phone;
        document.getElementById('email').value = hotel.email;
        document.getElementById('capacity').value = hotel.capacity;
        document.getElementById('state').value = hotel.state.toString();

        mostrarMensaje('Hotel encontrado. Puede modificar los campos y guardar los cambios.', 'info');
      }

      function editarHotel() {
        // Obtener datos originales para identificar el hotel
        const nombreOriginal = document.getElementById('nombreOriginal').value;
        const ciudadOriginal = document.getElementById('ciudadOriginal').value;

        // Obtener los nuevos valores del formulario
        const hotelEditado = {
          name: document.getElementById('name').value.trim(),
          city: document.getElementById('city').value.trim(),
          address: document.getElementById('address').value.trim(),
          phone: document.getElementById('phone').value.trim(),
          email: document.getElementById('email').value.trim(),
          capacity: parseInt(document.getElementById('capacity').value),
          state: document.getElementById('state').value === 'true'
        };

        // Validar que los campos requeridos no estén vacíos
        if (!hotelEditado.name || !hotelEditado.city || !hotelEditado.address || 
            !hotelEditado.phone || !hotelEditado.email || !hotelEditado.capacity) {
          mostrarMensaje('Todos los campos son obligatorios.', 'error');
          return false;
        }

        // Validar email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(hotelEditado.email)) {
          mostrarMensaje('El correo electrónico no es válido.', 'error');
          return false;
        }

        // Validar capacidad
        if (hotelEditado.capacity <= 0) {
          mostrarMensaje('La capacidad debe ser un número positivo.', 'error');
          return false;
        }

        // Editar el hotel directamente
        editarHotelDirectamente(hotelEditado);

        return false;
      }

      function editarHotelDirectamente(hotelEditado) {
        console.log('=== DEBUGGING EDICIÓN DE HOTEL ===');
        console.log('URL que se va a llamar:', '${pageContext.request.contextPath}/uptchotels/editar');
        console.log('Datos que se van a enviar:', hotelEditado);
        console.log('JSON que se va a enviar:', JSON.stringify(hotelEditado));
        
        fetch('${pageContext.request.contextPath}/uptchotels/editar', {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(hotelEditado)
        })
        .then(response => {
          console.log('=== RESPUESTA DEL SERVIDOR ===');
          console.log('Status:', response.status);
          console.log('Status Text:', response.statusText);
          console.log('Headers:', response.headers);
          console.log('OK:', response.ok);
          
          // Siempre intentar leer la respuesta como texto
          return response.text().then(responseText => {
            console.log('Respuesta completa del servidor:', responseText);
            
            if (response.ok) {
              mostrarMensaje('Hotel editado correctamente. Redirigiendo al menú...', 'exito');
              setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/';
              }, 2000);
            } else {
              throw new Error('Error HTTP ' + response.status + ': ' + responseText);
            }
          });
        })
        .catch(error => {
          console.log('=== ERROR CAPTURADO ===');
          console.error('Error completo:', error);
          console.error('Mensaje del error:', error.message);
          console.error('Stack del error:', error.stack);
          mostrarMensaje('Error al editar el hotel: ' + error.message, 'error');
        });
      }

      function volverABuscar() {
        document.getElementById('formularioBusqueda').style.display = 'block';
        document.getElementById('formularioEdicion').style.display = 'none';
        document.getElementById('nombreBuscar').value = '';
        document.getElementById('ciudadBuscar').value = '';
        document.getElementById('mensaje').innerHTML = '';
      }

      function mostrarMensaje(texto, tipo) {
        const mensajeDiv = document.getElementById('mensaje');
        mensajeDiv.innerHTML = '<div class="mensaje ' + tipo + '">' + texto + '</div>';
      }
    </script>
  </body>
</html>