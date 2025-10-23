package com.abcnews.controller.admin;

import com.abcnews.dao.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/approve-news")
public class ApproveNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            NewsDAO newsDAO = new NewsDAO();
            newsDAO.approveNews(id);
        }
        // Quay lại trang quản lý tin tức
        resp.sendRedirect(req.getContextPath() + "/admin/manage-news");
    }
}