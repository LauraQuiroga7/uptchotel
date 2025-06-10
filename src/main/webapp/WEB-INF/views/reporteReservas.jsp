<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Reservas - UPTC Hotels</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
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
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
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
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .table thead {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .chart-container {
            position: relative;
            height: 400px;
            margin-bottom: 2rem;
        }
        .stats-card {
            text-align: center;
            padding: 1.5rem;
            border-radius: 15px;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
        }
        .stats-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
        }
        .stats-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="/uptchotels/">
                <i class="fas fa-hotel me-2"></i>UPTC Hotels
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/uptchotels/"><i class="fas fa-home me-1"></i>Inicio</a>
                <a class="nav-link" href="/uptchotels/reservas/registrar"><i class="fas fa-plus me-1"></i>Nueva Reserva</a>
                <a class="nav-link" href="/uptchotels/reservas/gestionar"><i class="fas fa-list me-1"></i>Gestionar</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <!-- Filtros para generar reporte -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Generar Reporte de Reservas</h4>
                    </div>
                    <div class="card-body">
                        <form id="reporteForm" class="row g-3">
                            <div class="col-md-4">
                                <label for="fechaInicio" class="form-label">Fecha de Inicio</label>
                                <input type="date" class="form-control" id="fechaInicio" required>
                            </div>
                            <div class="col-md-4">
                                <label for="fechaFin" class="form-label">Fecha de Fin</label>
                                <input type="date" class="form-control" id="fechaFin" required>
                            </div>
                            <div class="col-md-4">
                                <label for="ciudad" class="form-label">Ciudad (Opcional)</label>
                                <input type="text" class="form-control" id="ciudad" placeholder="Filtrar por ciudad">
                            </div>
                            <div class="col-12 text-center">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="fas fa-chart-line me-1"></i>Generar Reporte
                                </button>
                                <button type="button" class="btn btn-secondary" onclick="limpiarReporte()">
                                    <i class="fas fa-eraser me-1"></i>Limpiar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Estadísticas resumidas -->
        <div id="estadisticas" class="row mb-4" style="display: none;">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number" id="totalReservadas">0</div>
                    <div class="stats-label">Reservadas</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number" id="totalOcupadas">0</div>
                    <div class="stats-label">Ocupadas</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number" id="totalLiberadas">0</div>
                    <div class="stats-label">Liberadas</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number" id="totalHoteles">0</div>
                    <div class="stats-label">Hoteles</div>
                </div>
            </div>
        </div>

        <!-- Gráfico -->
        <div id="graficoContainer" class="row mb-4" style="display: none;">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="fas fa-chart-area me-2"></i>Gráfico de Ocupación</h5>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="ocupacionChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tabla de reporte -->
        <div id="tablaReporte" class="row" style="display: none;">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                        <h4 class="mb-0"><i class="fas fa-table me-2"></i>Detalle del Reporte</h4>
                        <button class="btn btn-light btn-sm" onclick="exportarReporte()">
                            <i class="fas fa-download me-1"></i>Exportar
                        </button>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Hotel</th>
                                        <th>Reservadas</th>
                                        <th>Ocupadas</th>
                                        <th>Liberadas</th>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <script>
        let reporteData = null;
        let chart = null;

        document.addEventListener('DOMContentLoaded', function() {
            // Configurar fechas por defecto
            const today = new Date();
            const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            
            document.getElementById('fechaInicio').value = firstDay.toISOString().split('T')[0];
            document.getElementById('fechaFin').value = today.toISOString().split('T')[0];
            
            document.getElementById('fechaInicio').addEventListener('change', function() {
                document.getElementById('fechaFin').min = this.value;
            });
        });

        document.getElementById('reporteForm').addEventListener('submit', function(e) {
            e.preventDefault();
            generarReporte();
        });

        function generarReporte() {
            const fechaInicio = document.getElementById('fechaInicio').value;
            const fechaFin = document.getElementById('fechaFin').value;
            const ciudad = document.getElementById('ciudad').value.trim();
            
            if (!fechaInicio || !fechaFin) {
                alert('Por favor selecciona las fechas de inicio y fin');
                return;
            }
            
            if (new Date(fechaFin) < new Date(fechaInicio)) {
                alert('La fecha de fin debe ser posterior a la fecha de inicio');
                return;
            }
            
            const params = new URLSearchParams();
            params.append('fechaInicio', fechaInicio);
            params.append('fechaFin', fechaFin);
            if (ciudad) {
                params.append('ciudad', ciudad);
            }
            
            fetch(`/uptchotels/reservas/reporte?${params.toString()}`)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Error al generar el reporte');
                    }
                    return response.json();
                })
                .then(data => {
                    reporteData = data;
                    mostrarReporte(data);
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error al generar el reporte: ' + error.message);
                });
        }

        function mostrarReporte(data) {
            mostrarEstadisticas(data);
            mostrarTabla(data);
            mostrarGrafico(data);
            
            // Mostrar secciones
            document.getElementById('estadisticas').style.display = 'flex';
            document.getElementById('tablaReporte').style.display = 'block';
            document.getElementById('graficoContainer').style.display = 'block';
        }

        function mostrarEstadisticas(data) {
            const entradas = data.entradas || [];
            
            const totalReservadas = entradas.reduce((sum, entry) => sum + entry.habitacionesReservadas, 0);
            const totalOcupadas = entradas.reduce((sum, entry) => sum + entry.habitacionesOcupadas, 0);
            const totalLiberadas = entradas.reduce((sum, entry) => sum + entry.habitacionesLiberadas, 0);
            const hotelesUnicos = [...new Set(entradas.map(entry => entry.nombreHotel))].length;
            
            document.getElementById('totalReservadas').textContent = totalReservadas;
            document.getElementById('totalOcupadas').textContent = totalOcupadas;
            document.getElementById('totalLiberadas').textContent = totalLiberadas;
            document.getElementById('totalHoteles').textContent = hotelesUnicos;
        }

        function mostrarTabla(data) {
            const tbody = document.getElementById('reporteTableBody');
            tbody.innerHTML = '';
            
            if (!data.entradas || data.entradas.length === 0) {
                tbody.innerHTML = `
                    <tr>
                        <td colspan="6" class="text-center py-4">
                            <i class="fas fa-chart-bar fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">No hay datos para el período seleccionado</h5>
                        </td>
                    </tr>
                `;
                return;
            }
            
            data.entradas.forEach(entry => {
                const total = entry.habitacionesReservadas + entry.habitacionesOcupadas + entry.habitacionesLiberadas;
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${formatDate(entry.fecha)}</td>
                    <td><strong>${entry.nombreHotel}</strong></td>
                    <td><span class="badge bg-primary">${entry.habitacionesReservadas}</span></td>
                    <td><span class="badge bg-success">${entry.habitacionesOcupadas}</span></td>
                    <td><span class="badge bg-warning">${entry.habitacionesLiberadas}</span></td>
                    <td><strong>${total}</strong></td>
                `;
                tbody.appendChild(row);
            });
        }

        function mostrarGrafico(data) {
            const ctx = document.getElementById('ocupacionChart').getContext('2d');
            
            // Destruir gráfico anterior si existe
            if (chart) {
                chart.destroy();
            }
            
            if (!data.entradas || data.entradas.length === 0) {
                return;
            }
            
            // Agrupar datos por fecha
            const datosPorFecha = {};
            data.entradas.forEach(entry => {
                const fecha = entry.fecha;
                if (!datosPorFecha[fecha]) {
                    datosPorFecha[fecha] = {
                        reservadas: 0,
                        ocupadas: 0,
                        liberadas: 0
                    };
                }
                datosPorFecha[fecha].reservadas += entry.habitacionesReservadas;
                datosPorFecha[fecha].ocupadas += entry.habitacionesOcupadas;
                datosPorFecha[fecha].liberadas += entry.habitacionesLiberadas;
            });
            
            const fechas = Object.keys(datosPorFecha).sort();
            const reservadas = fechas.map(fecha => datosPorFecha[fecha].reservadas);
            const ocupadas = fechas.map(fecha => datosPorFecha[fecha].ocupadas);
            const liberadas = fechas.map(fecha => datosPorFecha[fecha].liberadas);
            
            chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: fechas.map(fecha => formatDate(fecha)),
                    datasets: [
                        {
                            label: 'Reservadas',
                            data: reservadas,
                            borderColor: '#007bff',
                            backgroundColor: 'rgba(0, 123, 255, 0.1)',
                            fill: true
                        },
                        {
                            label: 'Ocupadas',
                            data: ocupadas,
                            borderColor: '#28a745',
                            backgroundColor: 'rgba(40, 167, 69, 0.1)',
                            fill: true
                        },
                        {
                            label: 'Liberadas',
                            data: liberadas,
                            borderColor: '#ffc107',
                            backgroundColor: 'rgba(255, 193, 7, 0.1)',
                            fill: true
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Evolución de Ocupación de Habitaciones'
                        },
                        legend: {
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Número de Habitaciones'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Fecha'
                            }
                        }
                    }
                }
            });
        }

        function limpiarReporte() {
            document.getElementById('reporteForm').reset();
            document.getElementById('estadisticas').style.display = 'none';
            document.getElementById('tablaReporte').style.display = 'none';
            document.getElementById('graficoContainer').style.display = 'none';
            
            if (chart) {
                chart.destroy();
                chart = null;
            }
            
            reporteData = null;
            
            // Restaurar fechas por defecto
            const today = new Date();
            const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
            document.getElementById('fechaInicio').value = firstDay.toISOString().split('T')[0];
            document.getElementById('fechaFin').value = today.toISOString().split('T')[0];
        }

        function exportarReporte() {
            if (!reporteData || !reporteData.entradas) {
                alert('No hay datos para exportar');
                return;
            }
            
            let csv = 'Fecha,Hotel,Reservadas,Ocupadas,Liberadas,Total\n';
            
            reporteData.entradas.forEach(entry => {
                const total = entry.habitacionesReservadas + entry.habitacionesOcupadas + entry.habitacionesLiberadas;
                csv += `${entry.fecha},"${entry.nombreHotel}",${entry.habitacionesReservadas},${entry.habitacionesOcupadas},${entry.habitacionesLiberadas},${total}\n`;
            });
            
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', `reporte_reservas_${new Date().toISOString().split('T')[0]}.csv`);
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function formatDate(dateString) {
            const date = new Date(dateString + 'T00:00:00');
            return date.toLocaleDateString('es-ES');
        }
    </script>
</body>
</html>