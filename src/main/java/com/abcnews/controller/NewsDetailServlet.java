package com.abcnews.controller;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/news-detail")
public class NewsDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        NewsDAO dao = new NewsDAO();

        if (id != null && !id.isEmpty()) {
            dao.incrementViewCount(id); // Tăng lượt xem trước khi lấy dữ liệu
        }

        News news = dao.findById(id);

        req.setAttribute("news", news);
        req.getRequestDispatcher("/news-detail.jsp").forward(req, resp);
    }
}