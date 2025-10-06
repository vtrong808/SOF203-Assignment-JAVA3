<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/admin/layout/header.jsp"/>

<div class="admin-content">
    <h2>Trang Quản lý Tin tức</h2>
    <p>Khu vực này sẽ chứa các chức năng CRUD (Thêm, Sửa, Xóa) cho tin tức.</p>

    <button onclick="location.href='#'" style="margin-bottom: 10px;">Thêm mới tin tức</button>

    <table border="1" style="width:100%; border-collapse: collapse;">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Tác giả</th>
                <th>Ngày đăng</th>
                <th>Lượt xem</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <%-- Dùng JSTL để lặp qua danh sách tin tức --%>
            <c:forEach var="news" items="${requestScope.newsList}">
                <tr>
                    <td>${news.id}</td>
                    <td>${news.title}</td>
                    <td>${news.author}</td>
                    <td>
                        <fmt:formatDate value="${news.postedDate}" pattern="dd-MM-yyyy HH:mm:ss"/>
                    </td>
                    <td>${news.viewCount}</td>
                    <td>
                        <a href="#">Sửa</a> | <a href="#">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="/admin/layout/footer.jsp"/>