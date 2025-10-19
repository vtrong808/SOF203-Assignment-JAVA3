package com.abcnews.controller;

import com.abcnews.dao.CategoriesDAO;
import com.abcnews.dao.NewsDAO;
import com.abcnews.model.Categories;
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
        String categoryId = req.getParameter("id");

        NewsDAO newsDAO = new NewsDAO();
        CategoriesDAO categoriesDAO = new CategoriesDAO();

        List<News> newsList = newsDAO.getNewsByCategoryId(categoryId, 20);
        Categories category = categoriesDAO.findById(categoryId);

        req.setAttribute("newsList", newsList);
        req.setAttribute("category", category); // Gửi cả đối tượng category đi

        req.getRequestDispatcher("/category.jsp").forward(req, resp);
    }
}