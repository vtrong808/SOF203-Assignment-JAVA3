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

@WebServlet("/verify-otp")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("tempUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/register");
            return;
        }
        req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String enteredOtp = req.getParameter("otp");

        if (session == null || session.getAttribute("tempUser") == null || session.getAttribute("otpCode") == null || session.getAttribute("otpExpiry") == null) {
            req.setAttribute("error", "Phiên làm việc hết hạn. Vui lòng thử đăng ký lại.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        Users tempUser = (Users) session.getAttribute("tempUser");
        String correctOtp = (String) session.getAttribute("otpCode");
        long expiryTime = (long) session.getAttribute("otpExpiry");

        if (System.currentTimeMillis() > expiryTime) {
            session.removeAttribute("tempUser");
            session.removeAttribute("otpCode");
            session.removeAttribute("otpExpiry");
            req.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng thử đăng ký lại.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (enteredOtp != null && enteredOtp.equals(correctOtp)) {
            UsersDAO dao = new UsersDAO();
            dao.insertUser(tempUser); // Lưu user vào CSDL

            session.removeAttribute("tempUser");
            session.removeAttribute("otpCode");
            session.removeAttribute("otpExpiry");

            session.setAttribute("register_success", "Đăng ký thành công! Vui lòng đăng nhập.");
            resp.sendRedirect(req.getContextPath() + "/login");

        } else {
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng thử lại.");
            req.getRequestDispatcher("/verify-otp.jsp").forward(req, resp);
        }
    }
}