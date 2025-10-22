package com.abcnews.controller;

import com.abcnews.dao.UsersDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String identifier = req.getParameter("identifier"); // Lấy tham số mới
        String password = req.getParameter("password");

        UsersDAO dao = new UsersDAO();
        // Gọi phương thức mới
        Users user = dao.findUserByIdOrEmailAndPassword(identifier, password);

        if (user != null) { // Đăng nhập thành công
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/home");
        } else { // Đăng nhập thất bại
            req.setAttribute("error", "Sai Tên đăng nhập/Email hoặc Mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}