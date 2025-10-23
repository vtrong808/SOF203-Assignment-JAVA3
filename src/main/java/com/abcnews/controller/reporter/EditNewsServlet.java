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

@WebServlet("/reporter/edit-news")
@MultipartConfig // <-- THÊM ANNOTATION
public class EditNewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        NewsDAO newsDAO = new NewsDAO();
        News news = newsDAO.findById(id);

        req.setAttribute("news", news);
        req.setAttribute("formAction", "/reporter/edit-news");
        req.getRequestDispatcher("/reporter/news-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Users reporter = (Users) req.getSession().getAttribute("user");

        News news = new News();
        news.setId(req.getParameter("id"));
        news.setTitle(req.getParameter("title"));
        news.setContent(req.getParameter("content"));
        news.setCategoryId(req.getParameter("categoryId"));
        news.setAuthor(reporter.getId()); // Gán tác giả để xác thực quyền

        // --- XỬ LÝ UPLOAD HÌNH ẢNH KHI SỬA ---
        Part filePart = req.getPart("imageFile");
        String fileName = filePart.getSubmittedFileName();

        if (fileName != null && !fileName.isEmpty()) {
            // Người dùng đã chọn file mới
            String uploadPath = getServletContext().getRealPath("") + "images" + File.separator + "news";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);

            String dbPath = "images/news/" + fileName;
            news.setImage(dbPath); // Cập nhật ảnh mới
        } else {
            // Người dùng không chọn file mới, giữ nguyên ảnh cũ
            news.setImage(req.getParameter("existingImage"));
        }
        // ------------------------------------

        NewsDAO newsDAO = new NewsDAO();
        newsDAO.updateNews(news);

        resp.sendRedirect(req.getContextPath() + "/reporter/manage-news");
    }
}