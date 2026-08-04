package model;

public class Category {
    private String name;
    private int productCount;

    public Category() {
    }

    public Category(String name, int productCount) {
        this.name = name;
        this.productCount = productCount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    @Override
    public String toString() {
        return "Category{" +
                "name='" + name + '\'' +
                ", productCount=" + productCount +
                '}';
    }
}
