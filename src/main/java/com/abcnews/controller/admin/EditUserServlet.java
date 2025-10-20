package com.abcnews.controller.admin;

import com.abcnews.dao.UsersDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/edit-user")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        // Nếu có ID, đây là chế độ SỬA -> lấy thông tin user
        if (userId != null && !userId.isEmpty()) {
            UsersDAO usersDAO = new UsersDAO();
            Users user = usersDAO.findUserById(userId);
            req.setAttribute("userToEdit", user);
        }
        // Nếu không có ID, đây là chế độ THÊM MỚI -> chỉ cần forward tới form trống

        req.getRequestDispatcher("/admin/user-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        UsersDAO usersDAO = new UsersDAO();

        // Nếu có ID, đây là hành động CẬP NHẬT
        if (id != null && !id.isEmpty()) {
            Users user = new Users();
            user.setId(id);
            user.setFullname(req.getParameter("fullname"));
            user.setEmail(req.getParameter("email"));
            user.setRole(Integer.parseInt(req.getParameter("role")));
            user.setPoints(Integer.parseInt(req.getParameter("points")));
            usersDAO.updateUserByAdmin(user);
        } else { // Nếu không có ID, đây là hành động TẠO MỚI
            Users user = new Users();
            user.setId(req.getParameter("newId")); // Lấy ID mới từ form
            user.setPassword(req.getParameter("password")); // Lấy mật khẩu từ form
            user.setFullname(req.getParameter("fullname"));
            user.setEmail(req.getParameter("email"));
            user.setRole(Integer.parseInt(req.getParameter("role")));
            user.setPoints(Integer.parseInt(req.getParameter("points")));
            usersDAO.addUserByAdmin(user);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-users");
    }
}