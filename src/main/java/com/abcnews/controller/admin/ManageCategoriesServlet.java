package com.abcnews.controller.admin;

import com.abcnews.dao.CategoriesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/manage-categories")
public class ManageCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CategoriesDAO dao = new CategoriesDAO();
        req.setAttribute("categoryList", dao.getAllCategories());
        req.getRequestDispatcher("/admin/manage-categories.jsp").forward(req, resp);
    }
}