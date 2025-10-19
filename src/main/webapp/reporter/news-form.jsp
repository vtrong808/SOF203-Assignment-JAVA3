<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">${not empty news ? 'Chỉnh sửa' : 'Tạo mới'} Bài viết</h1>

    <form action="${pageContext.request.contextPath}${requestScope.formAction}" method="post" class="management-form">
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
        <div class="form-group">
            <label for="image">URL Hình ảnh (ví dụ: images/ten-anh.jpg)</label>
            <input type="text" id="image" name="image" value="${news.image}">
        </div>
        <div class="form-group">
            <label for="categoryId">Danh mục</label>
            <select name="categoryId" id="categoryId">
                <option value="TG" ${news.categoryId == 'TG' ? 'selected' : ''}>Thế giới</option>
                <option value="CN" ${news.categoryId == 'CN' ? 'selected' : ''}>Công nghệ</option>
                <option value="TT" ${news.categoryId == 'TT' ? 'selected' : ''}>Thể thao</option>
                <option value="GT" ${news.categoryId == 'GT' ? 'selected' : ''}>Giải trí</option>
                <option value="PL" ${news.categoryId == 'PL' ? 'selected' : ''}>Pháp luật</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Lưu bài viết</button>
        <a href="${pageContext.request.contextPath}/reporter/manage-news" class="btn">Hủy</a>
    </form>
</div>

<jsp:include page="/layout/footer.jsp"/>