package com.abcnews.dao;

import com.abcnews.model.News;
import com.abcnews.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO {

    /**
     * Lấy tất cả các bản tin từ cơ sở dữ liệu.
     * @return Danh sách các đối tượng News.
     */
    private News mapResultSetToNews(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getString("Id"));
        news.setTitle(rs.getString("Title"));
        news.setContent(rs.getString("Content"));
        news.setImage(rs.getString("Image"));
        news.setPostedDate(rs.getTimestamp("PostedDate"));
        news.setAuthor(rs.getString("Author"));
        news.setViewCount(rs.getInt("ViewCount"));
        news.setCategoryId(rs.getString("CategoryId"));
        news.setHome(rs.getBoolean("Home"));
        return news;
    }

    public List<News> getAllNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM NEWS";

        // Sử dụng try-with-resources để đảm bảo tài nguyên được đóng tự động
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // In lỗi ra console để debug
        }
        return newsList;
    }

    // Thêm phương thức này vào trong class NewsDAO
    public List<News> getHomepageNews() {
        List<News> newsList = new ArrayList<>();
        // Chỉ lấy các bản tin có thuộc tính Home = 1
        String sql = "SELECT * FROM NEWS WHERE Home = 1 ORDER BY PostedDate DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return newsList;
    }

    // Lấy ra một danh sách tin tức mới nhất, giới hạn số lượng
    public List<News> getLatestNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NEWS ORDER BY PostedDate DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }

    // Lấy ra danh sách tin tức được xem nhiều nhất, giới hạn số lượng
    public List<News> getMostViewedNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NEWS ORDER BY ViewCount DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }

    // Lấy tin tức theo CategoryId, giới hạn số lượng
    public List<News> getNewsByCategoryId(String categoryId, int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NEWS WHERE CategoryId = ? ORDER BY PostedDate DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setString(2, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }

    public News findById(String id) {
        String sql = "SELECT * FROM NEWS WHERE Id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNews(rs); // Sử dụng lại hàm tối ưu của chúng ta
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Thêm một bài viết mới vào cơ sở dữ liệu.
     * @param news Đối tượng News chứa thông tin cần thêm.
     */
    public void insertNews(News news) {
        String sql = "INSERT INTO NEWS (Id, Title, Content, Image, Author, CategoryId, Home) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, news.getId());
            ps.setString(2, news.getTitle());
            ps.setString(3, news.getContent());
            ps.setString(4, news.getImage());
            ps.setString(5, news.getAuthor());
            ps.setString(6, news.getCategoryId());
            ps.setBoolean(7, news.isHome());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật một bài viết đã có.
     * @param news Đối tượng News chứa thông tin cần cập nhật.
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateNews(News news) {
        String sql = "UPDATE NEWS SET Title = ?, Content = ?, Image = ?, CategoryId = ?, Home = ? WHERE Id = ? AND Author = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getImage());
            ps.setString(4, news.getCategoryId());
            ps.setBoolean(5, news.isHome());
            ps.setString(6, news.getId());
            ps.setString(7, news.getAuthor()); // Chỉ tác giả mới được sửa
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa một bài viết dựa vào ID và tác giả.
     * @param newsId ID của bài viết cần xóa.
     * @param authorId ID của tác giả (phóng viên) thực hiện xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean deleteNews(String newsId, String authorId) {
        String sql = "DELETE FROM NEWS WHERE Id = ? AND Author = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newsId);
            ps.setString(2, authorId); // Chỉ tác giả mới được xóa
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}