package com.abcnews.controller.admin;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/edit-news")
public class EditNewsAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        NewsDAO newsDAO = new NewsDAO();
        News news = newsDAO.findById(id);

        req.setAttribute("news", news);
        req.setAttribute("formAction", "/admin/edit-news"); // Action trỏ về servlet admin
        // Tái sử dụng form của phóng viên
        req.getRequestDispatcher("/reporter/news-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        News news = new News();
        news.setId(req.getParameter("id"));
        news.setTitle(req.getParameter("title"));
        news.setContent(req.getParameter("content"));
        news.setImage(req.getParameter("image"));
        news.setCategoryId(req.getParameter("categoryId"));
        // Admin có thể bật/tắt hiển thị trang chủ (nếu bạn muốn thêm chức năng này vào form)
        // news.setHome(Boolean.parseBoolean(req.getParameter("home")));

        NewsDAO newsDAO = new NewsDAO();
        newsDAO.updateNewsByAdmin(news);

        resp.sendRedirect(req.getContextPath() + "/admin/manage-news");
    }
}