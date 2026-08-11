package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import utils.ConnectDB;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_active = 1 ORDER BY created_at DESC";
        try (Connection con = ConnectDB.getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getAllProductsAdmin() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        try (Connection con = ConnectDB.getConnect()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsAdminPaginated(String category, int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products ");
        if (category != null && !category.trim().isEmpty()) {
            sql.append("WHERE category = ? ");
        }
        sql.append("ORDER BY id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIdx = 1;
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(paramIdx++, category.trim());
            }
            int offset = (page - 1) * pageSize;
            ps.setInt(paramIdx++, offset);
            ps.setInt(paramIdx, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProductsAdminCount(String category) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products ");
        if (category != null && !category.trim().isEmpty()) {
            sql.append("WHERE category = ? ");
        }

        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(1, category.trim());
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> searchProducts(String keyword, String category, int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE is_active = 1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (name COLLATE Vietnamese_CI_AI LIKE ? OR description COLLATE Vietnamese_CI_AI LIKE ?) ");
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append("AND category = ? ");
        }
        sql.append("ORDER BY id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIdx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(paramIdx++, kw);
                ps.setString(paramIdx++, kw);
            }
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(paramIdx++, category.trim());
            }
            int offset = (page - 1) * pageSize;
            ps.setInt(paramIdx++, offset);
            ps.setInt(paramIdx, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProductsCount(String keyword, String category) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE is_active = 1 ");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (name COLLATE Vietnamese_CI_AI LIKE ? OR description COLLATE Vietnamese_CI_AI LIKE ?) ");
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append("AND category = ? ");
        }

        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIdx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(paramIdx++, kw);
                ps.setString(paramIdx++, kw);
            }
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(paramIdx++, category.trim());
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int addProduct(Product p) {
        String sql = "{call sp_add_product(?, ?, ?, ?, ?, ?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setString(1, p.getName());
            cs.setString(2, p.getDescription());
            cs.setBigDecimal(3, p.getPrice());
            cs.setInt(4, p.getStockQuantity());
            cs.setString(5, p.getCategory());
            cs.setString(6, p.getImageUrl());
            if (p.getIsActive() != null) {
                cs.setBoolean(7, p.getIsActive());
            } else {
                cs.setBoolean(7, true);
            }

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("product_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updateProduct(Product p) {
        String sql = "{call sp_update_product(?, ?, ?, ?, ?, ?, ?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, p.getId());
            cs.setString(2, p.getName());
            cs.setString(3, p.getDescription());
            cs.setBigDecimal(4, p.getPrice());
            if (p.getStockQuantity() >= 0) {
                cs.setInt(5, p.getStockQuantity());
            } else {
                cs.setNull(5, Types.INTEGER);
            }
            cs.setString(6, p.getCategory());
            cs.setString(7, p.getImageUrl());
            if (p.getIsActive() != null) {
                cs.setBoolean(8, p.getIsActive());
            } else {
                cs.setNull(8, Types.BOOLEAN);
            }
            cs.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int productId, boolean forceDelete) {
        String sql = "{call sp_delete_product(?, ?)}";
        try (Connection con = ConnectDB.getConnect();
            CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, productId);
            cs.setBoolean(2, forceDelete);
            cs.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean restoreProduct(int productId) {
        String sql = "UPDATE products SET is_active = 1 WHERE id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setCategory(rs.getString("category"));
        p.setImageUrl(rs.getString("image_url"));
        p.setIsActive(rs.getBoolean("is_active"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    }
}
