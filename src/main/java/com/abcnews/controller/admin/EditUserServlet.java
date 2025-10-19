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
        UsersDAO usersDAO = new UsersDAO();
        Users user = usersDAO.findUserById(userId);

        req.setAttribute("userToEdit", user);
        req.getRequestDispatcher("/admin/user-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users user = new Users();
        user.setId(req.getParameter("id"));
        user.setFullname(req.getParameter("fullname"));
        user.setEmail(req.getParameter("email"));
        user.setRole(Integer.parseInt(req.getParameter("role")));
        user.setPoints(Integer.parseInt(req.getParameter("points")));

        UsersDAO usersDAO = new UsersDAO();
        usersDAO.updateUserByAdmin(user);

        resp.sendRedirect(req.getContextPath() + "/admin/manage-users");
    }
}