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

    // ===== PHƯƠNG THỨC HỖ TRỢ (HELPER METHOD) TỐI ƯU HÓA =====
    // Nhiệm vụ duy nhất của hàm này là biến 1 dòng trong ResultSet thành 1 đối tượng News
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

    // ===== CÁC PHƯƠNG THỨC CŨ, GIỜ ĐÃ GỌN GÀNG HƠN =====

    public List<News> getHomepageNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM NEWS WHERE Home = 1 ORDER BY PostedDate DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                newsList.add(mapResultSetToNews(rs)); // <-- GỌI HÀM TỐI ƯU
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }

    public List<News> getLatestNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NEWS ORDER BY PostedDate DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    newsList.add(mapResultSetToNews(rs)); // <-- GỌI HÀM TỐI ƯU
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }

    public List<News> getMostViewedNews(int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NEWS ORDER BY ViewCount DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    newsList.add(mapResultSetToNews(rs)); // <-- GỌI HÀM TỐI ƯU
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }

    public List<News> getNewsByCategoryId(String categoryId, int limit) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM NEWS WHERE CategoryId = ? ORDER BY PostedDate DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setString(2, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    newsList.add(mapResultSetToNews(rs)); // <-- GỌI HÀM TỐI ƯU
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }
}