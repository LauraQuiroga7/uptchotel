package co.edu.uptc.uptchotels.model;
public class Hotel {
   
    private String name;
    private String city;
    private String address;
    private String phone;
    private String email;
    private int capacity;
    private boolean state;


    public Hotel() {
    }
    
    public Hotel(String name, String city, String address, String phone, String email, int capacity, boolean state) {
        this.name = name;
        this.city = city;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.capacity = capacity;
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }   

    public String toString() {
        return "Name: " + name + "\n" +
                "City: " + city + "\n" +
                "Address: " + address + "\n" +
                "Phone: " + phone + "\n" +
                "Email: " + email + "\n" +
                "Capacity: " + capacity + "\n" +
                "State: " + state;
    }
}

