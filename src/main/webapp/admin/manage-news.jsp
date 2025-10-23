<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Quản lý Toàn bộ Tin tức</h1>

    <%-- ===== THANH LỌC PHÓNG VIÊN ===== --%>
    <form action="${pageContext.request.contextPath}/admin/manage-news" method="GET" class="filter-form">
        <select name="authorFilter">
            <option value="all">-- Lọc theo tất cả phóng viên --</option>
            <c:forEach var="reporter" items="${reporterList}">
                <option value="${reporter.id}" ${reporter.id == param.authorFilter ? 'selected' : ''}>
                    ${reporter.fullname}
                </option>
            </c:forEach>
        </select>
        <button type="submit" class="btn btn-primary">Lọc</button>
    </form>

    <table class="management-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Tác giả</th>
                <th>Trạng thái</th> <%-- THÊM CỘT NÀY --%>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="news" items="${newsList}">
                <tr>
                    <td>${news.id}</td>
                    <td>${news.title}</td>
                    <td>${userMap[news.author]}</td>
                    <%-- THÊM CỘT NÀY --%>
                    <td>
                        <c:if test="${news.approved}">
                            <span style="color: #2ecc71;">Đã duyệt</span>
                        </c:if>
                        <c:if test="${not news.approved}">
                            <span style="color: #f39c12;">Chờ duyệt</span>
                        </c:if>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/edit-news?id=${news.id}" class="btn-action btn-edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/delete-news?id=${news.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?')">Xóa</a>

                        <%-- THÊM NÚT DUYỆT BÀI --%>
                        <c:if test="${not news.approved}">
                             <a href="${pageContext.request.contextPath}/admin/approve-news?id=${news.id}" class="btn-action" style="background-color: #2ecc71;">Duyệt</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
</div>

<%-- Thêm CSS cho thanh lọc --%>
<style>
    .filter-form {
        display: flex;
        gap: 1rem;
        margin-bottom: 2rem;
        align-items: center;
        max-width: 500px;
    }
    .filter-form select {
        flex-grow: 1;
        padding: 10px;
        background-color: var(--background-color);
        border: 1px solid var(--border-color);
        border-radius: 5px;
        color: var(--text-color);
    }
    .filter-form .btn-primary {
        margin-bottom: 0; /* Ghi đè margin-bottom của btn-primary */
    }
</style>

<jsp:include page="/layout/footer.jsp"/>