package com.abcnews.controller;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsServlet", urlPatterns = {"/admin/manage-news"})
public class NewsServlet extends HttpServlet {

    private final NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách tin tức từ DAO
        List<News> newsList = newsDAO.getAllNews();

        // Đặt danh sách tin tức vào request attribute
        request.setAttribute("newsList", newsList);

        // Chuyển tiếp yêu cầu đến trang JSP để hiển thị
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/news.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Xử lý các yêu cầu POST (thêm, sửa, xóa) trong các bước sau
    }
}