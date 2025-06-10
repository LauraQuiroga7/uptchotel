<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reporte de Reservas - UPTC Hotels</title>
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
      .table {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      }
      .table thead {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
      }
    </style>
  </head>
  <body>
    <div class="container my-5">
      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h4 class="mb-0">
            <i class="fas fa-chart-bar me-2"></i> Generar Reporte de Reservas
          </h4>
        </div>
        <div class="card-body">
          <form id="reporteForm" class="row g-3">
            <div class="col-md-4">
              <label for="fechaInicio" class="form-label"
                >Fecha de Inicio</label
              >
              <input
                type="date"
                class="form-control"
                id="fechaInicio"
                required
              />
            </div>
            <div class="col-md-4">
              <label for="fechaFin" class="form-label">Fecha de Fin</label>
              <input type="date" class="form-control" id="fechaFin" required />
            </div>
            <div class="col-md-4">
              <label for="ciudad" class="form-label">Ciudad (Opcional)</label>
              <input
                type="text"
                class="form-control"
                id="ciudad"
                placeholder="Filtrar por ciudad"
              />
            </div>
            <div class="col-12 text-center">
              <button type="submit" class="btn btn-primary">
                Generar Reporte
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- Tabla de reporte -->
      <div id="tablaReporte" style="display: none">
        <div class="card">
          <div
            class="card-header bg-success text-white d-flex justify-content-between align-items-center"
          >
            <h4 class="mb-0">
              <i class="fas fa-table me-2"></i> Detalle del Reporte
            </h4>
          </div>
          <div class="card-body p-0">
            <div class="table-responsive">
              <table class="table table-hover mb-0">
                <thead>
                  <tr>
                    <th>Fecha de Llegada</th>
                    <th>Nombre del Hotel</th>
                    <th>Registradas</th>
                    <th>Check-in</th>
                    <th>Check-out</th>
                    <th>Total</th>
                  </tr>
                </thead>
                <tbody id="reporteTableBody">
                  <!-- Los datos se cargarán dinámicamente -->
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script>
      document
        .getElementById("reporteForm")
        .addEventListener("submit", function (e) {
          e.preventDefault();
          generarReporte();
        });

      function generarReporte() {
        const fechaInicio = document.getElementById("fechaInicio").value;
        const fechaFin = document.getElementById("fechaFin").value;
        const ciudad = document.getElementById("ciudad").value.trim();

        if (!fechaInicio || !fechaFin) {
          alert("Por favor selecciona las fechas de inicio y fin");
          return;
        }

        if (new Date(fechaFin) < new Date(fechaInicio)) {
          alert("La fecha de fin debe ser posterior a la fecha de inicio");
          return;
        }

        const params = new URLSearchParams();
        params.append("fechaInicio", fechaInicio);
        params.append("fechaFin", fechaFin);
        if (ciudad) {
          params.append("ciudad", ciudad);
        }

        // Corregir la URL para que coincida con el controlador
        fetch("/uptchotels/reservas/reporte?" + params.toString())
          .then((response) => {
            if (!response.ok) {
              throw new Error("Error al generar el reporte");
            }
            return response.json();
          })
          .then((data) => {
            mostrarTabla(data);
          })
          .catch((error) => {
            console.error("Error:", error);
            alert("Error al generar el reporte: " + error.message);
          });
      }

      function mostrarTabla(data) {
        const tabla = document.getElementById("tablaReporte");
        const tbody = document.getElementById("reporteTableBody");
        tbody.innerHTML = "";

        const items = data.items || [];

        if (items.length === 0) {
          tbody.innerHTML = `
                <tr>
                    <td colspan="6" class="text-center py-4">
                        <i class="fas fa-chart-bar fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">No hay datos para el período seleccionado</h5>
                    </td>
                </tr>
            `;
          tabla.style.display = "block";
          return;
        }

        items.forEach((entry) => {
          const total = entry.registradas + entry.checkIn + entry.checkOut;
          const row = document.createElement("tr");
          row.innerHTML = `
                <td>${items.fechaLlegada}</td>
                <td>${entry.nombreHotel}</td>
                <td>${entry.registradas}</td>
                <td>${entry.checkIn}</td>
                <td>${entry.checkOut}</td>
                <td><strong>${total}</strong></td>
            `;
          tbody.appendChild(row);
        });

        tabla.style.display = "block";
      }

      function formatDate(dateString) {
        const date = new Date(dateString + "T00:00:00");
        return date.toLocaleDateString("es-ES");
      }
    </script>
  </body>
</html>
