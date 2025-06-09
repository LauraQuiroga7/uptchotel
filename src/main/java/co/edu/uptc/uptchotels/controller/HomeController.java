package co.edu.uptc.uptchotels.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.edu.uptc.uptchotels.model.Hotel;
import co.edu.uptc.uptchotels.service.HotelService;

@Controller
public class HomeController {

    @Autowired
    private HotelService hotelService;
//Hoteles

    @GetMapping("/")
    public String home() {
        return "index";  // Spring buscará index.jsp
    }

    @GetMapping("/registrarHotel")
    public String mostrarFormularioRegistro() {
        return "registrarHotel";  // JSP con el formulario para registrar hotel
    }

    @PostMapping("/registrarHotel")
    public String registrarHotelDesdeFormulario(@RequestParam String nombre,
            @RequestParam String ciudad,
            @RequestParam String direccion,
            @RequestParam String telefono,
            @RequestParam String email,
            @RequestParam int capacidad,
            @RequestParam boolean activo,
            Model model) {
                  boolean verification = hotelService.registeredHotelCity(nombre, ciudad);

    if (verification) {
        model.addAttribute("error", "Ya existe un hotel con ese nombre en la ciudad especificada.");
        return "registrarHotel"; // Vuelve al formulario con mensaje
    }
        Hotel h = new Hotel();
        h.setName(nombre);
        h.setCity(ciudad);
        h.setAddress(direccion);
        h.setPhone(telefono);
        h.setEmail(email);
        h.setCapacity(capacidad);
        h.setState(activo);

        hotelService.registrarHotel(h);
        return "redirect:/";
    }

    @GetMapping("/editarHotel")
    public String editarHotelPage() {
        return "editarHotel"; // Muestra /WEB-INF/views/editarHotel.jsp
    }

    @GetMapping("/buscarHotel")
    public String buscarHotelPage() {
        return "buscarHotel"; // Muestra /WEB-INF/views/buscarHotel.jsp
    }
    @GetMapping("/searchHotel")
public String buscarHoteles(
        @RequestParam(required = false) String nombre,
        @RequestParam(required = false) String ciudad,
        Model model) {

    List<Hotel> resultados = hotelService.searchCityName(nombre, ciudad);
    model.addAttribute("listaHoteles", resultados);
    return "listarHoteles";
}


    @GetMapping("/cambiarEstadoHotel")
    public String cambiarEstadoHotelPage() {
        return "cambiarEstadoHotel"; // Muestra /WEB-INF/views/cambiarEstadoHotel.jsp
    }

    @GetMapping("/listarHoteles")
    public String listarHoteles(Model model) {
        List<Hotel> lista = hotelService.listarHoteles();
        model.addAttribute("listaHoteles", lista);
        return "listarHoteles"; 
    }

    public String getMethodName(@RequestParam String param) {
        return new String();
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
