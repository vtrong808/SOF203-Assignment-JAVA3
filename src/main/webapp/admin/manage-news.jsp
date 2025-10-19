<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Quản lý Toàn bộ Tin tức</h1>
    <table class="management-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tiêu đề</th>
            <th>Tác giả</th>
            <th>Ngày đăng</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="news" items="${newsList}">
            <tr>
                <td>${news.id}</td>
                <td>${news.title}</td>
                <td>${news.author}</td>
                <td><fmt:formatDate value="${news.postedDate}" pattern="dd-MM-yyyy HH:mm"/></td>
                <td>
                    <%-- Admin có thể sửa bài của người khác, dùng form của phóng viên --%>
                    <a href="${pageContext.request.contextPath}/admin/edit-news?id=${news.id}" class="btn-action btn-edit">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/delete-news?id=${news.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<jsp:include page="/layout/footer.jsp"/>