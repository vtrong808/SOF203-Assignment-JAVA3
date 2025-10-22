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

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy email thay vì id
        String email = req.getParameter("email"); // << THAY ĐỔI Ở ĐÂY
        String password = req.getParameter("password");

        UsersDAO dao = new UsersDAO();
        // Gọi phương thức mới findUserByEmailAndPassword
        Users user = dao.findUserByEmailAndPassword(email, password); // << THAY ĐỔI Ở ĐÂY

        if (user != null) { // Đăng nhập thành công
            HttpSession session = req.getSession();
            // Lưu ý: Không nên lưu password vào session vì lý do bảo mật
            // Đối tượng user trả về từ DAO đã không bao gồm password (nếu bạn sửa DAO)
            // Hoặc bạn có thể set password thành null trước khi lưu vào session:
            // user.setPassword(null);
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/home");
        } else { // Đăng nhập thất bại
            req.setAttribute("error", "Sai email hoặc mật khẩu!"); // Cập nhật thông báo lỗi
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}