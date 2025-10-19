<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">
<div class="container">
    <h1 class="page-title">Quản lý Phần thưởng</h1>
    <a href="${pageContext.request.contextPath}/admin/edit-reward" class="btn btn-primary"><i class="fa fa-plus"></i> Thêm phần thưởng</a>
    <table class="management-table">
        <thead>
            <tr><th>ID</th><th>Tên vật phẩm</th><th>Điểm yêu cầu</th><th>Hành động</th></tr>
        </thead>
        <tbody>
            <c:forEach var="reward" items="${rewardList}">
                <tr>
                    <td>${reward.id}</td>
                    <td>${reward.name}</td>
                    <td>${reward.pointsRequired}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/edit-reward?id=${reward.id}" class="btn-action btn-edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/delete-reward?id=${reward.id}" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<jsp:include page="/layout/footer.jsp"/>