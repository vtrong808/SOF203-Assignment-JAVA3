package com.abcnews.controller.reporter;

import com.abcnews.dao.NewsDAO;
import com.abcnews.model.News;
import com.abcnews.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig; // <-- THÊM IMPORT
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part; // <-- THÊM IMPORT

import java.io.File; // <-- THÊM IMPORT
import java.io.IOException;
import java.util.UUID;

@WebServlet(urlPatterns = {"/reporter/create-news"})
@MultipartConfig // <-- THÊM ANNOTATION
public class CreateNewsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("formAction", "/reporter/create-news");
        req.getRequestDispatcher("/reporter/news-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users reporter = (Users) req.getSession().getAttribute("user");

        News news = new News();
        news.setId(UUID.randomUUID().toString().substring(0, 19)); // Tạo ID (rút ngắn)
        news.setTitle(req.getParameter("title"));
        news.setContent(req.getParameter("content"));
        news.setCategoryId(req.getParameter("categoryId"));
        news.setAuthor(reporter.getId());
        news.setHome(false);
        news.setApproved(false);

        // --- XỬ LÝ UPLOAD HÌNH ẢNH ---
        Part filePart = req.getPart("imageFile");
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            // Định nghĩa đường dẫn lưu file
            String uploadPath = getServletContext().getRealPath("") + "images" + File.separator + "news";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + fileName);

            // Đường dẫn lưu vào CSDL
            String dbPath = "images/news/" + fileName;
            news.setImage(dbPath);
        } else {
            news.setImage("images/default.jpg"); // Hoặc null tùy bạn
        }
        // -----------------------------

        NewsDAO newsDAO = new NewsDAO();
        newsDAO.insertNews(news);

        resp.sendRedirect(req.getContextPath() + "/reporter/manage-news");
    }
}