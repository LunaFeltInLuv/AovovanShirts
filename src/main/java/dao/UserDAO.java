package dao;

import model.Role;
import model.User;
import utils.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User getUserByUsername(String username) {
        String sql = "{call sp_get_user_by_username(?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setString(1, username);
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int userId) {
        String sql = "{call sp_get_user_by_id(?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, userId);
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Role> getUserRoles(int userId) {
        List<Role> roles = new ArrayList<>();
        String sql = "{call sp_get_user_roles(?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, userId);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    Role r = new Role();
                    r.setId(rs.getInt("role_id"));
                    r.setName(rs.getString("role_name"));
                    r.setDescription(rs.getString("role_description"));
                    roles.add(r);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public int addUser(User user, String roleIds) {
        String sql = "{call sp_add_user(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setString(1, user.getUsername());
            cs.setString(2, user.getPassword_hash());
            cs.setString(3, user.getName());
            cs.setString(4, user.getPhone());
            cs.setString(5, user.getEmail());
            cs.setString(6, user.getProfilePictureURL());
            cs.setString(7, user.getAddress());
            if (user.getActive() != null) {
                cs.setBoolean(8, user.getActive());
            } else {
                cs.setBoolean(8, true);
            }
            cs.setString(9, roleIds);

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updateUser(User user) {
        String sql = "{call sp_update_user(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, user.getId());
            cs.setString(2, user.getUsername());
            cs.setString(3, user.getPassword_hash());
            cs.setString(4, user.getName());
            cs.setString(5, user.getPhone());
            cs.setString(6, user.getEmail());
            cs.setString(7, user.getProfilePictureURL());
            cs.setString(8, user.getAddress());
            if (user.getActive() != null) {
                cs.setBoolean(9, user.getActive());
            } else {
                cs.setNull(9, Types.BOOLEAN);
            }
            cs.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId, boolean forceDelete) {
        String sql = "{call sp_delete_user(?, ?)}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setInt(1, userId);
            cs.setBoolean(2, forceDelete);
            cs.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getUsers(String keyword, Integer roleId, Boolean isActive, int page, int pageSize) {
        List<User> list = new ArrayList<>();
        String sql = "{call sp_get_users(?, ?, ?, ?, ?, 'id', 'ASC')}";
        try (Connection con = ConnectDB.getConnect();
             CallableStatement cs = con.prepareCall(sql)) {
            if (keyword != null && !keyword.trim().isEmpty()) {
                cs.setString(1, keyword.trim());
            } else {
                cs.setNull(1, Types.NVARCHAR);
            }
            if (roleId != null) {
                cs.setInt(2, roleId);
            } else {
                cs.setNull(2, Types.INTEGER);
            }
            if (isActive != null) {
                cs.setBoolean(3, isActive);
            } else {
                cs.setNull(3, Types.BOOLEAN);
            }
            cs.setInt(4, page);
            cs.setInt(5, pageSize);

            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setName(rs.getString("name"));
                    u.setPhone(rs.getString("phone"));
                    u.setEmail(rs.getString("email"));
                    u.setActive(rs.getBoolean("is_active"));
                    u.setCreateAt(rs.getTimestamp("created_at"));
                    u.setUpdateAt(rs.getTimestamp("updated_at"));
                    list.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        try {
            u.setPassword_hash(rs.getString("password_hash"));
        } catch (SQLException ignored) {}
        u.setName(rs.getString("name"));
        u.setPhone(rs.getString("phone"));
        u.setEmail(rs.getString("email"));
        u.setProfilePictureURL(rs.getString("profile_picture_url"));
        u.setAddress(rs.getString("address"));
        u.setActive(rs.getBoolean("is_active"));
        u.setCreateAt(rs.getTimestamp("created_at"));
        u.setUpdateAt(rs.getTimestamp("updated_at"));
        return u;
    }
}
