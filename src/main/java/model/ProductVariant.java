package model;

public class ProductVariant {
    private int id;
    private int productId;
    private int colorId;
    private int sizeId;
    private int stockQuantity;

    // Transient fields for easy display
    private String colorName;
    private String hexCode;
    private String sizeName;

    public ProductVariant() {}

    public ProductVariant(int id, int productId, int colorId, int sizeId, int stockQuantity) {
        this.id = id;
        this.productId = productId;
        this.colorId = colorId;
        this.sizeId = sizeId;
        this.stockQuantity = stockQuantity;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getColorId() { return colorId; }
    public void setColorId(int colorId) { this.colorId = colorId; }
    public int getSizeId() { return sizeId; }
    public void setSizeId(int sizeId) { this.sizeId = sizeId; }
    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getColorName() { return colorName; }
    public void setColorName(String colorName) { this.colorName = colorName; }
    public String getHexCode() { return hexCode; }
    public void setHexCode(String hexCode) { this.hexCode = hexCode; }
    public String getSizeName() { return sizeName; }
    public void setSizeName(String sizeName) { this.sizeName = sizeName; }
}
