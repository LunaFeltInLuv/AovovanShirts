package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Color;
import utils.ConnectDB;

public class ColorDAO {
    public List<Color> getAllColors() {
        List<Color> list = new ArrayList<>();
        String sql = "{call sp_get_all_colors()}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql);
             ResultSet rs = cs.executeQuery()) {
            while (rs.next()) {
                list.add(new Color(rs.getInt("id"), rs.getString("name"), rs.getString("hex_code")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int addColor(Color color) {
        String sql = "{call sp_add_color(?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setString(1, color.getName());
            cs.setString(2, color.getHexCode());
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("NewColorID");
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
}
