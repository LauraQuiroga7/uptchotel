<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Buscar Hotel</title>
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
            box-sizing: border-box;
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

        #resultados {
            max-width: 900px;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .activo {
            color: #28a745;
            font-weight: bold;
        }

        .inactivo {
            color: #dc3545;
            font-weight: bold;
        }

        .no-resultados {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }

        .debug-info {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin: 20px auto;
            max-width: 900px;
            font-family: monospace;
            font-size: 12px;
            white-space: pre-wrap;
        }
    </style>
</head>

<body>
    <h2>Buscar Hotel</h2>

    <form id="formularioBusqueda">
        <label>Nombre:</label>
        <input type="text" id="nombreBusqueda" name="nombre" required />
        
        <label>Ciudad:</label>
        <input type="text" id="ciudadBusqueda" name="ciudad" required />
        
        <input type="submit" value="Buscar" />
    </form>

    <div id="debugInfo" class="debug-info" style="display: none;"></div>
    <div id="resultados">
        <!-- Aquí se mostrarán los resultados -->
    </div>

    <div id="mensajeBusqueda" class="mensaje" style="display: none;"></div>

    <a href="${pageContext.request.contextPath}/">Volver al menú</a>

    <script>
        function mostrarDebug(info) {
            const debugDiv = document.getElementById('debugInfo');
            debugDiv.textContent = info;
            debugDiv.style.display = 'block';
        }

        function mostrarMensaje(texto, tipo) {
            const div = document.getElementById('mensajeBusqueda');
            div.className = 'mensaje ' + tipo;
            div.innerHTML = texto;
            div.style.display = 'block';
            
            // Ocultar mensaje después de 5 segundos
            setTimeout(() => {
                div.style.display = 'none';
            }, 5000);
        }

        document.getElementById('formularioBusqueda').addEventListener('submit', function (e) {
            e.preventDefault();

            const nombre = document.getElementById('nombreBusqueda').value.trim();
            const ciudad = document.getElementById('ciudadBusqueda').value.trim();

            if (!nombre || !ciudad) {
                mostrarMensaje('Por favor, complete ambos campos.', 'error');
                return;
            }

            // Mostrar mensaje de carga
            document.getElementById('resultados').innerHTML = '<div class="no-resultados">Buscando...</div>';
            document.getElementById('debugInfo').style.display = 'none';

            const contextPath = '<%= request.getContextPath() %>';
            const url = contextPath + '/buscarEspecifico?nombre=' + encodeURIComponent(nombre) + '&ciudad=' + encodeURIComponent(ciudad);

            console.log('URL de la petición:', url);
            mostrarDebug('Enviando petición a: ' + url);

            fetch(url)
                .then(response => {
                    console.log('Response status:', response.status);
                    console.log('Response statusText:', response.statusText);
                    console.log('Response headers:', response.headers);
                    
                    mostrarDebug(`Response status: ${response.status}\nResponse statusText: ${response.statusText}`);
                    
                    if (!response.ok) {
                        // Para error 500, intentamos leer el texto de la respuesta
                        return response.text().then(text => {
                            console.log('Error response body:', text);
                            throw new Error(`Error ${response.status}: ${response.statusText}\nDetalles: ${text}`);
                        });
                    }
                    
                    // Verificar el Content-Type
                    const contentType = response.headers.get('content-type');
                    console.log('Content-Type:', contentType);
                    
                    if (!contentType || !contentType.includes('application/json')) {
                        return response.text().then(text => {
                            console.log('Response as text:', text);
                            throw new Error('El servidor no devolvió JSON válido. Contenido: ' + text);
                        });
                    }
                    
                    return response.json();
                })
                .then(data => {
                    console.log('Datos recibidos:', data);
                    mostrarDebug('Datos JSON recibidos:\n' + JSON.stringify(data, null, 2));
                    mostrarResultados(data);
                })
                .catch(error => {
                    console.error('Error completo:', error);
                    mostrarMensaje('Error al buscar hoteles: ' + error.message, 'error');
                    mostrarDebug('Error: ' + error.message + '\nStack: ' + error.stack);
                    document.getElementById('resultados').innerHTML = '';
                });
        });

        function mostrarResultados(data) {
            const div = document.getElementById("resultados");
            
            console.log('Procesando resultados. Tipo de data:', typeof data);
            console.log('Es array:', Array.isArray(data));
            
            // Verificar si data es un array o un objeto único
            let hoteles = [];
            if (Array.isArray(data)) {
                hoteles = data;
            } else if (data && typeof data === 'object') {
                hoteles = [data]; // Convertir objeto único en array
            }

            console.log('Hoteles a mostrar:', hoteles);

            if (hoteles.length === 0) {
                div.innerHTML = '<div class="no-resultados">No se encontraron hoteles con esos criterios de búsqueda.</div>';
                mostrarMensaje('No se encontraron hoteles.', 'info');
                return;
            }

            let tabla = `
                <table>
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Ciudad</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Email</th>
                            <th>Capacidad</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
            `;

            hoteles.forEach((hotel, index) => {
                console.log(`Hotel ${index}:`, hotel);
                
                tabla += `
                    <tr>
                        <td>${hotel.name || 'N/A'}</td>
                        <td>${hotel.city || 'N/A'}</td>
                        <td>${hotel.address || 'N/A'}</td>
                        <td>${hotel.phone || 'N/A'}</td>
                        <td>${hotel.email || 'N/A'}</td>
                        <td>${hotel.capacity || 'N/A'}</td>
                        <td><span class="${hotel.state ? 'activo' : 'inactivo'}">${hotel.state ? 'Activo' : 'Inactivo'}</span></td>
                    </tr>
                `;
            });

            tabla += `
                    </tbody>
                </table>
            `;
            
            div.innerHTML = tabla;
            mostrarMensaje(`Se encontraron ${hoteles.length} hotel(es).`, 'exito');
        }
    </script>
</body>
</html>