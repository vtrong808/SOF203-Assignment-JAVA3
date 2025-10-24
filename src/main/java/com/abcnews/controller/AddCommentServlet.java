package com.abcnews.controller;

import com.abcnews.dao.CommentDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/add-comment")
public class AddCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login"); // Chuyển đến trang đăng nhập
            return;
        }

        Users user = (Users) session.getAttribute("user");
        String newsId = req.getParameter("newsId");
        String content = req.getParameter("content");

        if (content != null && !content.trim().isEmpty()) {
            CommentDAO commentDAO = new CommentDAO();
            commentDAO.addComment(newsId, user.getId(), content);
        }

        // Chuyển hướng người dùng quay lại bài viết
        resp.sendRedirect(req.getContextPath() + "/news-detail?id=" + newsId);
    }
}