<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

    <!-- Nút Đăng ký / Đăng nhập bằng Google -->
    <div id="g_id_onload"
             data-client_id="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com"
             data-callback="handleCredentialResponse">
        </div>
        <div class="google-signin-container">
            <div class="g_id_signin" data-type="standard"></div>
        </div>

    <script>
        function handleCredentialResponse(response) {
            console.log("Encoded JWT ID token: " + response.credential);
            // Gửi ID Token lên backend để xác thực
            fetch('${pageContext.request.contextPath}/google-auth', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'idToken=' + response.credential
            }).then(res => {
                if (res.ok) {
                    // Đăng nhập hoặc đăng ký thành công → chuyển hướng về trang chủ
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
