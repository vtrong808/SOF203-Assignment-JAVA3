<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - ABC News</title>

    <!-- Google Sign-In Integration -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-form">
        <h1>Đăng ký</h1>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>

        <!-- Form đăng ký truyền thống -->
        <div class="traditional-auth-form">
            <form action="${pageContext.request.contextPath}/register" method="POST">
                <div class="form-group">
                    <label for="fullname">Họ và tên</label>
                    <input type="text" id="fullname" name="fullname" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required minlength="6">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6">
                </div>

                <button type="submit" class="form-button">Đăng ký</button>
            </form>
        </div>

        <!-- Đường kẻ phân cách -->
        <div class="google-signin-separator">hoặc</div>

        <!-- Google Sign-in -->
        <div id="g_id_onload"
             data-client_id="310151028929-j3jo2igob50v5qsi8kp9p0v2i920v3fm.apps.googleusercontent.com"
             data-callback="handleCredentialResponse">
        </div>
        <div class="google-signin-container">
            <div class="g_id_signin" data-type="standard"></div>
        </div>

        <p class="auth-switch">Đã có tài khoản?
            <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
        </p>
    </div>
</div>

<script>
    // Xử lý đăng ký bằng Google
    function handleCredentialResponse(response) {
        console.log("Encoded JWT ID token: " + response.credential);
        fetch('${pageContext.request.contextPath}/google-register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'idToken=' + encodeURIComponent(response.credential)
        }).then(res => {
            if (res.ok) {
                window.location.href = '${pageContext.request.contextPath}/home';
            } else {
                alert('Tài khoản đã tồn tại!');
            }
        }).catch(err => {
            console.error('Lỗi khi gửi yêu cầu Google Register:', err);
            alert('Không thể kết nối máy chủ. Vui lòng thử lại!');
        });
    }

    // Kiểm tra khớp mật khẩu
    document.querySelector("form").addEventListener("submit", function(e) {
        const pass = document.getElementById("password").value;
        const confirm = document.getElementById("confirmPassword").value;
        if (pass !== confirm) {
            e.preventDefault();
            alert("Mật khẩu xác nhận không khớp!");
        }
    });
</script>
</body>
</html>
