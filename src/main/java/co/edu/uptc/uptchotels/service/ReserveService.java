package co.edu.uptc.uptchotels.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.edu.uptc.uptchotels.model.Hotel;
import co.edu.uptc.uptchotels.model.Reserve;
import co.edu.uptc.uptchotels.model.ReserveReporltem;
import co.edu.uptc.uptchotels.model.ReserveReport;

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
        System.out.println("Registro exitoso");
        return "Reserva registrada exitosamente";
    }

    public void cambiarEstadoReserva(int idReserva, String nuevoEstado) {
        Reserve reserva = reservas.stream()
                .filter(r -> r.getId() == idReserva)
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("Reserva no encontrada."));

        String estadoActual = reserva.getState();

        // Normalizar los estados - convertir todo a mayúsculas para comparación
        String estadoActualNormalizado = estadoActual.toUpperCase();
        String nuevoEstadoNormalizado = nuevoEstado.toUpperCase();

        // Validar transiciones permitidas según el enunciado
        boolean cambioValido = false;

        if (estadoActualNormalizado.equals("REGISTRADA")) {
            if (nuevoEstadoNormalizado.equals("CANCELADA") || nuevoEstadoNormalizado.equals("CHECK-IN")) {
                cambioValido = true;
            }
        } else if (estadoActualNormalizado.equals("CHECK-IN")) {
            if (nuevoEstadoNormalizado.equals("CHECK-OUT")) {
                cambioValido = true;
            }
        }

        if (!cambioValido) {
            throw new IllegalArgumentException("Transición de estado no permitida. Estado actual: " + estadoActual + ", Nuevo estado: " + nuevoEstado);
        }

        reserva.setState(nuevoEstadoNormalizado);
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
                .filter(r -> r.getEntryDate() != null &&
                             !r.getEntryDate().isBefore(fechaInicio) &&
                             !r.getEntryDate().isAfter(fechaFin))
                .filter(r -> ciudad == null || ciudad.isEmpty() ||
                             r.getCityHotel().equalsIgnoreCase(ciudad))
                .collect(Collectors.toList());

        Map<String, ReserveReporltem> mapaReporte = new HashMap<>();

        for (Reserve r : reservasFiltradas) {
            String key = r.getEntryDate() + "|" + r.getNameHotel();

            ReserveReporltem item = mapaReporte.getOrDefault(key, new ReserveReporltem(r.getEntryDate(), r.getNameHotel()));

            // Corregir los nombres de estados para que coincidan con los normalizados
            String estado = r.getState().toUpperCase();
            switch (estado) {
                case "REGISTRADA":
                    item.setRegistradas(item.getRegistradas() + 1);
                    break;
                case "CHECK-IN":
                    item.setCheckIn(item.getCheckIn() + 1);
                    break;
                case "CHECK-OUT":
                    item.setCheckOut(item.getCheckOut() + 1);
                    break;
            }

            mapaReporte.put(key, item);
        }

        List<ReserveReporltem> listaItems = new ArrayList<>(mapaReporte.values());
        listaItems.sort(Comparator.comparing(ReserveReporltem::getFechaLlegada)
                                  .thenComparing(ReserveReporltem::getNombreHotel));

        return new ReserveReport(listaItems);
    }
}