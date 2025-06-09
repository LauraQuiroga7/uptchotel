package co.edu.uptc.uptchotels.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
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
    public List<Hotel> buscarHotelesApi(@RequestParam(required = false) String nombre,
                                        @RequestParam(required = false) String ciudad) {
        return hotelService.searchCityName(nombre, ciudad);
    }

    // Nuevo endpoint para buscar un hotel específico
    @GetMapping("/buscarEspecifico")
    public ResponseEntity<Hotel> buscarHotelEspecifico(@RequestParam String nombre,
                                                      @RequestParam String ciudad) {
        Hotel hotel = hotelService.buscarHotelEspecifico(nombre, ciudad);
        if (hotel != null) {
            return ResponseEntity.ok(hotel);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/listarHoteles")
    public List<Hotel> listarHoteles() {
        return hotelService.listarHoteles();
    }

    @PutMapping("/editar")
    public ResponseEntity<String> editarHotel(@RequestBody Hotel hotel) {
        Hotel hotelExistente = hotelService.buscarHotelEspecifico(hotel.getName(), hotel.getCity());
        if (hotelExistente != null) {
            hotelService.editarHotel(hotel);
            return ResponseEntity.ok("Hotel editado correctamente");
        } else {
            return ResponseEntity.notFound().build();
        }
    }

   
    @DeleteMapping("/eliminar")
    public ResponseEntity<String> eliminarHotel(@RequestParam String nombre,
                                               @RequestParam String ciudad) {
        boolean eliminado = hotelService.eliminarHotel(nombre, ciudad);
        if (eliminado) {
            return ResponseEntity.ok("Hotel eliminado correctamente");
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/cambiarEstado")
    public void cambiarEstadoHotel(@RequestParam String nombre,
                                   @RequestParam String ciudad,
                                   @RequestParam boolean activo) {
        hotelService.cambiarEstadoHotel(nombre, ciudad, activo);
    }
}