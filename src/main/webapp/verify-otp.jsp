<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP - ABC News</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/auth.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-form">
        <h1>Xác thực Email</h1>
        <p style="text-align: center; margin-bottom: 1.5rem; color: var(--secondary-text-color);">
            Một mã OTP (6 chữ số) đã được gửi đến email <strong>${sessionScope.tempUser.email}</strong>.
            Vui lòng kiểm tra và nhập vào ô bên dưới.
        </p>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="POST">
            <div class="form-group">
                <label for="otp">Mã OTP</label>
                <input type="text" id="otp" name="otp" required maxlength="6" style="text-align: center; font-size: 1.5rem; letter-spacing: 5px;">
            </div>
            <button type="submit" class="form-button">Xác nhận</button>
        </form>
    </div>
</div>
</body>
</html>