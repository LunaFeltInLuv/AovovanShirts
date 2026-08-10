package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ProductVariant;
import utils.ConnectDB;

public class ProductVariantDAO {
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT pv.id, pv.product_id, pv.color_id, pv.size_id, pv.stock_quantity, " +
                     "c.name as color_name, c.hex_code, s.name as size_name " +
                     "FROM product_variants pv " +
                     "JOIN colors c ON pv.color_id = c.id " +
                     "JOIN sizes s ON pv.size_id = s.id " +
                     "WHERE pv.product_id = ? " +
                     "ORDER BY c.name ASC, s.id ASC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setId(rs.getInt("id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setColorId(rs.getInt("color_id"));
                    v.setSizeId(rs.getInt("size_id"));
                    v.setStockQuantity(rs.getInt("stock_quantity"));
                    
                    v.setColorName(rs.getString("color_name"));
                    v.setHexCode(rs.getString("hex_code"));
                    v.setSizeName(rs.getString("size_name"));
                    
                    list.add(v);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addOrUpdateVariant(ProductVariant variant) {
        String checkSql = "SELECT id FROM product_variants WHERE product_id = ? AND color_id = ? AND size_id = ?";
        String updateSql = "UPDATE product_variants SET stock_quantity = ? WHERE product_id = ? AND color_id = ? AND size_id = ?";
        String insertSql = "INSERT INTO product_variants (product_id, color_id, size_id, stock_quantity) VALUES (?, ?, ?, ?)";
        try (Connection con = ConnectDB.getConnect()) {
            boolean exists = false;
            try (PreparedStatement checkPs = con.prepareStatement(checkSql)) {
                checkPs.setInt(1, variant.getProductId());
                checkPs.setInt(2, variant.getColorId());
                checkPs.setInt(3, variant.getSizeId());
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        exists = true;
                    }
                }
            }
            if (exists) {
                try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                    updatePs.setInt(1, variant.getStockQuantity());
                    updatePs.setInt(2, variant.getProductId());
                    updatePs.setInt(3, variant.getColorId());
                    updatePs.setInt(4, variant.getSizeId());
                    return updatePs.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                    insertPs.setInt(1, variant.getProductId());
                    insertPs.setInt(2, variant.getColorId());
                    insertPs.setInt(3, variant.getSizeId());
                    insertPs.setInt(4, variant.getStockQuantity());
                    return insertPs.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteVariant(int variantId) {
        String sql = "DELETE FROM product_variants WHERE id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ProductVariant getVariantById(int variantId) {
        String sql = "SELECT pv.*, c.name as color_name, c.hex_code, s.name as size_name " +
                     "FROM product_variants pv " +
                     "JOIN colors c ON pv.color_id = c.id " +
                     "JOIN sizes s ON pv.size_id = s.id " +
                     "WHERE pv.id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setId(rs.getInt("id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setColorId(rs.getInt("color_id"));
                    v.setSizeId(rs.getInt("size_id"));
                    v.setStockQuantity(rs.getInt("stock_quantity"));
                    
                    v.setColorName(rs.getString("color_name"));
                    v.setHexCode(rs.getString("hex_code"));
                    v.setSizeName(rs.getString("size_name"));
                    return v;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
