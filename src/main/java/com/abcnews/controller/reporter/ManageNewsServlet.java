package com.abcnews.controller.reporter;

import com.abcnews.dao.NewsDAO;
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
import java.util.stream.Collectors;

@WebServlet("/reporter/manage-news")
public class ManageNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users reporter = (Users) session.getAttribute("user");

        NewsDAO newsDAO = new NewsDAO();
        // Lấy tất cả tin tức và lọc ra những tin của phóng viên này
        List<News> allNews = newsDAO.getAllNews();
        List<News> reporterNews = newsDAO.getAllNewsByAuthor(reporter.getId());

        req.setAttribute("newsList", reporterNews);
        req.getRequestDispatcher("/reporter/manage-news.jsp").forward(req, resp);
    }
}