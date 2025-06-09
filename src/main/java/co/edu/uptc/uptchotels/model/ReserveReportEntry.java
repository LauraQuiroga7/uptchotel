package co.edu.uptc.uptchotels.model;

import java.time.LocalDate;

public class ReserveReportEntry {
private LocalDate fecha;
    private String nombreHotel;
    private int habitacionesReservadas; // Estado REGISTRADA
    private int habitacionesOcupadas;   // Estado CHECK-IN
    private int habitacionesLiberadas;  // Estado CHECK-OUT

    public ReserveReportEntry() {
    }

    public ReserveReportEntry(LocalDate fecha, String nombreHotel, int habitacionesReservadas, 
                             int habitacionesOcupadas, int habitacionesLiberadas) {
        this.fecha = fecha;
        this.nombreHotel = nombreHotel;
        this.habitacionesReservadas = habitacionesReservadas;
        this.habitacionesOcupadas = habitacionesOcupadas;
        this.habitacionesLiberadas = habitacionesLiberadas;
    }

    // Getters y Setters
    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public String getNombreHotel() {
        return nombreHotel;
    }

    public void setNombreHotel(String nombreHotel) {
        this.nombreHotel = nombreHotel;
    }

    public int getHabitacionesReservadas() {
        return habitacionesReservadas;
    }

    public void setHabitacionesReservadas(int habitacionesReservadas) {
        this.habitacionesReservadas = habitacionesReservadas;
    }

    public int getHabitacionesOcupadas() {
        return habitacionesOcupadas;
    }

    public void setHabitacionesOcupadas(int habitacionesOcupadas) {
        this.habitacionesOcupadas = habitacionesOcupadas;
    }

    public int getHabitacionesLiberadas() {
        return habitacionesLiberadas;
    }

    public void setHabitacionesLiberadas(int habitacionesLiberadas) {
        this.habitacionesLiberadas = habitacionesLiberadas;
    }

    @Override
    public String toString() {
        return "ReserveReportEntry{" +
                "fecha=" + fecha +
                ", nombreHotel='" + nombreHotel + '\'' +
                ", habitacionesReservadas=" + habitacionesReservadas +
                ", habitacionesOcupadas=" + habitacionesOcupadas +
                ", habitacionesLiberadas=" + habitacionesLiberadas +
                '}';
    }
}
