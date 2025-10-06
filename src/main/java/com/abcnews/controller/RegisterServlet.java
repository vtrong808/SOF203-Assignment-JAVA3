package com.abcnews.controller;

import com.abcnews.dao.UsersDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;

@WebServlet(urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Users user = new Users();
            BeanUtils.populate(user, req.getParameterMap());

            UsersDAO dao = new UsersDAO();
            dao.insertUser(user);

            // Chuyển hướng đến trang đăng nhập sau khi đăng ký thành công
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}