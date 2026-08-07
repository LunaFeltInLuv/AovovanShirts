package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.User;
import utils.ConnectDB;

public class Main {
    public static void main(String[] args) {
        List<User> userList = new ArrayList<>();
        String sql = "select * from users";
        try (Connection conn = ConnectDB.getConnect()) {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password_hash = rs.getString("password_hash");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String profilePictureURL = rs.getString("profile_picture_url");
                String address = rs.getString("address");
                Boolean isActive = rs.getBoolean("is_active");
                Timestamp createAt = rs.getTimestamp("created_at");
                Timestamp updateAt = rs.getTimestamp("updated_at");

                User temp = new User(id, username, password_hash, name, phone, email, profilePictureURL, address, isActive, createAt, updateAt);
                userList.add(temp);
            }
        } catch (SQLException e) {
            e.getMessage();
        }

        userList.forEach(s -> System.out.println(s.toString()));
    }
}
