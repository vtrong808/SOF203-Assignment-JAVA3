package com.abcnews.controller;

import com.abcnews.dao.UsersDAO;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;

@WebServlet(urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Users user = new Users();
            BeanUtils.populate(user, req.getParameterMap());

            UsersDAO dao = new UsersDAO();
            // 1. Kiểm tra email đã tồn tại chưa
            if (dao.findUserByEmail(user.getEmail()) != null) {
                req.setAttribute("error", "Email này đã được sử dụng!");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            // 2. Tạo mã OTP (6 chữ số)
            String otp = String.format("%06d", new java.util.Random().nextInt(999999));
            System.out.println("Generated OTP for " + user.getEmail() + ": " + otp); // In ra console để test

            // 3. Lưu tạm thông tin người dùng và OTP vào session (có thời hạn 5 phút)
            HttpSession session = req.getSession();
            session.setAttribute("tempUser", user);
            session.setAttribute("otpCode", otp);
            session.setAttribute("otpExpiry", System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút

            // 4. Gửi email chứa mã OTP (sử dụng EmailUtil bạn đã có)
            String subject = "Xác thực địa chỉ email cho ABC News";
            String body = "<h1>Chào " + user.getFullname() + ",</h1>"
                    + "<p>Mã OTP để xác nhận đăng ký tài khoản của bạn là:</p>"
                    + "<h2 style='color: #FFB6C1;'>" + otp + "</h2>"
                    + "<p>Mã này sẽ hết hạn sau 5 phút.</p>";
            com.abcnews.util.EmailUtil.sendEmail(user.getEmail(), subject, body);

            // 5. Chuyển hướng đến trang nhập OTP
            resp.sendRedirect(req.getContextPath() + "/verify-otp.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng ký.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}