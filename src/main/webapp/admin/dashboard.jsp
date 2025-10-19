<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Trang Quản Trị</h1>
    <p>Chào mừng, <strong>${sessionScope.user.fullname}</strong>! Chọn một chức năng để bắt đầu.</p>

    <div class="dashboard-grid">
        <a href="${pageContext.request.contextPath}/admin/manage-users" class="dashboard-card">
            <h3><i class="fa fa-users"></i> Quản lý Người dùng</h3>
            <p>Xem, sửa, xóa độc giả và phóng viên.</p>
        </a>
        <a href="${pageContext.request.contextPath}/admin/manage-categories" class="dashboard-card">
            <h3><i class="fa fa-tags"></i> Quản lý Loại tin</h3>
            <p>Thêm, sửa, xóa các danh mục tin tức.</p>
        </a>
        <a href="${pageContext.request.contextPath}/admin/manage-news" class="dashboard-card">
            <h3><i class="fa fa-newspaper"></i> Quản lý Tin tức</h3>
            <p>Xem, sửa, xóa bài viết của tất cả phóng viên.</p>
        </a>
        <a href="${pageContext.request.contextPath}/admin/manage-rewards" class="dashboard-card">
            <h3><i class="fa fa-gift"></i> Quản lý Phần thưởng</h3>
            <p>Thêm, sửa, xóa các vật phẩm đổi thưởng.</p>
        </a>
    </div>
</div>

<%-- Thêm CSS cho dashboard --%>
<style>
    .dashboard-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }
    .dashboard-card {
        background-color: var(--surface-color);
        padding: 1.5rem;
        border-radius: 8px;
        text-decoration: none;
        color: var(--text-color);
        border: 1px solid var(--border-color);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .dashboard-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        border-color: var(--primary-color);
    }
    .dashboard-card h3 {
        color: var(--primary-color);
        margin-bottom: 0.5rem;
    }
    .dashboard-card p {
        color: var(--secondary-text-color);
    }
    .dashboard-card i {
        margin-right: 10px;
    }
</style>

<jsp:include page="/layout/footer.jsp"/>