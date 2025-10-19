<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Quản lý Loại tin</h1>
    <a href="${pageContext.request.contextPath}/admin/edit-category" class="btn btn-primary"><i class="fa fa-plus"></i> Thêm loại tin mới</a>

    <table class="management-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên loại tin</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="cat" items="${categoryList}">
                <tr>
                    <td>${cat.id}</td>
                    <td>${cat.name}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/edit-category?id=${cat.id}" class="btn-action btn-edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/delete-category?id=${cat.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<jsp:include page="/layout/footer.jsp"/>