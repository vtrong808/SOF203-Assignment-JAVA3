package com.abcnews.controller.admin;

import com.abcnews.dao.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/delete-news")
public class DeleteNewsAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        NewsDAO newsDAO = new NewsDAO();
        newsDAO.deleteNewsByAdmin(id);
        resp.sendRedirect(req.getContextPath() + "/admin/manage-news");
    }
}