<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Trị - ABC News</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="admin-header">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">CÔNG CỤ QUẢN TRỊ TIN TỨC</a>
    </div>
    <nav class="admin-menu">
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Trang chủ (Đọc giả)</a></li>
            <li><a href="#">Quản lý Tin tức</a></li>
            <%-- TODO: Use JSTL <c:if> to check user role and show/hide these menus --%>
            <li><a href="#">Quản lý Loại tin</a></li>
            <li><a href="#">Quản lý Người dùng</a></li>
            <li><a href="#">Quản lý Newsletter</a></li>
        </ul>
    </nav>
</header>

<main class="container">