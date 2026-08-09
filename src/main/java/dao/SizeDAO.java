package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Size;
import utils.ConnectDB;

public class SizeDAO {
    public List<Size> getAllSizes() {
        List<Size> list = new ArrayList<>();
        String sql = "{call sp_get_all_sizes()}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql);
             ResultSet rs = cs.executeQuery()) {
            while (rs.next()) {
                list.add(new Size(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int addSize(Size size) {
        String sql = "{call sp_add_size(?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setString(1, size.getName());
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("NewSizeID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean deleteSize(int id) {
        String sql = "DELETE FROM sizes WHERE id = ?";
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
