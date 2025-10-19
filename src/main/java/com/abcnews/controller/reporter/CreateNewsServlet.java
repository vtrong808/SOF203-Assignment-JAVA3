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
import java.util.UUID;

@WebServlet(urlPatterns = {"/reporter/create-news"})
public class CreateNewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("formAction", "/reporter/create-news");
        req.getRequestDispatcher("/reporter/news-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users reporter = (Users) req.getSession().getAttribute("user");

        News news = new News();
        news.setId(UUID.randomUUID().toString()); // Tạo ID ngẫu nhiên
        news.setTitle(req.getParameter("title"));
        news.setContent(req.getParameter("content"));
        news.setImage(req.getParameter("image"));
        news.setCategoryId(req.getParameter("categoryId"));
        news.setAuthor(reporter.getId()); // Gán tác giả
        news.setHome(false); // Mặc định không lên trang chủ

        NewsDAO newsDAO = new NewsDAO();
        newsDAO.insertNews(news);

        resp.sendRedirect(req.getContextPath() + "/reporter/manage-news");
    }
}