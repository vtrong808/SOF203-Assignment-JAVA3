<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Chỉnh sửa Người dùng: ${userToEdit.id}</h1>

    <form action="${pageContext.request.contextPath}/admin/edit-user" method="post" class="management-form">
        <input type="hidden" name="id" value="${userToEdit.id}">

        <div class="form-group">
            <label for="fullname">Họ và tên</label>
            <input type="text" id="fullname" name="fullname" value="${userToEdit.fullname}" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${userToEdit.email}" required>
        </div>
        <div class="form-group">
            <label for="points">Điểm tích lũy</label>
            <input type="number" id="points" name="points" value="${userToEdit.points}" required min="0">
        </div>
        <div class="form-group">
            <label for="role">Vai trò</label>
            <select name="role" id="role">
                <option value="0" ${userToEdit.role == 0 ? 'selected' : ''}>Độc giả</option>
                <option value="1" ${userToEdit.role == 1 ? 'selected' : ''}>Phóng viên</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn">Hủy</a>
    </form>
</div>

<jsp:include page="/layout/footer.jsp"/>