<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>ABC News</title>
    <%--  Link to your CSS file --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="public-header">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">ABC NEWS</a>
    </div>
    <nav class="main-menu">
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <%-- TODO: This menu will be loaded dynamically from the database later --%>
            <li><a href="#">Văn hóa</a></li>
            <li><a href="#">Pháp luật</a></li>
            <li><a href="#">Thể thao</a></li>
        </ul>
    </nav>
</header>

<main class="container">