package co.edu.uptc.uptchotels.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import co.edu.uptc.uptchotels.service.HotelService;

@Controller
public class HomeController {
//Hotele
 HotelService hotelService;
    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/registrarHotel")
    public String mostrarFormularioRegistro() {
        return "registrarHotel";
    }

    @GetMapping("/editarHotel")
    public String editarHotelPage() {
        return "editarHotel";
    }

    @GetMapping("/eliminarHotel")
    public String eliminarHotelPage() {
        return "eliminarHotel";
    }

    @GetMapping("/buscarHotel")
    public String buscarHotelPage() {
        return "buscarHotel";
    }

    @GetMapping("/cambiarEstadoHotel")
    public String cambiarEstadoHotelPage() {
        return "cambiarEstadoHotel";
    }

    @GetMapping("/listarHoteles")
    public String listarHoteles() {
      
        return "listarHoteles"; 
    }

//Reservas
    @GetMapping("/registrarReserva")
    public String registrarReservaPage() {
        return "registrarReserva";
    }

    @GetMapping("/cambiarEstadoReserva")
    public String cambiarEstadoReservaPage() {
        return "estadoReserva";
    }

    @GetMapping("/reporteReservas")
    public String reporteReservasPage() {
        return "reporteReservas";
    }
}

