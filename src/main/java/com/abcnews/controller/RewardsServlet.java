package com.abcnews.controller;

import com.abcnews.dao.RewardsDAO;
import com.abcnews.model.Rewards;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/rewards")
public class RewardsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RewardsDAO rewardsDAO = new RewardsDAO();
        List<Rewards> rewardsList = rewardsDAO.getAllRewards();

        req.setAttribute("rewardsList", rewardsList);
        req.getRequestDispatcher("/rewards.jsp").forward(req, resp);
    }
}