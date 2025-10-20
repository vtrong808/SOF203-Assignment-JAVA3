<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <%-- Thay đổi tiêu đề tùy theo ngữ cảnh --%>
    <h1 class="page-title">${not empty userToEdit ? 'Chỉnh sửa Người dùng' : 'Thêm Người dùng Mới'}</h1>

    <form action="${pageContext.request.contextPath}/admin/edit-user" method="post" class="management-form">

        <%-- Input ẩn chứa ID chỉ khi ở chế độ chỉnh sửa --%>
        <c:if test="${not empty userToEdit}">
            <input type="hidden" name="id" value="${userToEdit.id}">
        </c:if>

        <%-- Các trường này chỉ hiện khi ở chế độ THÊM MỚI --%>
        <c:if test="${empty userToEdit}">
            <div class="form-group">
                <label for="newId">Tên đăng nhập</label>
                <input type="text" id="newId" name="newId" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" required>
            </div>
        </c:if>

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

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn">Hủy</a>
    </form>
</div>

<jsp:include page="/layout/footer.jsp"/>