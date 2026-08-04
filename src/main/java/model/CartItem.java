package model;

import java.sql.Timestamp;

public class CartItem {
    private int cartId;
    private int productId;
    private int quantity;
    private Timestamp addedAt;
    private Product product;

    public CartItem() {
    }

    public CartItem(int cartId, int productId, int quantity, Timestamp addedAt) {
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
        this.addedAt = addedAt;
    }

    public CartItem(int cartId, int productId, int quantity, Timestamp addedAt, Product product) {
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
        this.addedAt = addedAt;
        this.product = product;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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

    public Timestamp getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public java.math.BigDecimal getLineTotal() {
        if (product != null && product.getPrice() != null) {
            return product.getPrice().multiply(new java.math.BigDecimal(quantity));
        }
        return java.math.BigDecimal.ZERO;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "cartId=" + cartId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", addedAt=" + addedAt +
                '}';
    }
}
