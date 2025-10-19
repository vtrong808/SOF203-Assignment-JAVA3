<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">
<div class="container">
    <h1 class="page-title">${not empty reward ? 'Chỉnh sửa' : 'Thêm mới'} Phần thưởng</h1>
    <form action="${pageContext.request.contextPath}/admin/edit-reward" method="post" class="management-form">
        <c:if test="${not empty reward}">
            <input type="hidden" name="id" value="${reward.id}">
        </c:if>
        <div class="form-group">
            <label for="id">ID Vật phẩm (Viết liền, không dấu, ví dụ: VOUCHER_50K)</label>
            <input type="text" id="id" name="newId" value="${reward.id}" ${not empty reward ? 'readonly' : 'required'}>
        </div>
        <div class="form-group">
            <label for="name">Tên vật phẩm</label>
            <input type="text" id="name" name="name" value="${reward.name}" required>
        </div>
        <div class="form-group">
            <label for="pointsRequired">Điểm yêu cầu</label>
            <input type="number" id="pointsRequired" name="pointsRequired" value="${reward.pointsRequired}" required min="0">
        </div>
        <div class="form-group">
            <label for="image">URL Hình ảnh (ví dụ: images/rewards/ten-anh.png)</label>
            <input type="text" id="image" name="image" value="${reward.image}">
        </div>
        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/manage-rewards" class="btn">Hủy</a>
    </form>
</div>
<jsp:include page="/layout/footer.jsp"/>