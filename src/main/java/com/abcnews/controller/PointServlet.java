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

@WebServlet("/add-point")
public class PointServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // Chỉ cộng điểm khi người dùng đã đăng nhập VÀ là độc giả (role=0)
        if (session != null && session.getAttribute("user") != null) {
            Users user = (Users) session.getAttribute("user");
            if (user.getRole() == 0) { // 0 là vai trò Độc giả
                UsersDAO usersDAO = new UsersDAO();
                usersDAO.addPoints(user.getId(), 10); // Cộng 10 điểm
                System.out.println("Added 10 points for user: " + user.getId());
            }
        }
    }
}