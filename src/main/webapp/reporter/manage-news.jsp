<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Quản lý Tin tức của bạn</h1>
    <a href="${pageContext.request.contextPath}/reporter/create-news" class="btn btn-primary">
        <i class="fa fa-plus"></i> Đăng bài viết mới
    </a>

    <table class="management-table">
        <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Ngày đăng</th>
                        <th>Trạng thái</th> <%-- THÊM CỘT NÀY --%>
                        <th>Lượt xem</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="news" items="${newsList}">
                        <tr>
                            <td>${news.id}</td>
                            <td>${news.title}</td>
                            <td><fmt:formatDate value="${news.postedDate}" pattern="dd-MM-yyyy HH:mm"/></td>
                            <%-- THÊM CỘT NÀY --%>
                            <td>
                                <c:if test="${news.approved}">
                                    <span style="color: #2ecc71;">Đã duyệt</span>
                                </c:if>
                                <c:if test="${not news.approved}">
                                    <span style="color: #f39c12;">Chờ duyệt</span>
                                </c:if>
                            </td>
                            <td>${news.viewCount}</td>
                            <td>
                                <%-- ... --%>
                            </td>
                        </tr>
                    </c:forEach>
             <c:if test="${empty newsList}">
                <tr>
                    <td colspan="5">Bạn chưa có bài viết nào.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<jsp:include page="/layout/footer.jsp"/>