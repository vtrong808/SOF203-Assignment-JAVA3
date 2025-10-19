package com.abcnews.controller.reporter;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reporter/delete-news")
public class DeleteNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Users reporter = (Users) req.getSession().getAttribute("user");

        NewsDAO newsDAO = new NewsDAO();
        newsDAO.deleteNews(id, reporter.getId());

        resp.sendRedirect(req.getContextPath() + "/reporter/manage-news");
    }
}