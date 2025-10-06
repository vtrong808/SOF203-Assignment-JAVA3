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
    public List<News> getAllNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT * FROM NEWS";

        // Sử dụng try-with-resources để đảm bảo tài nguyên được đóng tự động
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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
                newsList.add(news);
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
                newsList.add(news);
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
                News news = new News();
                // ... (copy code map ResultSet to News object từ các hàm khác)
                news.setId(rs.getString("Id"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setImage(rs.getString("Image"));
                news.setPostedDate(rs.getTimestamp("PostedDate"));
                news.setAuthor(rs.getString("Author"));
                news.setViewCount(rs.getInt("ViewCount"));
                news.setCategoryId(rs.getString("CategoryId"));
                news.setHome(rs.getBoolean("Home"));
                newsList.add(news);
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
                News news = new News();
                // ... (copy code map ResultSet to News object)
                news.setId(rs.getString("Id"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setImage(rs.getString("Image"));
                news.setPostedDate(rs.getTimestamp("PostedDate"));
                news.setAuthor(rs.getString("Author"));
                news.setViewCount(rs.getInt("ViewCount"));
                news.setCategoryId(rs.getString("CategoryId"));
                news.setHome(rs.getBoolean("Home"));
                newsList.add(news);
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
                News news = new News();
                // ... (copy code map ResultSet to News object)
                news.setId(rs.getString("Id"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setImage(rs.getString("Image"));
                news.setPostedDate(rs.getTimestamp("PostedDate"));
                news.setAuthor(rs.getString("Author"));
                news.setViewCount(rs.getInt("ViewCount"));
                news.setCategoryId(rs.getString("CategoryId"));
                news.setHome(rs.getBoolean("Home"));
                newsList.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newsList;
    }
}