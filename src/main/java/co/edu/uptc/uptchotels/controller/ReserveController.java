package co.edu.uptc.uptchotels.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.edu.uptc.uptchotels.model.Reserve;
import co.edu.uptc.uptchotels.model.ReserveReport;
import co.edu.uptc.uptchotels.service.ReserveService;

@RestController
@RequestMapping("/uptchotels/reservas")
public class ReserveController {

    @Autowired
    private ReserveService reserveService;

    @PostMapping("/registrarReserva")
    public ResponseEntity<String> registrarReserva(@RequestBody Reserve reserve) {
        try {
            String resultado = reserveService.registrarReserva(reserve);
            if (resultado.startsWith("Error")) {
                return ResponseEntity.badRequest().body(resultado);
            }
            return ResponseEntity.ok(resultado);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al registrar la reserva: " + e.getMessage());
        }
    }

    @PostMapping("/cambiarEstadoFormulario")
public String cambiarEstadoReservaDesdeFormulario(@RequestParam String hotel,
                                                  @RequestParam String ciudad,
                                                  @RequestParam String documento,
                                                  @RequestParam String estado) {
    reserveService.cambiarEstadoReserva(hotel, ciudad, documento, estado);
    return "/"; 
}
    @GetMapping("/listar")
    public List<Reserve> listarReservas() {
        return reserveService.listarReservas();
    }

    @GetMapping("/buscar")
    public List<Reserve> buscarReservas(@RequestParam(required = false) String nombreHotel,
                                       @RequestParam(required = false) String ciudadHotel,
                                       @RequestParam(required = false) String documentoCliente,
                                       @RequestParam(required = false) String estado) {
        return reserveService.buscarReservas(nombreHotel, ciudadHotel, documentoCliente, estado);
    }

    @GetMapping("/reporte")
    public ResponseEntity<ReserveReport> generarReporte(@RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaInicio,
                                                       @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaFin,
                                                       @RequestParam(required = false) String ciudad) {
        try {
            ReserveReport reporte = reserveService.generarReporte(fechaInicio, fechaFin, ciudad);
            return ResponseEntity.ok(reporte);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/verificarDisponibilidad")
    public ResponseEntity<String> verificarDisponibilidad(@RequestParam String nombreHotel,
                                                         @RequestParam String ciudadHotel,
                                                         @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaLlegada,
                                                         @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fechaSalida) {
        try {
            int habitacionesDisponibles = reserveService.verificarDisponibilidad(nombreHotel, ciudadHotel, fechaLlegada, fechaSalida);
            return ResponseEntity.ok("Habitaciones disponibles: " + habitacionesDisponibles);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }
}