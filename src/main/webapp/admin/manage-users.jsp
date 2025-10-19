<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Quản lý Người dùng</h1>

    <table class="management-table">
        <thead>
            <tr>
                <th>Tên đăng nhập</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Điểm</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.fullname}</td>
                    <td>${user.email}</td>
                    <td>
                        <c:if test="${user.role == 0}">Độc giả</c:if>
                        <c:if test="${user.role == 1}">Phóng viên</c:if>
                    </td>
                    <td>${user.points}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/edit-user?id=${user.id}" class="btn-action btn-edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/delete-user?id=${user.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này? Mọi bài viết của họ sẽ bị vô hiệu hóa tác giả.')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="/layout/footer.jsp"/>