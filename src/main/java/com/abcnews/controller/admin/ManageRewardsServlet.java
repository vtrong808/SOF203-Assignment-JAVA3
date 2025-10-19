package com.abcnews.controller.admin;

import com.abcnews.dao.RewardsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/manage-rewards")
public class ManageRewardsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RewardsDAO dao = new RewardsDAO();
        req.setAttribute("rewardList", dao.getAllRewards());
        req.getRequestDispatcher("/admin/manage-rewards.jsp").forward(req, resp);
    }
}