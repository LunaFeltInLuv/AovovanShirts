package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ProductVariant;
import utils.ConnectDB;

public class ProductVariantDAO {
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "{call sp_get_product_variants(?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, productId);
            try (ResultSet rs = cs.executeQuery()) {
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
        String sql = "{call sp_add_product_variant(?, ?, ?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, variant.getProductId());
            cs.setInt(2, variant.getColorId());
            cs.setInt(3, variant.getSizeId());
            cs.setInt(4, variant.getStockQuantity());
            cs.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteVariant(int variantId) {
        String sql = "{call sp_delete_product_variant(?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, variantId);
            cs.execute();
            return true;
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
