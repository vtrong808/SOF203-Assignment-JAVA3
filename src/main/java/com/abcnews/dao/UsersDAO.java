package com.abcnews.dao;

import com.abcnews.model.Users;
import com.abcnews.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsersDAO {

    public Users findUserByIdAndPassword(String id, String password) {
        String sql = "SELECT * FROM USERS WHERE Id = ? AND [Password] = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setId(rs.getString("Id"));
                    user.setPassword(rs.getString("Password")); // Không nên lưu password vào session, nhưng tạm thời để đó
                    user.setFullname(rs.getString("Fullname"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getInt("Role"));
                    user.setPoints(rs.getInt("Points"));
                    return user;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertUser(Users user) {
        String sql = "INSERT INTO USERS (Id, [Password], Fullname, Email, [Role], Points) VALUES (?, ?, ?, ?, 0, 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getId());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void addPoints(String userId, int pointsToAdd) {
        String sql = "UPDATE USERS SET Points = Points + ? WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pointsToAdd);
            ps.setString(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Trừ điểm của người dùng sau khi đổi thưởng.
     * @param userId ID của người dùng.
     * @param pointsToSubtract Số điểm cần trừ.
     * @return true nếu trừ điểm thành công, false nếu thất bại.
     */
    public boolean subtractPoints(String userId, int pointsToSubtract) {
        // Câu lệnh SQL này đảm bảo người dùng không thể có điểm âm
        String sql = "UPDATE USERS SET Points = Points - ? WHERE Id = ? AND Points >= ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pointsToSubtract);
            ps.setString(2, userId);
            ps.setInt(3, pointsToSubtract); // Điều kiện kiểm tra đủ điểm

            // executeUpdate() trả về số dòng bị ảnh hưởng.
            // Nếu > 0, nghĩa là cập nhật thành công.
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}