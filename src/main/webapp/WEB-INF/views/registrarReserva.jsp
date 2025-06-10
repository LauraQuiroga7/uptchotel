<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registrar Reserva - UPTC Hotels</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      .form-container {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 2rem 0;
      }
      .card {
        border: none;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      }
      .card-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 15px 15px 0 0 !important;
        padding: 1.5rem;
      }
      .form-control {
        border-radius: 10px;
        border: 2px solid #e9ecef;
        padding: 0.75rem 1rem;
        transition: all 0.3s ease;
      }
      .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      }
      .btn-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        border-radius: 10px;
        padding: 0.75rem 2rem;
        font-weight: 600;
        transition: all 0.3s ease;
      }
      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      }
      .btn-secondary {
        border-radius: 10px;
        padding: 0.75rem 2rem;
        font-weight: 600;
      }
      .alert {
        border-radius: 10px;
        border: none;
      }
      .form-label {
        font-weight: 600;
        color: #495057;
        margin-bottom: 0.5rem;
      }
      .required {
        color: #dc3545;
      }
    </style>
  </head>
  <body>
    <div class="form-container">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-8 col-md-10">
            <div class="card">
              <div class="card-header text-center">
                <h2><i class="fas fa-bed me-2"></i>Registrar Nueva Reserva</h2>
                <p class="mb-0">
                  Complete todos los campos para registrar la reserva
                </p>
              </div>
              <div class="card-body p-4">
                <!-- Mensaje de respuesta -->
                <div
                  id="mensaje"
                  class="alert"
                  style="display: none"
                  role="alert"
                ></div>

                <form id="reservaForm">
                  <div class="row">
                    <!-- Id reserva -->
                    <div class="col-md-12 mb-3">
                      <label for="id" class="form-label">
                        <i class="fas fa-id-card me-1"></i>ID de la Reserva
                        <span class="required">*</span>
                      </label>
                      <input
                        type="text"
                        class="form-control"
                        id="id"
                        name="id"
                        required
                      />
                    </div>
                    <!-- Información del Hotel -->
                    <div class="col-md-6 mb-3">
                      <label for="nameHotel" class="form-label">
                        <i class="fas fa-building me-1"></i>Nombre del Hotel
                        <span class="required">*</span>
                      </label>
                      <input
                        type="text"
                        class="form-control"
                        id="nameHotel"
                        name="nameHotel"
                        required
                      />
                    </div>

                    <div class="col-md-6 mb-3">
                      <label for="cityHotel" class="form-label">
                        <i class="fas fa-map-marker-alt me-1"></i>Ciudad del
                        Hotel <span class="required">*</span>
                      </label>
                      <input
                        type="text"
                        class="form-control"
                        id="cityHotel"
                        name="cityHotel"
                        required
                      />
                    </div>
                  </div>

                  <div class="row">
                    <!-- Información del Cliente -->
                    <div class="col-md-6 mb-3">
                      <label for="nameCustomer" class="form-label">
                        <i class="fas fa-user me-1"></i>Nombre del Cliente
                        <span class="required">*</span>
                      </label>
                      <input
                        type="text"
                        class="form-control"
                        id="nameCustomer"
                        name="nameCustomer"
                        required
                      />
                    </div>

                    <div class="col-md-6 mb-3">
                      <label for="documentCustomer" class="form-label">
                        <i class="fas fa-id-card me-1"></i>Documento de
                        Identidad <span class="required">*</span>
                      </label>
                      <input
                        type="text"
                        class="form-control"
                        id="documentCustomer"
                        name="documentCustomer"
                        required
                      />
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-md-12 mb-3">
                      <label for="emailCustomer" class="form-label">
                        <i class="fas fa-envelope me-1"></i>Email del Cliente
                        <span class="required">*</span>
                      </label>
                      <input
                        type="email"
                        class="form-control"
                        id="emailCustomer"
                        name="emailCustomer"
                        required
                      />
                    </div>
                  </div>

                  <div class="row">
                    <!-- Fechas -->
                    <div class="col-md-6 mb-3">
                      <label for="entryDate" class="form-label">
                        <i class="fas fa-calendar-check me-1"></i>Fecha de
                        Llegada <span class="required">*</span>
                      </label>
                      <input
                        type="date"
                        class="form-control"
                        id="entryDate"
                        name="entryDate"
                        required
                      />
                    </div>

                    <div class="col-md-6 mb-3">
                      <label for="departureDate" class="form-label">
                        <i class="fas fa-calendar-times me-1"></i>Fecha de
                        Salida <span class="required">*</span>
                      </label>
                      <input
                        type="date"
                        class="form-control"
                        id="departureDate"
                        name="departureDate"
                        required
                      />
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-md-12 mb-4">
                      <label for="state" class="form-label">
                        <i class="fas fa-flag me-1"></i>Estado de la Reserva
                      </label>
                      <select class="form-control" id="state" name="state">
                        <option value="REGISTRADA" selected>Registrada</option>
                      </select>
                    </div>
                  </div>

                  <div class="text-center">
                    <button type="submit" class="btn btn-primary me-3">
                      <i class="fas fa-save me-2"></i>Registrar Reserva
                    </button>
                    <button type="reset" class="btn btn-secondary me-3">
                      <i class="fas fa-undo me-2"></i>Limpiar Formulario
                    </button>
                    <a href="/uptchotels/" class="btn btn-outline-primary">
                      <i class="fas fa-home me-2"></i>Volver al Inicio
                    </a>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        // Establecer fecha mínima como hoy
        const today = new Date().toISOString().split("T")[0];
        document.getElementById("entryDate").setAttribute("min", today);
        document.getElementById("departureDate").setAttribute("min", today);

        // Validar que la fecha de salida sea posterior a la de llegada
        document
          .getElementById("entryDate")
          .addEventListener("change", function () {
            const entryDate = this.value;
            document
              .getElementById("departureDate")
              .setAttribute("min", entryDate);

            // Si la fecha de salida es anterior, resetearla
            const departureDate =
              document.getElementById("departureDate").value;
            if (departureDate && departureDate <= entryDate) {
              document.getElementById("departureDate").value = "";
            }
          });
      });

      document
        .getElementById("reservaForm")
        .addEventListener("submit", function (e) {
          e.preventDefault();

          // Validaciones adicionales
          const entryDate = new Date(
            document.getElementById("entryDate").value
          );
          const departureDate = new Date(
            document.getElementById("departureDate").value
          );

          if (departureDate <= entryDate) {
            mostrarMensaje(
              "La fecha de salida debe ser posterior a la fecha de llegada.",
              "danger"
            );
            return;
          }

          // Crear objeto de reserva
          const reservaData = {
            nameHotel: document.getElementById("nameHotel").value,
            cityHotel: document.getElementById("cityHotel").value,
            nameCustomer: document.getElementById("nameCustomer").value,
            documentCustomer: document.getElementById("documentCustomer").value,
            emailCustomer: document.getElementById("emailCustomer").value,
            entryDate: document.getElementById("entryDate").value,
            departureDate: document.getElementById("departureDate").value,
            state: document.getElementById("state").value,
          };

          // Enviar datos al servidor
          fetch("/uptchotels/uptchotels/reservas/registrarReserva", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(reservaData),
          })
            .then((response) => {
              if (!response.ok) {
                return response.text().then((text) => Promise.reject(text));
              }
              return response.text();
            })
            .then((data) => {
              mostrarMensaje(data, "success");

              // Esperar 2 segundos y redirigir al index
              setTimeout(() => {
                window.location.href = "/uptchotels/";
              }, 2000);
            })
            .catch((error) => {
              console.error("Error:", error);
              mostrarMensaje(
                error || "Error al registrar la reserva",
                "danger"
              );
            });
        });

      function mostrarMensaje(mensaje, tipo) {
        const mensajeDiv = document.getElementById("mensaje");
        mensajeDiv.className = `alert alert-${tipo}`;

        if (tipo === "success") {
          mensajeDiv.innerHTML = `
                    <i class="fas fa-check-circle me-2"></i>
                    ${mensaje}
                    <br><small class="mt-2 d-block">Serás redirigido al inicio en 2 segundos...</small>
                `;
        } else {
          mensajeDiv.innerHTML = `
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    ${mensaje}
                `;
        }

        mensajeDiv.style.display = "block";

        // Scroll hacia el mensaje
        mensajeDiv.scrollIntoView({ behavior: "smooth", block: "center" });
      }
    </script>
  </body>
</html>
