package com.abcnews.controller;

import com.abcnews.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/subscribe")
public class NewsletterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email != null && !email.isEmpty()) {
            // TODO: Thêm logic lưu email vào CSDL ở đây (sử dụng NewsletterDAO)

            // Gửi email xác nhận
            String subject = "Cảm ơn bạn đã đăng ký nhận tin từ ABC News!";
            String body = "<h1>Đăng ký thành công!</h1><p>Bạn đã đăng ký nhận bản tin từ ABC News với email: " + email + "</p>";
            EmailUtil.sendEmail(email, subject, body);
        }
        // Chuyển hướng người dùng về lại trang trước đó
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
    }
}