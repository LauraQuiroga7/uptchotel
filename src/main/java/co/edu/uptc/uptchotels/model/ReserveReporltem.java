package co.edu.uptc.uptchotels.model;

import java.time.LocalDate;

public class ReserveReporltem {
    private LocalDate fechaLlegada;
    private String nombreHotel;
    private long registradas;
    private long checkIn;
    private long checkOut;

    public ReserveReporltem() {}

    public ReserveReporltem(LocalDate fechaLlegada, String nombreHotel) {
        this.fechaLlegada = fechaLlegada;
        this.nombreHotel = nombreHotel;
        this.registradas = 0;
        this.checkIn = 0;
        this.checkOut = 0;
    }

    // Getters y setters

    public LocalDate getFechaLlegada() {
        return fechaLlegada;
    }

    public void setFechaLlegada(LocalDate fechaLlegada) {
        this.fechaLlegada = fechaLlegada;
    }

    public String getNombreHotel() {
        return nombreHotel;
    }

    public void setNombreHotel(String nombreHotel) {
        this.nombreHotel = nombreHotel;
    }

    public long getRegistradas() {
        return registradas;
    }

    public void setRegistradas(long registradas) {
        this.registradas = registradas;
    }

    public long getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(long checkIn) {
        this.checkIn = checkIn;
    }

    public long getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(long checkOut) {
        this.checkOut = checkOut;
    }
}