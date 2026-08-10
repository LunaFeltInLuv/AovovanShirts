package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Color;
import utils.ConnectDB;

public class ColorDAO {
    public List<Color> getAllColors() {
        List<Color> list = new ArrayList<>();
        String sql = "SELECT id, name, hex_code FROM colors ORDER BY name ASC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Color(rs.getInt("id"), rs.getString("name"), rs.getString("hex_code")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int addColor(Color color) {
        String sql = "INSERT INTO colors (name, hex_code) VALUES (?, ?)";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, color.getName());
            ps.setString(2, color.getHexCode());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean deleteColor(int id) {
        String sql = "DELETE FROM colors WHERE id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean isColorExists(String name) {
        String sql = "SELECT 1 FROM colors WHERE name = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
