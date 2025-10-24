package com.abcnews.dao;

import com.abcnews.model.Comment;
import com.abcnews.util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    public List<Comment> getCommentsByNewsId(String newsId) {
        List<Comment> comments = new ArrayList<>();
        // Dùng JOIN để lấy luôn tên người bình luận
        String sql = "SELECT C.*, U.Fullname FROM COMMENTS C " +
                "JOIN USERS U ON C.UserId = U.Id " +
                "WHERE C.NewsId = ? ORDER BY C.PostedDate DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newsId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment c = new Comment();
                    c.setId(rs.getInt("Id"));
                    c.setNewsId(rs.getString("NewsId"));
                    c.setUserId(rs.getString("UserId"));
                    c.setContent(rs.getString("Content"));
                    c.setPostedDate(rs.getTimestamp("PostedDate"));
                    c.setUserFullname(rs.getString("Fullname"));
                    comments.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comments;
    }

    public void addComment(String newsId, String userId, String content) {
        String sql = "INSERT INTO COMMENTS (NewsId, UserId, Content) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newsId);
            ps.setString(2, userId);
            ps.setString(3, content);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}