package com.abcnews.controller.admin;

import com.abcnews.dao.CategoriesDAO;
import com.abcnews.model.Categories;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/edit-category")
public class EditCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) { // Chế độ sửa
            CategoriesDAO dao = new CategoriesDAO();
            req.setAttribute("category", dao.findById(id));
        }
        // Nếu id là null, trang sẽ ở chế độ thêm mới
        req.getRequestDispatcher("/admin/category-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");

        CategoriesDAO dao = new CategoriesDAO();
        Categories cat = new Categories();
        cat.setName(name);

        if (id != null && !id.isEmpty()) { // Cập nhật
            cat.setId(id);
            dao.updateCategory(cat);
        } else { // Thêm mới
            // Bạn cần tự tạo ID mới, ví dụ dùng 2 chữ cái đầu
            String newId = name.substring(0, 2).toUpperCase();
            cat.setId(newId);
            dao.addCategory(cat);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-categories");
    }
}