package com.abcnews.dao;

import com.abcnews.util.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class InteractionDAO {

    // --- XỬ LÝ LƯU BÀI VIẾT ---

    public boolean isArticleSaved(String newsId, String userId) {
        String sql = "SELECT COUNT(*) FROM SAVED_ARTICLES WHERE UserId = ? AND NewsId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, newsId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean toggleSaveArticle(String newsId, String userId) {
        if (isArticleSaved(newsId, userId)) {
            // Đã lưu -> Bỏ lưu
            String sql = "DELETE FROM SAVED_ARTICLES WHERE UserId = ? AND NewsId = ?";
            try (Connection conn = DBContext.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, userId);
                ps.setString(2, newsId);
                ps.executeUpdate();
                return false; // Trạng thái mới: chưa lưu
            } catch (Exception e) {
                e.printStackTrace();
                return true; // Lỗi, giả định vẫn còn lưu
            }
        } else {
            // Chưa lưu -> Lưu
            String sql = "INSERT INTO SAVED_ARTICLES (UserId, NewsId) VALUES (?, ?)";
            try (Connection conn = DBContext.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, userId);
                ps.setString(2, newsId);
                ps.executeUpdate();
                return true; // Trạng thái mới: đã lưu
            } catch (Exception e) {
                e.printStackTrace();
                return false; // Lỗi, giả định vẫn chưa lưu
            }
        }
    }

    // --- XỬ LÝ CẢM XÚC ---

    public Map<String, Integer> getReactionCounts(String newsId) {
        Map<String, Integer> counts = new HashMap<>();
        String sql = "SELECT ReactionType, COUNT(*) as Count FROM REACTIONS " +
                "WHERE NewsId = ? GROUP BY ReactionType";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newsId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    counts.put(String.valueOf(rs.getInt("ReactionType")), rs.getInt("Count"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return counts;
    }

    public int getUserReaction(String newsId, String userId) {
        String sql = "SELECT ReactionType FROM REACTIONS WHERE NewsId = ? AND UserId = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newsId);
            ps.setString(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("ReactionType");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; // 0 = Chưa thả cảm xúc
    }

    public void addOrUpdateReaction(String newsId, String userId, int reactionType) {
        // MERGE là câu lệnh SQL Server mạnh mẽ, tự động INSERT hoặc UPDATE
        String sql = "MERGE INTO REACTIONS AS target " +
                "USING (VALUES (?, ?, ?)) AS source (NewsId, UserId, ReactionType) " +
                "ON (target.NewsId = source.NewsId AND target.UserId = source.UserId) " +
                "WHEN MATCHED THEN " +
                "    UPDATE SET ReactionType = source.ReactionType " +
                "WHEN NOT MATCHED THEN " +
                "    INSERT (NewsId, UserId, ReactionType) VALUES (source.NewsId, source.UserId, source.ReactionType);";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newsId);
            ps.setString(2, userId);
            ps.setInt(3, reactionType);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}