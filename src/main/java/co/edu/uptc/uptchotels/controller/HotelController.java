package co.edu.uptc.uptchotels.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.edu.uptc.uptchotels.model.Hotel;
import co.edu.uptc.uptchotels.service.HotelService;

@RestController
@RequestMapping("/uptchotels")
public class HotelController {

    @Autowired
    private HotelService hotelService;

    @PostMapping("/registrar")
    public void registrarHotel(@RequestBody Hotel hotel) {
        hotelService.registrarHotel(hotel);
    }

    @GetMapping("/api/hotel/buscar")
   public String buscarHoteles(
        @RequestParam(required = false) String nombre,
        @RequestParam(required = false) String ciudad,
        Model model) {

    List<Hotel> resultados = hotelService.searchCityName(nombre, ciudad);
    model.addAttribute("listarHoteles", resultados);
    return "listarHoteles"; // JSP que muestra la tabla
}
    @GetMapping("/listarHoteles")
    public List<Hotel> listarHoteles() {
        return hotelService.listarHoteles();
    }

    @PutMapping("/editar")
    public void editarHotel(@RequestBody Hotel hotel) {
        hotelService.editarHotel(hotel);
    }

    @PutMapping("/cambiarEstado")
    public void cambiarEstadoHotel(@RequestParam String nombre,
                                   @RequestParam String ciudad,
                                   @RequestParam boolean activo) {
        hotelService.cambiarEstadoHotel(nombre, ciudad, activo);
    }
    
}