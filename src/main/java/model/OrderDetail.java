package model;

import java.math.BigDecimal;

public class OrderDetail {
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal price;
    private BigDecimal totalLine;
    private Product product;

    public OrderDetail() {
    }

    public OrderDetail(int orderId, int productId, int quantity, BigDecimal price, BigDecimal totalLine) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.totalLine = totalLine;
    }

    public OrderDetail(int orderId, int productId, int quantity, BigDecimal price, BigDecimal totalLine, Product product) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.totalLine = totalLine;
        this.product = product;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalLine() {
        return totalLine;
    }

    public void setTotalLine(BigDecimal totalLine) {
        this.totalLine = totalLine;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "orderId=" + orderId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", price=" + price +
                ", totalLine=" + totalLine +
                '}';
    }
}
