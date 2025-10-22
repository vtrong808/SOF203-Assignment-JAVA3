package com.abcnews.controller;

import com.abcnews.dao.UsersDAO;
import com.abcnews.model.Users;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.UUID; // Dùng để tạo mật khẩu ngẫu nhiên

@WebServlet("/google-auth")
public class GoogleAuthServlet extends HttpServlet {

    // !!! THAY BẰNG CLIENT ID CỦA BẠN MÀ BẠN ĐÃ ĐẶT TRONG JSP !!!
    private static final String GOOGLE_CLIENT_ID = "310151028929-j3jo2igob50v5qsi8kp9p0v2i920v3fm.apps.googleusercontent.com";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idTokenString = req.getParameter("idToken");

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), GsonFactory.getDefaultInstance())
                .setAudience(Collections.singletonList(GOOGLE_CLIENT_ID))
                .build();

        GoogleIdToken idToken = null;
        try {
            idToken = verifier.verify(idTokenString);
        } catch (GeneralSecurityException e) {
            System.err.println("Lỗi xác thực token: " + e.getMessage());
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Lỗi xác thực
            return;
        }

        if (idToken != null) {
            GoogleIdToken.Payload payload = idToken.getPayload();

            String email = payload.getEmail();
            String name = (String) payload.get("name");

            UsersDAO usersDAO = new UsersDAO();
            Users user = usersDAO.findUserByEmail(email); // Kiểm tra xem user đã tồn tại chưa

            if (user == null) {
                // CHƯA TỒN TẠI -> Tự động đăng ký
                user = new Users();
                user.setId("google_" + payload.getSubject()); // Dùng Google Subject ID để đảm bảo ID là duy nhất
                user.setEmail(email);
                user.setFullname(name);
                user.setPassword(UUID.randomUUID().toString()); // Tạo mật khẩu ngẫu nhiên (vì không dùng đến)
                user.setRole(0); // Vai trò mặc định là Độc giả
                user.setPoints(0);
                usersDAO.addUserByAdmin(user); // Dùng lại hàm 'addUserByAdmin' để thêm user mới
            }

            // ĐÃ TỒN TẠI hoặc VỪA TẠO MỚI -> Đăng nhập
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.setStatus(HttpServletResponse.SC_OK); // Trả về 200 OK
            System.out.println("Đăng nhập/Đăng ký Google thành công: " + email);

        } else {
            System.err.println("Invalid ID token.");
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}