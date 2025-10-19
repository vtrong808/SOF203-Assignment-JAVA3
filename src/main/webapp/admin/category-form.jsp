<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">${not empty category ? 'Chỉnh sửa' : 'Thêm mới'} Loại tin</h1>
    <form action="${pageContext.request.contextPath}/admin/edit-category" method="post" class="management-form">
        <c:if test="${not empty category}">
            <input type="hidden" name="id" value="${category.id}">
        </c:if>
        <div class="form-group">
            <label for="name">Tên loại tin</label>
            <input type="text" id="name" name="name" value="${category.name}" required>
        </div>
        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/manage-categories" class="btn">Hủy</a>
    </form>
</div>
<jsp:include page="/layout/footer.jsp"/>