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
            <label>Chọn hình ảnh vật phẩm</label>
            <div class="file-upload-wrapper">
                <input type="file" id="imageFile" name="imageFile" accept="image/*" class="file-input-hidden">
                <label for="imageFile" class="file-input-label btn">
                    <i class="fa-solid fa-upload"></i> Chọn tệp...
                </label>
                <span class="file-name-display">Chưa có tệp nào được chọn</span>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/manage-rewards" class="btn">Hủy</a>
    </form>
</div>

<script>
    document.getElementById('imageFile').addEventListener('change', function(e) {
        var fileName = e.target.files[0] ? e.target.files[0].name : 'Chưa có tệp nào được chọn';
        document.querySelector('.file-name-display').textContent = fileName;
    });
</script>

<jsp:include page="/layout/footer.jsp"/>