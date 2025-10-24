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

@WebServlet("/toggle-save")
public class ToggleSaveServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.setStatus(401); // 401 Unauthorized
            return;
        }

        Users user = (Users) session.getAttribute("user");
        String newsId = req.getParameter("newsId");

        InteractionDAO dao = new InteractionDAO();
        boolean isNowSaved = dao.toggleSaveArticle(newsId, user.getId());

        // Trả về trạng thái mới (đã lưu hay chưa)
        resp.setContentType("application/json");
        resp.getWriter().write("{\"isSaved\": " + isNowSaved + "}");
    }
}