package com.abcnews.controller.admin;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.UsersDAO;
import com.abcnews.model.News;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/manage-news")
public class ManageNewsAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String authorFilter = req.getParameter("authorFilter");

        NewsDAO newsDAO = new NewsDAO();
        UsersDAO usersDAO = new UsersDAO();

        List<News> allNews = newsDAO.getAllNewsForAdmin();

        // Lấy danh sách phóng viên để đổ vào dropdown
        List<Users> reporters = usersDAO.getAllReporters();

        // Tạo Map để lấy tên đầy đủ từ ID
        Map<String, String> userMap = usersDAO.getAllUsersAndReporters().stream()
                .collect(Collectors.toMap(Users::getId, Users::getFullname));

        List<News> newsListToShow;

        // Nếu có yêu cầu lọc và không phải là "all"
        if (authorFilter != null && !authorFilter.isEmpty() && !authorFilter.equals("all")) {
            newsListToShow = allNews.stream()
                    .filter(news -> authorFilter.equals(news.getAuthor()))
                    .collect(Collectors.toList());
        } else {
            newsListToShow = allNews;
        }

        req.setAttribute("newsList", newsListToShow);
        req.setAttribute("reporterList", reporters); // Gửi danh sách phóng viên
        req.setAttribute("userMap", userMap);

        req.getRequestDispatcher("/admin/manage-news.jsp").forward(req, resp);
    }
}