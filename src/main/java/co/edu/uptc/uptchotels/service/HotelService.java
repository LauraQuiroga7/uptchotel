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
        System.out.println("Hotel registrado: " + hotel.getName() + " en " + hotel.getCity());
    }

    public List<Hotel> buscarHoteles(String nombre, String ciudad) {
        return hoteles.stream()
                .filter(h -> (nombre == null || h.getName().equalsIgnoreCase(nombre)) &&
                             (ciudad == null || h.getCity().equalsIgnoreCase(ciudad)))
                .collect(Collectors.toList());
    }

    // Método mejorado para buscar un hotel específico por nombre y ciudad
    public Hotel buscarHotelEspecifico(String nombre, String ciudad) {
    for (Hotel h : hoteles) {
        if (h.getName().equalsIgnoreCase(nombre) && h.getCity().equalsIgnoreCase(ciudad)) {
            return h;
        }
    }
    return null;
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
                break; // Salir del bucle una vez encontrado
            }
        }
    }

    // Nuevo método para eliminar hotel
    public boolean eliminarHotel(String nombre, String ciudad) {
        return hoteles.removeIf(h -> 
            h.getName().equalsIgnoreCase(nombre) && h.getCity().equalsIgnoreCase(ciudad));
    }

    public void cambiarEstadoHotel(String nombre, String ciudad, boolean activo) {
        for (Hotel h : hoteles) {
            if (h.getName().equalsIgnoreCase(nombre) &&
                h.getCity().equalsIgnoreCase(ciudad)) {
                h.setState(activo);
                break;
            }
        }
    }
    
    public List<Hotel> listarHoteles() {
        return new ArrayList<>(hoteles);
    }

    public List<Hotel> getHoteles() {
        return hoteles;
    }

    public List<Hotel> searchCityName(String nombre, String ciudad) {
         return hoteles.stream()
        .filter(hotel -> (nombre == null || hotel.getName().toLowerCase().contains(nombre.toLowerCase())) &&
                         (ciudad == null || hotel.getCity().toLowerCase().contains(ciudad.toLowerCase())))
        .collect(Collectors.toList());
    }

    public boolean registeredHotelCity(String nombre, String ciudad) {
        return hoteles.stream()
        .anyMatch(h -> h.getName().equalsIgnoreCase(nombre) && h.getCity().equalsIgnoreCase(ciudad));
    }
}