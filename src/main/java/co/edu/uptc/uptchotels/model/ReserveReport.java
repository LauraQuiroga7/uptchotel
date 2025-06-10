package co.edu.uptc.uptchotels.model;

import java.util.List;

public class ReserveReport {
    private List<ReserveReporltem> items;

    public ReserveReport() {}

    public ReserveReport(List<ReserveReporltem> items) {
        this.items = items;
    }

    // Getters y setters

    public List<ReserveReporltem> getItems() {
        return items;
    }

    public void setItems(List<ReserveReporltem> items) {
        this.items = items;
    }
}
