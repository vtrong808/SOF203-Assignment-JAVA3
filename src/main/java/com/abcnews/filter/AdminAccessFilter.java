package com.abcnews.filter;

import com.abcnews.model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAccessFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (session != null && session.getAttribute("user") != null) {
            Users user = (Users) session.getAttribute("user");
            // Kiểm tra xem người dùng có phải là Admin (role == 2) không
            if (user.getRole() == 2) {
                // Nếu đúng, cho phép tiếp tục truy cập
                chain.doFilter(request, response);
            } else {
                // Nếu đăng nhập nhưng không phải Admin, chuyển hướng về trang chủ
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}