package co.edu.uptc.uptchotels.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class HomeController {
//Hoteles
    @GetMapping("/")
    public String home() {
        return "index";  // Spring buscará index.jsp
        
    }
     @GetMapping("/registrarHotel")
    public String registrarHotelPage() {
        return "registrarHotel"; // Va a buscar /WEB-INF/views/registrarHotel.jsp
    }
    @GetMapping("/editarHotel")
    public String editarHotelPage() {
        return "editarHotel"; // Muestra /WEB-INF/views/editarHotel.jsp
    }
    
     @GetMapping("/buscarHotel")
    public String buscarHotelPage() {
        return "buscarHotel"; // Muestra /WEB-INF/views/buscarHotel.jsp
    }
    @GetMapping("/cambiarEstadoHotel")
    public String cambiarEstadoHotelPage() {
        return "cambiarEstadoHotel"; // Muestra /WEB-INF/views/cambiarEstadoHotel.jsp
    }
// Reservas

    @GetMapping("/registrarReserva")
    public String registrarReservaPage() {
        return "registrarReserva"; // Muestra /WEB-INF/views/registrarReserva.jsp
    }

    @GetMapping("/cambiarEstadoReserva")
    public String cambiarEstadoReservaPage() {
        return "cambiarEstadoReserva"; // Muestra /WEB-INF/views/cambiarEstadoReserva.jsp
    }

    @GetMapping("/reporteReservas")
    public String reporteReservasPage() {
        return "reporteReservas"; // Muestra /WEB-INF/views/reporteReservas.jsp
    }

}