<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Quản lý Tin tức của bạn</h1>
    <a href="${pageContext.request.contextPath}/reporter/create-news" class="btn btn-primary">
        <i class="fa fa-plus"></i> Đăng bài viết mới
    </a>

    <table class="management-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Ngày đăng</th>
                <th>Lượt xem</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="news" items="${newsList}">
                <tr>
                    <td>${news.id}</td>
                    <td>${news.title}</td>
                    <td><fmt:formatDate value="${news.postedDate}" pattern="dd-MM-yyyy HH:mm"/></td>
                    <td>${news.viewCount}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/reporter/edit-news?id=${news.id}" class="btn-action btn-edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/reporter/delete-news?id=${news.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
             <c:if test="${empty newsList}">
                <tr>
                    <td colspan="5">Bạn chưa có bài viết nào.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<jsp:include page="/layout/footer.jsp"/>