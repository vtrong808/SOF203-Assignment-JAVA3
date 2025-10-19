<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/layout/header.jsp"/>

<main class="container">
    <div class="news-detail-container">
        <%-- Cấu trúc lưới 2 cột mới --%>
        <div class="detail-grid">
            <%-- CỘT 1: HÌNH ẢNH (sẽ đứng yên khi cuộn) --%>
            <div class="detail-grid-image">
                <img src="${pageContext.request.contextPath}/${news.image}" alt="${news.title}">
            </div>

            <%-- CỘT 2: NỘI DUNG (sẽ cuộn được) --%>
            <div class="detail-grid-content">
                <h1>${news.title}</h1>

                <div class="news-meta">
                    <span><i class="fa-solid fa-user-pen"></i> Tác giả: ${news.author}</span>
                    <span><i class="fa-solid fa-calendar-days"></i> Ngày đăng: <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                </div>

                <%-- Hiển thị hộp tích điểm nếu là độc giả/phóng viên --%>
                <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0 || sessionScope.user.role == 1)}">
                    <div id="point-timer-box" class="point-timer">
                        Bạn sẽ nhận được <strong>10 điểm</strong> sau <span id="countdown">10</span> giây nữa...
                    </div>
                </c:if>

                <div class="news-content">
                    ${news.content}
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0 || sessionScope.user.role == 1)}">
        const countdownElement = document.getElementById('countdown');
        const timerBox = document.getElementById('point-timer-box');
        let timeLeft = 10;

        // Hàm gửi yêu cầu cộng điểm
        function addReadingPoints() {
            fetch('${pageContext.request.contextPath}/add-point', {
                method: 'POST'
            })
            .then(response => {
                if(response.ok) {
                    console.log('Point request sent successfully.');
                    // Cập nhật giao diện sau khi thành công
                    timerBox.innerHTML = '<strong>+10 điểm!</strong> Bạn đã nhận được điểm thưởng.';
                    timerBox.classList.add('success');
                }
            })
            .catch(error => console.error('Error:', error));
        }

        // Bắt đầu đếm ngược
        const countdownInterval = setInterval(() => {
            timeLeft--;
            countdownElement.textContent = timeLeft;
            if (timeLeft <= 0) {
                clearInterval(countdownInterval); // Dừng đếm ngược
                addReadingPoints(); // Gọi hàm cộng điểm
            }
        }, 1000); // Cập nhật mỗi giây
    </c:if>
</script>

<jsp:include page="/layout/footer.jsp"/>