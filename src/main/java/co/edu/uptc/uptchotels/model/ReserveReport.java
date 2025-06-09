package co.edu.uptc.uptchotels.model;

import java.time.LocalDate;
import java.util.List;

public class ReserveReport {

    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private String ciudad;
    private List<ReserveReportEntry> entradas;

    public ReserveReport() {
    }

    public ReserveReport(LocalDate fechaInicio, LocalDate fechaFin, String ciudad, List<ReserveReportEntry> entradas) {
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.ciudad = ciudad;
        this.entradas = entradas;
    }

    // Getters y Setters
    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public List<ReserveReportEntry> getEntradas() {
        return entradas;
    }

    public void setEntradas(List<ReserveReportEntry> entradas) {
        this.entradas = entradas;
    }

    @Override
    public String toString() {
        return "ReserveReport{" +
                "fechaInicio=" + fechaInicio +
                ", fechaFin=" + fechaFin +
                ", ciudad='" + ciudad + '\'' +
                ", entradas=" + entradas +
                '}';
    }




}
