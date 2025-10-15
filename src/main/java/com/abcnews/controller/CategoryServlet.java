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

@WebServlet(urlPatterns = "/category")
public class CategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy mã danh mục từ URL (ví dụ: ?id=CN)
        String categoryId = req.getParameter("id");

        NewsDAO newsDAO = new NewsDAO();
        // Lấy tất cả tin tức thuộc danh mục này (giả sử lấy tối đa 20 tin)
        List<News> newsList = newsDAO.getNewsByCategoryId(categoryId, 20);

        // Gửi danh sách tin tức qua cho JSP
        req.setAttribute("newsList", newsList);
        // Gửi cả mã danh mục để biết đang ở trang nào
        req.setAttribute("categoryId", categoryId);

        // Sử dụng RequestDispatcher để chuyển tiếp đến category.jsp
        req.getRequestDispatcher("/category.jsp").forward(req, resp);
    }
}