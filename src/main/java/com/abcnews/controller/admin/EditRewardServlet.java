package com.abcnews.controller.admin;

import com.abcnews.dao.RewardsDAO;
import com.abcnews.model.Rewards;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/admin/edit-reward")
@MultipartConfig
public class EditRewardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            RewardsDAO dao = new RewardsDAO();
            req.setAttribute("reward", dao.findRewardById(id));
        }
        req.getRequestDispatcher("/admin/reward-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        RewardsDAO dao = new RewardsDAO();
        Rewards reward = new Rewards();

        // XỬ LÝ UPLOAD FILE
        Part filePart = req.getPart("imageFile"); // Lấy file từ request
        String fileName = filePart.getSubmittedFileName();

        // Đường dẫn tuyệt đối để lưu file trên server
        String uploadPath = getServletContext().getRealPath("") + "images" + File.separator + "rewards";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        filePart.write(uploadPath + File.separator + fileName);

        // Đường dẫn tương đối để lưu vào CSDL
        String dbPath = "images/rewards/" + fileName;

        // Lấy các thông tin khác từ form
        reward.setName(req.getParameter("name"));
        reward.setPointsRequired(Integer.parseInt(req.getParameter("pointsRequired")));
        reward.setImage(dbPath); // <-- Lưu đường dẫn mới vào đối tượng

        if (id != null && !id.trim().isEmpty()) { // Cập nhật
            reward.setId(id);
            dao.updateReward(reward);
        } else { // Thêm mới
            reward.setId(req.getParameter("newId"));
            dao.addReward(reward);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/manage-rewards");
    }
}