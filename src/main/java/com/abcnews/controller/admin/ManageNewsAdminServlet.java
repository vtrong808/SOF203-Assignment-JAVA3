package com.abcnews.controller.admin;

import com.abcnews.dao.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/manage-news")
public class ManageNewsAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAO();
        req.setAttribute("newsList", newsDAO.getAllNews()); // Lấy tất cả tin tức
        req.getRequestDispatcher("/admin/manage-news.jsp").forward(req, resp);
    }
}