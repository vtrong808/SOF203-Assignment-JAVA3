<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - ABC News</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-form">
        <h1>Đăng ký tài khoản</h1>
        <form action="${pageContext.request.contextPath}/register" method="POST">
            <div class="form-group">
                <label for="id">Tên đăng nhập</label>
                <input type="text" id="id" name="id" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" id="fullname" name="fullname" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <button type="submit" class="form-button">Đăng ký</button>
        </form>
        <p class="auth-switch">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
    </div>
</div>
</body>
</html>