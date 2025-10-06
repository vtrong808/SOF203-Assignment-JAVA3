package com.abcnews.controller;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"", "/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAO();

        // --- Dữ liệu cho phần đầu trang ---
        List<News> latestNews = newsDAO.getLatestNews(6);
        List<News> mostViewedNews = newsDAO.getMostViewedNews(5);

        if (latestNews != null && !latestNews.isEmpty()) {
            req.setAttribute("featuredNews", latestNews.get(0));
            req.setAttribute("otherLatestNews", latestNews.subList(1, latestNews.size()));
        }
        req.setAttribute("mostViewedNews", mostViewedNews);

        // --- Dữ liệu cho các khối chuyên mục ---
        // Lấy 5 tin tức thuộc danh mục 'CN' (Công nghệ)
        List<News> techNews = newsDAO.getNewsByCategoryId("CN", 5);
        req.setAttribute("techNews", techNews);

        // Lấy 5 tin tức thuộc danh mục 'TT' (Thể thao)
        List<News> sportNews = newsDAO.getNewsByCategoryId("TT", 5);
        req.setAttribute("sportNews", sportNews);

        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}