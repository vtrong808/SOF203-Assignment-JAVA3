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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException; // Thêm import
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/statistics")
public class StatisticsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String filter = req.getParameter("filter");
        String startDateStr = req.getParameter("startDate");
        String endDateStr = req.getParameter("endDate");

        LocalDateTime startDate = null;
        LocalDateTime endDate = null;
        String activeFilter = filter;
        String dateError = null; // Biến lưu thông báo lỗi

        try {
            // Ưu tiên lọc theo khoảng ngày tùy chỉnh nếu có
            if (startDateStr != null && !startDateStr.isEmpty() && endDateStr != null && !endDateStr.isEmpty()) {
                LocalDate start = LocalDate.parse(startDateStr);
                LocalDate end = LocalDate.parse(endDateStr);

                // KIỂM TRA LỖI NGÀY BẮT ĐẦU > NGÀY KẾT THÚC
                if (start.isAfter(end)) {
                    dateError = "Lỗi: Ngày bắt đầu không được lớn hơn ngày kết thúc!";
                    activeFilter = null; // Reset filter
                } else {
                    startDate = start.atStartOfDay();
                    endDate = end.atTime(LocalTime.MAX);
                    activeFilter = "custom"; // Đánh dấu là đang lọc tùy chỉnh
                }

            } else if (filter != null && !filter.equals("all") ) { // Thêm điều kiện !filter.equals("all")
                // Nếu không có ngày tùy chỉnh VÀ không có lỗi, xử lý các bộ lọc nhanh
                LocalDate today = LocalDate.now();
                endDate = LocalDateTime.now(); // Mặc định là đến hiện tại

                if ("day".equals(filter)) {
                    startDate = today.atStartOfDay();
                } else if ("week".equals(filter)) {
                    startDate = today.with(TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY)).atStartOfDay();
                } else if ("month".equals(filter)) {
                    startDate = today.with(TemporalAdjusters.firstDayOfMonth()).atStartOfDay();
                } else if ("year".equals(filter)) {
                    startDate = today.with(TemporalAdjusters.firstDayOfYear()).atStartOfDay();
                } else {
                    activeFilter = null; // Reset nếu filter không hợp lệ
                }
            } else {
                activeFilter = null; // Mặc định là 'all' nếu không có filter nào
            }
            // Nếu không có filter và không có ngày tùy chỉnh, startDate và endDate sẽ là null (lấy tất cả)

        } catch (DateTimeParseException e) {
            dateError = "Lỗi: Định dạng ngày tháng không hợp lệ!";
            System.err.println("Lỗi parse ngày tháng: " + e.getMessage());
            activeFilter = null; // Reset filter nếu ngày không hợp lệ
        }

        NewsDAO newsDAO = new NewsDAO();
        UsersDAO usersDAO = new UsersDAO();

        // Chỉ lấy dữ liệu khi không có lỗi ngày tháng
        List<News> statisticsList = null;
        if (dateError == null) {
            statisticsList = newsDAO.getNewsSortedByViewsFilteredByDate(startDate, endDate);
        } else {
            statisticsList = newsDAO.getNewsSortedByViewsFilteredByDate(null, null); // Hoặc trả về danh sách rỗng tùy ý
        }


        Map<String, String> userMap = usersDAO.getAllUsersAndReporters().stream()
                .collect(Collectors.toMap(Users::getId, Users::getFullname));

        req.setAttribute("statisticsList", statisticsList);
        req.setAttribute("userMap", userMap);
        req.setAttribute("activeFilter", activeFilter);
        req.setAttribute("startDateValue", startDateStr);
        req.setAttribute("endDateValue", endDateStr);
        req.setAttribute("dateError", dateError); // Gửi thông báo lỗi (nếu có)

        req.getRequestDispatcher("/admin/statistics.jsp").forward(req, resp);
    }
}