<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC News - ${param.title != null ? param.title : 'Trang tin tức hàng đầu'}</title>

    <%-- Google Fonts --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <%-- Font Awesome Icons (cho icon tìm kiếm) --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

    <%-- Đường dẫn đến file CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<header class="public-header">
    <div class="container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">ABC NEWS</a>
        </div>
        <nav class="main-nav">
            <ul class="main-menu">
                <li><a href="${pageContext.request.contextPath}/home" class="active">Trang chủ</a></li>
                <li><a href="#">Văn hóa</a></li>
                <li><a href="#">Pháp luật</a></li>
                <li><a href="#">Thể thao</a></li>
                <li><a href="#">Công nghệ</a></li>
            </ul>

            <div class="header-actions">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <span class="welcome-user">Chào ༼ つ ◕_◕ ༽つ ${sessionScope.user.fullname}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="auth-link">Đăng xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="auth-link">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
                <form action="${pageContext.request.contextPath}/search" method="GET" class="search-form">
                    <input type="text" name="keyword" placeholder="Tìm kiếm...">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
            </div>
        </nav>
    </div>
</header>

<main class="container">