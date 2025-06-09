package co.edu.uptc.uptchotels.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uptc.uptchotels.model.Hotel;
import co.edu.uptc.uptchotels.model.Reserve;
import co.edu.uptc.uptchotels.model.ReserveReport;
import co.edu.uptc.uptchotels.model.ReserveReportEntry;

@Service
public class ReserveService {

    @Autowired
    private HotelService hotelService;

    private List<Reserve> reservas = new ArrayList<>();

    public String registrarReserva(Reserve reserve) {
        // Verificar que el hotel existe
        Hotel hotel = hotelService.buscarHotelEspecifico(reserve.getNameHotel(), reserve.getCityHotel());
        if (hotel == null) {
            return "Error: Hotel no encontrado";
        }

        // Verificar que el hotel esté activo
        if (!hotel.isState()) {
            return "Error: El hotel no está activo";
        }

        // Verificar fechas válidas
        if (reserve.getEntryDate().isAfter(reserve.getDepartureDate()) || 
            reserve.getEntryDate().isBefore(LocalDate.now())) {
            return "Error: Fechas de reserva inválidas";
        }

        // Verificar disponibilidad de habitaciones
        int habitacionesDisponibles = verificarDisponibilidad(
            reserve.getNameHotel(), 
            reserve.getCityHotel(), 
            reserve.getEntryDate(), 
            reserve.getDepartureDate()
        );

        if (habitacionesDisponibles <= 0) {
            return "Error: No hay habitaciones disponibles para las fechas seleccionadas";
        }

        // Verificar que no existe una reserva activa para el mismo cliente en el mismo hotel
        boolean reservaExistente = reservas.stream()
            .anyMatch(r -> r.getNameHotel().equalsIgnoreCase(reserve.getNameHotel()) &&
                          r.getCityHotel().equalsIgnoreCase(reserve.getCityHotel()) &&
                          r.getDocumentCustomer().equals(reserve.getDocumentCustomer()) &&
                          ("REGISTRADA".equals(r.getState()) || "CHECK-IN".equals(r.getState())));

        if (reservaExistente) {
            return "Error: Ya existe una reserva activa para este cliente en este hotel";
        }

        // Establecer estado inicial
        reserve.setState("REGISTRADA");
        
        // Registrar la reserva
        reservas.add(reserve);
        
        return "Reserva registrada exitosamente";
    }

    public String cambiarEstadoReserva(String nombreHotel, String ciudadHotel, String documentoCliente, String nuevoEstado) {
        Reserve reserva = buscarReservaEspecifica(nombreHotel, ciudadHotel, documentoCliente);
        
        if (reserva == null) {
            return "Error: Reserva no encontrada";
        }

        String estadoActual = reserva.getState();
        
        // Validar transiciones de estado permitidas
        if (!esTransicionValida(estadoActual, nuevoEstado)) {
            return "Error: Transición de estado no permitida de " + estadoActual + " a " + nuevoEstado;
        }

        reserva.setState(nuevoEstado);
        return "Estado de reserva cambiado exitosamente a " + nuevoEstado;
    }

    private boolean esTransicionValida(String estadoActual, String nuevoEstado) {
        switch (estadoActual) {
            case "REGISTRADA":
                return "CANCELADA".equals(nuevoEstado) || "CHECK-IN".equals(nuevoEstado);
            case "CHECK-IN":
                return "CHECK-OUT".equals(nuevoEstado);
            case "CHECK-OUT":
                return "FINALIZADA".equals(nuevoEstado);
            case "CANCELADA":
            case "FINALIZADA":
                return false; // Estados finales, no se pueden cambiar
            default:
                return false;
        }
    }

    public int verificarDisponibilidad(String nombreHotel, String ciudadHotel, LocalDate fechaLlegada, LocalDate fechaSalida) {
        Hotel hotel = hotelService.buscarHotelEspecifico(nombreHotel, ciudadHotel);
        if (hotel == null) {
            return 0;
        }

        // Contar reservas que se superponen con las fechas solicitadas
        long reservasSuperpuestas = reservas.stream()
            .filter(r -> r.getNameHotel().equalsIgnoreCase(nombreHotel) &&
                        r.getCityHotel().equalsIgnoreCase(ciudadHotel) &&
                        ("REGISTRADA".equals(r.getState()) || "CHECK-IN".equals(r.getState())) &&
                        haySupersposicion(r.getEntryDate(), r.getDepartureDate(), fechaLlegada, fechaSalida))
            .count();

        return hotel.getCapacity() - (int) reservasSuperpuestas;
    }

    private boolean haySupersposicion(LocalDate inicio1, LocalDate fin1, LocalDate inicio2, LocalDate fin2) {
        return !(fin1.isBefore(inicio2) || inicio1.isAfter(fin2));
    }

    public List<Reserve> listarReservas() {
        return new ArrayList<>(reservas);
    }

    public List<Reserve> buscarReservas(String nombreHotel, String ciudadHotel, String documentoCliente, String estado) {
        return reservas.stream()
            .filter(r -> (nombreHotel == null || r.getNameHotel().toLowerCase().contains(nombreHotel.toLowerCase())) &&
                        (ciudadHotel == null || r.getCityHotel().toLowerCase().contains(ciudadHotel.toLowerCase())) &&
                        (documentoCliente == null || r.getDocumentCustomer().contains(documentoCliente)) &&
                        (estado == null || r.getState().equalsIgnoreCase(estado)))
            .collect(Collectors.toList());
    }

    private Reserve buscarReservaEspecifica(String nombreHotel, String ciudadHotel, String documentoCliente) {
        return reservas.stream()
            .filter(r -> r.getNameHotel().equalsIgnoreCase(nombreHotel) &&
                        r.getCityHotel().equalsIgnoreCase(ciudadHotel) &&
                        r.getDocumentCustomer().equals(documentoCliente) &&
                        ("REGISTRADA".equals(r.getState()) || "CHECK-IN".equals(r.getState())))
            .findFirst()
            .orElse(null);
    }

    public ReserveReport generarReporte(LocalDate fechaInicio, LocalDate fechaFin, String ciudad) {
        List<Reserve> reservasFiltradas = reservas.stream()
            .filter(r -> (ciudad == null || r.getCityHotel().equalsIgnoreCase(ciudad)) &&
                        !r.getEntryDate().isAfter(fechaFin) &&
                        !r.getDepartureDate().isBefore(fechaInicio))
            .collect(Collectors.toList());

        Map<String, Map<LocalDate, ReserveReportEntry>> reporteMap = new HashMap<>();

        // Procesar cada día en el rango
        LocalDate fechaActual = fechaInicio;
        while (!fechaActual.isAfter(fechaFin)) {
            final LocalDate fecha = fechaActual;
            
            // Agrupar por hotel
            Map<String, List<Reserve>> reservasPorHotel = reservasFiltradas.stream()
                .collect(Collectors.groupingBy(r -> r.getNameHotel() + " - " + r.getCityHotel()));

            for (Map.Entry<String, List<Reserve>> entry : reservasPorHotel.entrySet()) {
                String hotelKey = entry.getKey();
                List<Reserve> reservasHotel = entry.getValue();

                reporteMap.putIfAbsent(hotelKey, new HashMap<>());

                // Contar reservas para esta fecha
                int registradas = (int) reservasHotel.stream()
                    .filter(r -> "REGISTRADA".equals(r.getState()) &&
                                !r.getEntryDate().isAfter(fecha) &&
                                !r.getDepartureDate().isBefore(fecha))
                    .count();

                int checkIn = (int) reservasHotel.stream()
                    .filter(r -> "CHECK-IN".equals(r.getState()) &&
                                !r.getEntryDate().isAfter(fecha) &&
                                !r.getDepartureDate().isBefore(fecha))
                    .count();

                int checkOut = (int) reservasHotel.stream()
                    .filter(r -> "CHECK-OUT".equals(r.getState()) &&
                                r.getDepartureDate().equals(fecha))
                    .count();

                ReserveReportEntry reportEntry = new ReserveReportEntry(
                    fecha, hotelKey.split(" - ")[0], registradas, checkIn, checkOut
                );

                reporteMap.get(hotelKey).put(fecha, reportEntry);
            }

            fechaActual = fechaActual.plusDays(1);
        }

        // Convertir a lista
        List<ReserveReportEntry> reporteEntries = new ArrayList<>();
        for (Map<LocalDate, ReserveReportEntry> hotelReport : reporteMap.values()) {
            reporteEntries.addAll(hotelReport.values());
        }

        return new ReserveReport(fechaInicio, fechaFin, ciudad, reporteEntries);
    }
}