package dao;

import model.CartItem;
import model.Product;
import utils.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public int getCartIdByUserId(int userId) {
        String sql = "SELECT id FROM carts WHERE user_id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String addToCartWithMessage(int userId, int productId, int quantity) {
        Connection con = null;
        try {
            con = ConnectDB.getConnect();
            if (con == null) {
                return "Không thể kết nối đến cơ sở dữ liệu!";
            }

            // 1. Kiểm tra người dùng
            String checkUserSql = "SELECT id FROM users WHERE id = ?";
            try (PreparedStatement psUser = con.prepareStatement(checkUserSql)) {
                psUser.setInt(1, userId);
                try (ResultSet rs = psUser.executeQuery()) {
                    if (!rs.next()) {
                        return "Người dùng không tồn tại!";
                    }
                }
            }

            // 2. Kiểm tra sản phẩm và số lượng tồn kho
            int stock = 0;
            String checkProductSql = "SELECT stock_quantity, is_active FROM products WHERE id = ?";
            try (PreparedStatement psProd = con.prepareStatement(checkProductSql)) {
                psProd.setInt(1, productId);
                try (ResultSet rs = psProd.executeQuery()) {
                    if (!rs.next()) {
                        return "Sản phẩm không tồn tại!";
                    }
                    boolean isActive = rs.getBoolean("is_active");
                    if (!isActive) {
                        return "Sản phẩm đang ngừng bán!";
                    }
                    stock = rs.getInt("stock_quantity");
                }
            }

            // 3. Lấy hoặc tạo giỏ hàng cho người dùng
            int cartId = -1;
            String getCartSql = "SELECT id FROM carts WHERE user_id = ?";
            try (PreparedStatement psCart = con.prepareStatement(getCartSql)) {
                psCart.setInt(1, userId);
                try (ResultSet rs = psCart.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("id");
                    }
                }
            }

            if (cartId == -1) {
                String createCartSql = "INSERT INTO carts (user_id) VALUES (?)";
                try (PreparedStatement psCreate = con.prepareStatement(createCartSql, Statement.RETURN_GENERATED_KEYS)) {
                    psCreate.setInt(1, userId);
                    psCreate.executeUpdate();
                    try (ResultSet rs = psCreate.getGeneratedKeys()) {
                        if (rs.next()) {
                            cartId = rs.getInt(1);
                        }
                    }
                }
            }

            if (cartId == -1) {
                return "Không thể tạo giỏ hàng cho người dùng!";
            }

            // 4. Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
            int currentQty = -1;
            String checkItemSql = "SELECT quantity FROM cart_items WHERE cart_id = ? AND product_id = ?";
            try (PreparedStatement psItem = con.prepareStatement(checkItemSql)) {
                psItem.setInt(1, cartId);
                psItem.setInt(2, productId);
                try (ResultSet rs = psItem.executeQuery()) {
                    if (rs.next()) {
                        currentQty = rs.getInt("quantity");
                    }
                }
            }

            if (currentQty == -1) {
                if (quantity > stock) {
                    return "Số lượng yêu cầu vượt quá tồn kho (" + stock + ")!";
                }
                String insertItemSql = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement psInsert = con.prepareStatement(insertItemSql)) {
                    psInsert.setInt(1, cartId);
                    psInsert.setInt(2, productId);
                    psInsert.setInt(3, quantity);
                    psInsert.executeUpdate();
                }
            } else {
                if (currentQty + quantity > stock) {
                    return "Tổng số lượng trong giỏ vượt quá tồn kho (" + stock + ")!";
                }
                String updateItemSql = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_id = ? AND product_id = ?";
                try (PreparedStatement psUpdate = con.prepareStatement(updateItemSql)) {
                    psUpdate.setInt(1, quantity);
                    psUpdate.setInt(2, cartId);
                    psUpdate.setInt(3, productId);
                    psUpdate.executeUpdate();
                }
            }

            return null; // Thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return "Lỗi CSDL: " + e.getMessage();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ignored) {}
            }
        }
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        return addToCartWithMessage(userId, productId, quantity) == null;
    }

    public List<CartItem> getCartItemsByUserId(int userId) {
        int cartId = getCartIdByUserId(userId);
        if (cartId <= 0) {
            return new ArrayList<>();
        }
        return getCartItems(cartId);
    }

    public List<CartItem> getCartItems(int cartId) {
        List<CartItem> list = new ArrayList<>();
        if (cartId <= 0) {
            return list;
        }
        String sql = "SELECT ci.cart_id, ci.product_id, ci.quantity, ci.added_at, " +
                "p.name, p.price, p.image_url, p.stock_quantity, p.is_active " +
                "FROM cart_items ci " +
                "JOIN products p ON ci.product_id = p.id " +
                "WHERE ci.cart_id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setAddedAt(rs.getTimestamp("added_at"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getBigDecimal("price"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setStockQuantity(rs.getInt("stock_quantity"));
                    p.setIsActive(rs.getBoolean("is_active"));

                    item.setProduct(p);
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateCartItemQuantity(int cartId, int productId, int quantity) {
        if (quantity <= 0) {
            return removeCartItem(cartId, productId);
        }
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_id = ? AND product_id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeCartItem(int cartId, int productId) {
        String sql = "DELETE FROM cart_items WHERE cart_id = ? AND product_id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean clearCart(int cartId) {
        String sql = "DELETE FROM cart_items WHERE cart_id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
