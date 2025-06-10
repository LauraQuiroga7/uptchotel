<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Cambiar Estado de Reserva - UPTC Hotels</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .card {
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        border: none;
        backdrop-filter: blur(10px);
        background: rgba(255, 255, 255, 0.95);
      }
      .btn-primary {
        background: linear-gradient(45deg, #667eea, #764ba2);
        border: none;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
      }
      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
      }
      .form-control {
        border-radius: 10px;
        border: 2px solid #e9ecef;
        padding: 8px 12px;
        transition: all 0.3s ease;
      }
      .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      }
    </style>
  </head>
  <body>
    <div class="container my-5">
      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h4 class="mb-0">
            <i class="fas fa-exchange-alt me-2"></i> Cambiar Estado de Reserva
          </h4>
        </div>
        <div class="card-body">
          <form id="cambiarEstadoForm" class="row g-3">
            <div class="col-md-6">
              <label for="idReserva" class="form-label">ID de la Reserva</label>
              <input
                type="number"
                class="form-control"
                id="idReserva"
                required
              />
            </div>
            <div class="col-md-6">
              <label for="nuevoEstado" class="form-label">Nuevo Estado</label>
              <select class="form-control" id="nuevoEstado" required>
                <option value="">Seleccione...</option>
                <option value="CANCELADA">Cancelada</option>
                <option value="CHECK-IN">Check-in</option>
                <option value="CHECK-OUT">Check-out</option>
              </select>
            </div>
            <div class="col-12 text-center">
              <button type="submit" class="btn btn-primary">
                Cambiar Estado
              </button>
            </div>
          </form>
          <div id="resultado" class="mt-3 text-center fw-bold"></div>
        </div>
      </div>
    </div>

    <script>
      document
        .getElementById("cambiarEstadoForm")
        .addEventListener("submit", function (e) {
          e.preventDefault();

          const idReserva = document.getElementById("idReserva").value;
          const nuevoEstado = document.getElementById("nuevoEstado").value;

          if (!idReserva || !nuevoEstado) {
            alert("Por favor complete todos los campos.");
            return;
          }

          fetch(
            "http://localhost:8080/uptchotels/reservas/cambiarEstado?idReserva=" +
              encodeURIComponent(idReserva) +
              "&nuevoEstado=" +
              encodeURIComponent(nuevoEstado),
            {
              method: "PUT",
            }
          )
            .then((response) => {
              if (!response.ok) {
                return response.text().then((text) => {
                  throw new Error(text);
                });
              }
              return response.text();
            })
            .then((data) => {
              document.getElementById("resultado").innerHTML =
                '<span class="text-success">' + data + "</span>";
              // Limpiar el formulario después del éxito
              document.getElementById("cambiarEstadoForm").reset();
            })
            .catch((error) => {
              document.getElementById("resultado").innerHTML =
                '<span class="text-danger">Error: ' + error.message + "</span>";
            });
        });
    </script>
  </body>
</html>
