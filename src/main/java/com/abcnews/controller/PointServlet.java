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
        if (session != null && session.getAttribute("user") != null) {
            Users user = (Users) session.getAttribute("user");
            if (user.getRole() == 0 || user.getRole() == 1) { // 0=Độc giả, 1=Phóng viên
                UsersDAO usersDAO = new UsersDAO();
                int pointsToAdd = 10; // Số điểm cộng
                usersDAO.addPoints(user.getId(), pointsToAdd);

                // === DÒNG MÃ MỚI: Cập nhật lại điểm trong session ===
                int newPoints = user.getPoints() + pointsToAdd;
                user.setPoints(newPoints);
                session.setAttribute("user", user); // Lưu lại user đã được cập nhật
                // =======================================================

                System.out.println("Added 10 points for user: " + user.getId());
                resp.setStatus(HttpServletResponse.SC_OK); // Trả về status 200 OK
            }
        }
    }
}