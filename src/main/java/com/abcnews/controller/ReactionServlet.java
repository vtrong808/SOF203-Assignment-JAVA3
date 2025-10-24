package com.abcnews.controller;

import com.abcnews.dao.InteractionDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/react")
public class ReactionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.setStatus(401); // 401 Unauthorized
            return;
        }

        Users user = (Users) session.getAttribute("user");
        String newsId = req.getParameter("newsId");
        int reactionType = Integer.parseInt(req.getParameter("type"));

        InteractionDAO dao = new InteractionDAO();
        dao.addOrUpdateReaction(newsId, user.getId(), reactionType);

        resp.setStatus(200); // OK
    }
}