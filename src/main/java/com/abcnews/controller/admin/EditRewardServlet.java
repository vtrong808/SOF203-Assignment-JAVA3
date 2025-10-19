package com.abcnews.controller.admin;

import com.abcnews.dao.RewardsDAO;
import com.abcnews.model.Rewards;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/edit-reward")
public class EditRewardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            RewardsDAO dao = new RewardsDAO();
            req.setAttribute("reward", dao.findRewardById(id));
        }
        req.getRequestDispatcher("/admin/reward-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Rewards reward = new Rewards();
        reward.setName(req.getParameter("name"));
        reward.setPointsRequired(Integer.parseInt(req.getParameter("pointsRequired")));
        reward.setImage(req.getParameter("image"));

        RewardsDAO dao = new RewardsDAO();

        if (id != null && !id.trim().isEmpty()) { // Cập nhật
            reward.setId(id);
            dao.updateReward(reward);
        } else { // Thêm mới
            reward.setId(req.getParameter("newId")); // Lấy ID mới từ form
            dao.addReward(reward);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-rewards");
    }
}