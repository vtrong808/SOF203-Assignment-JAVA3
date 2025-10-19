<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/layout/header.jsp"/>

<main class="container">
    <div class="news-detail-container">
        <h1>${news.title}</h1>
        <div class="news-meta">
            <span>Tác giả: ${news.author}</span> |
            <span>Ngày đăng: <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/></span>
        </div>
        <img src="${pageContext.request.contextPath}/${news.image}" alt="${news.title}" class="news-detail-image">
        <div class="news-content">
            ${news.content}
        </div>
    </div>
</main>

<script>
    // Hàm gửi yêu cầu cộng điểm
    function addReadingPoints() {
        // Sử dụng Fetch API để gửi yêu cầu POST đến servlet
        fetch('${pageContext.request.contextPath}/add-point', {
            method: 'POST'
        })
        .then(response => console.log('Point request sent.'))
        .catch(error => console.error('Error:', error));
    }

    // Chỉ thực hiện đếm giờ nếu người dùng là độc giả đã đăng nhập (role == 0)
    <c:if test="${sessionScope.user != null && sessionScope.user.role == 0}">
        console.log('User is a reader. Starting 10s timer to add points...');
        setTimeout(addReadingPoints, 10000); // 10000 milliseconds = 10 giây
    </c:if>
</script>

<jsp:include page="/layout/footer.jsp"/>