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

@WebServlet("/redeem")
public class RedeemRewardServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("user");

        // Lấy thông tin vật phẩm từ form
        String rewardName = req.getParameter("rewardName");
        int pointsRequired = Integer.parseInt(req.getParameter("pointsRequired"));

        // Kiểm tra lại lần nữa ở server để đảm bảo an toàn
        if (user != null && user.getPoints() >= pointsRequired) {
            UsersDAO usersDAO = new UsersDAO();
            boolean success = usersDAO.subtractPoints(user.getId(), pointsRequired);

            if (success) {
                // Cập nhật lại điểm trong session
                int newPoints = user.getPoints() - pointsRequired;
                user.setPoints(newPoints);
                session.setAttribute("user", user);

                // Tạo thông báo thành công
                session.setAttribute("redeem_success", "Bạn đã đổi thành công vật phẩm: '" + rewardName + "'!");
            } else {
                session.setAttribute("redeem_error", "Có lỗi xảy ra, không thể đổi thưởng. Vui lòng thử lại.");
            }
        } else {
            session.setAttribute("redeem_error", "Bạn không đủ điểm để đổi vật phẩm này.");
        }

        // Chuyển hướng người dùng trở lại trang đổi thưởng
        resp.sendRedirect(req.getContextPath() + "/rewards");
    }
}