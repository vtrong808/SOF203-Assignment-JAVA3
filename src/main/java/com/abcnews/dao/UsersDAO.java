package com.abcnews.dao;

import com.abcnews.model.Users;
import com.abcnews.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public List<Users> getAllUsersAndReporters() {
        List<Users> userList = new ArrayList<>();
        // Lấy tất cả user không phải là admin
        String sql = "SELECT * FROM USERS WHERE Role < 2 ORDER BY Role DESC, Id ASC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getString("Id"));
                user.setFullname(rs.getString("Fullname"));
                user.setEmail(rs.getString("Email"));
                user.setRole(rs.getInt("Role"));
                user.setPoints(rs.getInt("Points"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updateUserByAdmin(Users user) {
        String sql = "UPDATE USERS SET Fullname = ?, Email = ?, Role = ?, Points = ? WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setInt(3, user.getRole());
            ps.setInt(4, user.getPoints());
            ps.setString(5, user.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(String userId) {
        // Cần cẩn thận với khóa ngoại, trước tiên phải xóa/cập nhật các bài viết của phóng viên này
        String updateNewsSql = "UPDATE NEWS SET Author = NULL WHERE Author = ?";
        String deleteUserSql = "DELETE FROM USERS WHERE Id = ?";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction

            try (PreparedStatement psNews = conn.prepareStatement(updateNewsSql)) {
                psNews.setString(1, userId);
                psNews.executeUpdate(); // Cập nhật các bài viết trước
            }

            try (PreparedStatement psUser = conn.prepareStatement(deleteUserSql)) {
                psUser.setString(1, userId);
                int result = psUser.executeUpdate();
                conn.commit(); // Hoàn tất transaction
                return result > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Cần có logic rollback ở đây nếu CSDL hỗ trợ
            return false;
        }
    }

    public Users findUserById(String id) {
        String sql = "SELECT * FROM USERS WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setId(rs.getString("Id"));
                    user.setFullname(rs.getString("Fullname"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getInt("Role"));
                    user.setPoints(rs.getInt("Points"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addUserByAdmin(Users user) {
        String sql = "INSERT INTO USERS (Id, [Password], Fullname, Email, [Role], Points) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getId());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setInt(5, user.getRole());
            ps.setInt(6, user.getPoints());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy tất cả người dùng có vai trò là Phóng viên (Role = 1).
     * @return Danh sách các phóng viên.
     */
    public List<Users> getAllReporters() {
        List<Users> reporterList = new ArrayList<>();
        String sql = "SELECT * FROM USERS WHERE Role = 1 ORDER BY Fullname ASC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getString("Id"));
                user.setFullname(rs.getString("Fullname"));
                reporterList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reporterList;
    }

    /**
     * Tìm người dùng dựa trên email và mật khẩu.
     * @param email Email của người dùng.
     * @param password Mật khẩu của người dùng.
     * @return Đối tượng Users nếu tìm thấy, null nếu không.
     */
    public Users findUserByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM USERS WHERE Email = ? AND [Password] = ?"; // Thay Id bằng Email
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email); // Tham số đầu tiên là email
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setId(rs.getString("Id"));
                    user.setPassword(rs.getString("Password")); // Vẫn lấy password để so khớp, nhưng không lưu vào session
                    user.setFullname(rs.getString("Fullname"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getInt("Role"));
                    user.setPoints(rs.getInt("Points"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Users findUserByIdOrEmailAndPassword(String identifier, String password) {
        String sql = "SELECT * FROM USERS WHERE (Id = ? OR Email = ?) AND [Password] = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, identifier);
            ps.setString(2, identifier);
            ps.setString(3, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setId(rs.getString("Id"));
                    user.setFullname(rs.getString("Fullname"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getInt("Role"));
                    user.setPoints(rs.getInt("Points"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Users findUserByEmail(String email) {
        String sql = "SELECT * FROM USERS WHERE Email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setId(rs.getString("Id"));
                    user.setFullname(rs.getString("Fullname"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getInt("Role"));
                    user.setPoints(rs.getInt("Points"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}