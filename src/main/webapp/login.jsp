<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - ABC News</title>
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
</head>
<body>
    <div class="auth-container"> <%-- << DI CHUYỂN RA NGOÀI ĐÂY --%>
        <div class="auth-form">
            <h1>Đăng nhập</h1>

            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>

            <div class="traditional-auth-form">
                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="form-group">
                        <label for="identifier">Tên đăng nhập hoặc Email</label>
                        <input type="text" id="identifier" name="identifier" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" class="form-button">Đăng nhập</button>
                </form>
            </div>

            <div class="google-signin-separator">hoặc</div>

            <div id="g_id_onload"
                 data-client_id="310151028929-j3jo2igob50v5qsi8kp9p0v2i920v3fm.apps.googleusercontent.com"
                 data-callback="handleCredentialResponse">
            </div>
            <div class="google-signin-container">
                <div class="g_id_signin" data-type="standard"></div>
            </div>

            <p class="auth-switch">Chưa có tài khoản?
                 <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
            </p>
        </div>
    </div> <%-- << KẾT THÚC auth-container Ở ĐÂY --%>

    <script>
        function handleCredentialResponse(response) {
            console.log("Encoded JWT ID token: " + response.credential);
            fetch('${pageContext.request.contextPath}/google-auth', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'idToken=' + encodeURIComponent(response.credential) // encodeURIComponent là tốt
            }).then(res => {
                if (res.ok) {
                    window.location.href = '${pageContext.request.contextPath}/home';
                } else {
                    alert('Đăng nhập bằng Google thất bại!');
                }
            }).catch(err => {
                console.error('Lỗi khi gửi yêu cầu Google Auth:', err);
                alert('Không thể kết nối máy chủ. Vui lòng thử lại!');
            });
        }
    </script>
</body>
</html>