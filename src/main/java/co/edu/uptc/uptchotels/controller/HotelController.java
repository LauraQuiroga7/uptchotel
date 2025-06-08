package co.edu.uptc.uptchotels.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping("/buscar")
    public List<Hotel> buscarHoteles(@RequestParam(required = false) String nombre,
                                     @RequestParam(required = false) String ciudad) {
        return hotelService.buscarHoteles(nombre, ciudad);
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