package co.edu.uptc.uptchotels.model;

import java.time.LocalDate;


public class Reserve {
     private String nameHotel;
    private String cityHotel;
    private String nameCustomer;
    private String documentCustomer;
    private String emalCustomer;
    private LocalDate entryDate;
    private LocalDate departureDate;
    private String state;

    public Reserve() {
    }

    public Reserve(String nameHotel, String cityHotel, String nameCustomer, String documentCustomer, String emalCustomer, LocalDate entryDate, LocalDate departureDate, String state) {
        this.nameHotel = nameHotel;
        this.cityHotel = cityHotel;
        this.nameCustomer = nameCustomer;
        this.documentCustomer = documentCustomer;
        this.emalCustomer = emalCustomer;
        this.entryDate = entryDate;
        this.departureDate = departureDate;
        this.state = state;
    }

    public String getNameHotel() {
        return nameHotel;
    }

    public void setNameHotel(String nameHotel) {
        this.nameHotel = nameHotel;
    }

    public String getCityHotel() {
        return cityHotel;
    }

    public void setCityHotel(String cityHotel) {
        this.cityHotel = cityHotel;
    }

    public String getNameCustomer() {
        return nameCustomer;
    }

    public void setNameCustomer(String nameCustomer) {
        this.nameCustomer = nameCustomer;
    }

    public String getDocumentCustomer() {
        return documentCustomer;
    }

    public void setDocumentCustomer(String documentCustomer) {
        this.documentCustomer = documentCustomer;
    }

    public String getEmalCustomer() {
        return emalCustomer;
    }

    public void setEmalCustomer(String emalCustomer) {
        this.emalCustomer = emalCustomer;
    }

    public LocalDate getEntryDate() {
        return entryDate;
    }

    public void setEntryDate(LocalDate entryDate) {
        this.entryDate = entryDate;
    }

    public LocalDate getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(LocalDate departureDate) {
        this.departureDate = departureDate;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String toString() {
        return "Name hotel: " + nameHotel + "\n" +
                "City hotel: " + cityHotel + "\n" +
                "Name customer: " + nameCustomer + "\n" +
                "Document customer: " + documentCustomer + "\n" +
                "Email customer: " + emalCustomer + "\n" +
                "Entry date: " + entryDate + "\n" +
                "Departure date: " + departureDate + "\n" +
                "State: " + state;  
    }

}
