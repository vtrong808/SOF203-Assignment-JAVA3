<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">${not empty news ? 'Chỉnh sửa' : 'Tạo mới'} Bài viết</h1>

    <%-- THAY ĐỔI QUAN TRỌNG: Thêm enctype="multipart/form-data" để form có thể gửi file --%>
    <form action="${pageContext.request.contextPath}${requestScope.formAction}" method="post" class="management-form" enctype="multipart/form-data">

        <%-- Input ẩn chứa ID khi chỉnh sửa --%>
        <c:if test="${not empty news}">
            <input type="hidden" name="id" value="${news.id}">
        </c:if>

        <div class="form-group">
            <label for="title">Tiêu đề</label>
            <input type="text" id="title" name="title" value="${news.title}" required>
        </div>
        <div class="form-group">
            <label for="content">Nội dung</label>
            <textarea id="content" name="content" rows="10" required>${news.content}</textarea>
        </div>

        <%-- THAY ĐỔI Ô NHẬP ẢNH --%>
        <div class="form-group">
            <label>Hình ảnh bài viết</label>
            <div class="file-upload-wrapper">
                <input type="file" id="imageFile" name="imageFile" accept="image/*" class="file-input-hidden">
                <label for="imageFile" class="file-input-label btn">
                    <i class="fa-solid fa-upload"></i> Chọn tệp...
                </label>
                <span class="file-name-display">
                    <c:choose>
                        <c:when test="${not empty news.image}">${news.image}</c:when>
                        <c:otherwise>Chưa có tệp nào được chọn</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <%-- Input ẩn để lưu ảnh cũ trong trường hợp Sửa mà không chọn ảnh mới --%>
            <c:if test="${not empty news}">
                 <input type="hidden" name="existingImage" value="${news.image}">
            </c:if>
        </div>

        <div class="form-group">
            <label for="categoryId">Danh mục</label>
            <select name="categoryId" id="categoryId">
                <c:forEach var="cat" items="${applicationScope.appCategories}">
                    <option value="${cat.id}" ${news.categoryId == cat.id ? 'selected' : ''}>
                        ${cat.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Lưu bài viết</button>
        <a href="${pageContext.request.contextPath}${sessionScope.user.role == 1 ? '/reporter/manage-news' : '/admin/manage-news'}" class="btn">Hủy</a>
    </form>
</div>

<%-- Thêm JavaScript để hiển thị tên file đã chọn --%>
<script>
    document.getElementById('imageFile').addEventListener('change', function(e) {
        var fileName = e.target.files[0] ? e.target.files[0].name : 'Chưa có tệp nào được chọn';
        document.querySelector('.file-name-display').textContent = fileName;
    });
</script>

<jsp:include page="/layout/footer.jsp"/>