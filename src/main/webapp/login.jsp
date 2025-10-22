<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - ABC News</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-form">
        <h1>Đăng nhập</h1>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST">
            <div class="form-group">
                            <%-- Thay đổi label --%>
                            <label for="email">Email</label>
                            <%-- Thay đổi id và name thành "email" --%>
                            <input type="email" id="email" name="email" required>
                        </div>
            <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <input type="password" id="password" name="password" required>
                        </div>
            <button type="submit" class="form-button">Đăng nhập</button>
        </form>
        <p class="auth-switch">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
    </div>
</div>
</body>
</html>