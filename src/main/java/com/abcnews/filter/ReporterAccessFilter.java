package com.abcnews.filter;

import com.abcnews.model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/reporter/*")
public class ReporterAccessFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            Users user = (Users) session.getAttribute("user");
            boolean isReporter = (user.getRole() == 1);
            if(isReporter){
                // Cho phép truy cập
                chain.doFilter(request, response);
            } else {
                // Đăng nhập nhưng không phải phóng viên -> về trang chủ
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            // Chưa đăng nhập -> về trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}