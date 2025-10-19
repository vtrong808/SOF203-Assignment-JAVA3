<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC News - ${param.title != null ? param.title : 'Trang tin tức hàng đầu'}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<header class="public-header">
    <div class="container-fluid">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">ABC NEWS</a>
        </div>
        <nav class="main-nav">
            <div class="menu-container">
                <ul class="main-menu">
                    <li><a href="${pageContext.request.contextPath}/home" class="${param.activePage == 'home' ? 'active' : ''}">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=TG" class="${param.activePage == 'TG' ? 'active' : ''}">Thế giới</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=CN" class="${param.activePage == 'CN' ? 'active' : ''}">Công nghệ</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=TT" class="${param.activePage == 'TT' ? 'active' : ''}">Thể thao</a></li>
                    <li><a href="${pageContext.request.contextPath}/category?id=GT" class="${param.activePage == 'GT' ? 'active' : ''}">Giải trí</a></li>

                    <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0 || sessionScope.user.role == 1)}">
                        <li><a href="${pageContext.request.contextPath}/rewards" class="${param.activePage == 'rewards' ? 'active' : ''}">Đổi thưởng</a></li>
                    </c:if>

                    <c:if test="${sessionScope.user.role == 1}">
                        <li><a href="${pageContext.request.contextPath}/reporter/manage-news">Quản lý Tin tức</a></li>
                    </c:if>
                </ul>
                <c:if test="${sessionScope.user.role == 2}">
                    <ul class="admin-menu">
                         <li class="admin-menu-item"><a href="#">Quản lý Tin tức</a></li>
                         <li class="admin-menu-item"><a href="#">Quản lý Loại tin</a></li>
                         <li class="admin-menu-item"><a href="#">Quản lý Người dùng</a></li>
                    </ul>
                </c:if>
            </div>
            <div class="header-actions">
                 <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <div class="user-info">
                            <span class="welcome-user">${sessionScope.user.fullname}</span>
                            <c:if test="${sessionScope.user.role == 0 || sessionScope.user.role == 1}">
                                <span class="user-points">
                                    <i class="fa-solid fa-star"></i> ${sessionScope.user.points} điểm
                                </span>
                            </c:if>
                        </div>
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