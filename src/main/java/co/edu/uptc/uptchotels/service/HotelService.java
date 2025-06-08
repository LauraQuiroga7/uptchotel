package co.edu.uptc.uptchotels.service;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import co.edu.uptc.uptchotels.model.Hotel;

@Service
public class HotelService {
    
    private List<Hotel> hoteles = new ArrayList<>();

    public void registrarHotel(Hotel hotel) {
        hoteles.add(hotel);
    }

    public List<Hotel> buscarHoteles(String nombre, String ciudad) {
        return hoteles.stream()
                .filter(h -> (nombre == null || h.getName().equalsIgnoreCase(nombre)) &&
                             (ciudad == null || h.getCity().equalsIgnoreCase(ciudad)))
                .collect(Collectors.toList());
    }

    public void editarHotel(Hotel hotelEditado) {
        for (Hotel h : hoteles) {
            if (h.getName().equalsIgnoreCase(hotelEditado.getName()) &&
                h.getCity().equalsIgnoreCase(hotelEditado.getCity())) {
                h.setAddress(hotelEditado.getAddress());
                h.setPhone(hotelEditado.getPhone());
                h.setEmail(hotelEditado.getEmail());
                h.setCapacity(hotelEditado.getCapacity());
                h.setState(hotelEditado.isState());
            }
        }
    }

    public void cambiarEstadoHotel(String nombre, String ciudad, boolean activo) {
        for (Hotel h : hoteles) {
            if (h.getName().equalsIgnoreCase(nombre) &&
                h.getCity().equalsIgnoreCase(ciudad)) {
                h.setState(activo);
            }
        }
    }

    public List<Hotel> getHoteles() {
        return hoteles;
    }
}
