package com.abcnews.controller.reporter;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/reporter/edit-news")
public class EditNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        NewsDAO newsDAO = new NewsDAO();
        News news = newsDAO.findById(id);

        req.setAttribute("news", news);
        req.setAttribute("formAction", "/reporter/edit-news");
        req.getRequestDispatcher("/reporter/news-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users reporter = (Users) req.getSession().getAttribute("user");

        News news = new News();
        news.setId(req.getParameter("id"));
        news.setTitle(req.getParameter("title"));
        news.setContent(req.getParameter("content"));
        news.setImage(req.getParameter("image"));
        news.setCategoryId(req.getParameter("categoryId"));
        news.setAuthor(reporter.getId()); // Gán tác giả để xác thực

        NewsDAO newsDAO = new NewsDAO();
        newsDAO.updateNews(news);

        resp.sendRedirect(req.getContextPath() + "/reporter/manage-news");
    }
}