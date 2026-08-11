package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import utils.ConnectDB;

public class CategoryDAO {

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category, COUNT(*) as count FROM products " +
                     "WHERE category IS NOT NULL AND category != '' " +
                     "GROUP BY category " +
                     "ORDER BY category ASC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getString("category"), rs.getInt("count")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateCategory(String oldName, String newName) {
        if (newName == null || newName.trim().isEmpty()) {
            return false;
        }
        String sql = "UPDATE products SET category = ? WHERE category = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newName.trim());
            ps.setString(2, oldName);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCategory(String name) {
        String sql = "UPDATE products SET category = NULL WHERE category = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean addCategoryToProducts(String categoryName, String[] productIds) {
        if (productIds == null || productIds.length == 0 || categoryName == null || categoryName.trim().isEmpty()) {
            return false;
        }
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < productIds.length; i++) {
            placeholders.append("?");
            if (i < productIds.length - 1) {
                placeholders.append(",");
            }
        }
        String sql = "UPDATE products SET category = ? WHERE id IN (" + placeholders.toString() + ")";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, categoryName.trim());
            for (int i = 0; i < productIds.length; i++) {
                ps.setInt(i + 2, Integer.parseInt(productIds[i]));
            }
            return ps.executeUpdate() > 0;
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
        }
        return false;
    }
}
