package com.abcnews.controller.admin;

import com.abcnews.dao.RewardsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/delete-reward")
public class DeleteRewardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        RewardsDAO dao = new RewardsDAO();
        dao.deleteReward(id);
        resp.sendRedirect(req.getContextPath() + "/admin/manage-rewards");
    }
}