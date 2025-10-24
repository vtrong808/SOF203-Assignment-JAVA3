package com.abcnews.controller;

import com.abcnews.dao.CommentDAO;
import com.abcnews.dao.InteractionDAO;
import com.abcnews.dao.NewsDAO;
import com.abcnews.model.Comment;
import com.abcnews.model.News;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/news-detail")
public class NewsDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        HttpSession session = req.getSession(false);
        Users currentUser = (session != null) ? (Users) session.getAttribute("user") : null;

        NewsDAO newsDAO = new NewsDAO();
        CommentDAO commentDAO = new CommentDAO();
        InteractionDAO interactionDAO = new InteractionDAO();

        // 1. Tăng lượt xem (đã có từ trước)
        if (id != null && !id.isEmpty()) {
            newsDAO.incrementViewCount(id);
        }

        // 2. Lấy nội dung bài báo
        News news = newsDAO.findById(id);

        // 3. Lấy danh sách bình luận
        List<Comment> comments = commentDAO.getCommentsByNewsId(id);

        // 4. Lấy số lượng cảm xúc
        Map<String, Integer> reactionCounts = interactionDAO.getReactionCounts(id);

        // 5. Kiểm tra trạng thái người dùng (đã lưu? đã thả cảm xúc?)
        if (currentUser != null) {
            boolean isSaved = interactionDAO.isArticleSaved(id, currentUser.getId());
            int userReaction = interactionDAO.getUserReaction(id, currentUser.getId());
            req.setAttribute("isSaved", isSaved);
            req.setAttribute("userReaction", userReaction);
        }

        req.setAttribute("news", news);
        req.setAttribute("comments", comments);
        req.setAttribute("reactionCounts", reactionCounts);

        req.getRequestDispatcher("/news-detail.jsp").forward(req, resp);
    }
}