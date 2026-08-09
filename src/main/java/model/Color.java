package model;

public class Color {
    private int id;
    private String name;
    private String hexCode;

    public Color() {}

    public Color(int id, String name, String hexCode) {
        this.id = id;
        this.name = name;
        this.hexCode = hexCode;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getHexCode() { return hexCode; }
    public void setHexCode(String hexCode) { this.hexCode = hexCode; }
}
