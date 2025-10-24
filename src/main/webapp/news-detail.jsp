<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/layout/header.jsp"/>

<%-- Link CSS cho trang này --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/category.css">
<%-- Link Font Awesome cho các icon cảm xúc --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<main class="container">
    <div class="news-detail-container">
        <div class="detail-grid">

            <%-- CỘT 1: HÌNH ẢNH --%>
            <div class="detail-grid-image">
                <img src="${pageContext.request.contextPath}/${news.image}" alt="${news.title}">
            </div>

            <%-- CỘT 2: NỘI DUNG --%>
            <div class="detail-grid-content">
                <h1>${news.title}</h1>

                <div class="news-meta">
                    <span><i class="fa-solid fa-user-pen"></i> Tác giả: ${news.author}</span>
                    <span><i class="fa-solid fa-calendar-days"></i> Ngày đăng: <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <span><i class="fa-solid fa-eye"></i> Lượt xem: <fmt:formatNumber value="${news.viewCount}" groupingUsed="true"/></span>
                </div>

                <%-- Hộp tích điểm --%>
                <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0 || sessionScope.user.role == 1)}">
                    <div id="point-timer-box" class="point-timer">
                        Bạn sẽ nhận được <strong>10 điểm</strong> sau <span id="countdown">10</span> giây nữa...
                    </div>
                </c:if>

                <%-- NỘI DUNG BÀI VIẾT --%>
                <div class="news-content">
                    ${news.content}
                </div>

                <%-- THANH TƯƠNG TÁC (CẢM XÚC & LƯU BÀI) --%>
                <div class="interaction-bar">
                    <div class="reaction-buttons" id="reaction-container">
                        <span class="reaction-btn ${userReaction == 1 ? 'active' : ''}" data-type="1">👍</span> <%-- Thích --%>
                        <span class="reaction-btn ${userReaction == 2 ? 'active' : ''}" data-type="2">❤️</span> <%-- Yêu thích --%>
                        <span class="reaction-btn ${userReaction == 3 ? 'active' : ''}" data-type="3">😂</span> <%-- Cười --%>
                        <span class="reaction-btn ${userReaction == 4 ? 'active' : ''}" data-type="4">😢</span> <%-- Buồn --%>
                        <span class="reaction-btn ${userReaction == 5 ? 'active' : ''}" data-type="5">😮</span> <%-- Bất ngờ --%>
                        <span class="reaction-btn ${userReaction == 6 ? 'active' : ''}" data-type="6">😡</span> <%-- Phẫn nộ --%>
                    </div>

                    <button class="save-btn ${isSaved ? 'saved' : ''}" id="save-article-btn">
                        <c:if test="${isSaved}">
                            <i class="fa-solid fa-bookmark"></i> Đã lưu
                        </c:if>
                        <c:if test="${not isSaved}">
                            <i class="fa-regular fa-bookmark"></i> Lưu bài viết
                        </c:if>
                    </button>
                </div>

                <%-- KHU VỰC BÌNH LUẬN --%>
                <div class="comment-section">
                    <h2>Bình luận (${comments.size()})</h2>

                    <%-- Form nhập bình luận (Chỉ hiện khi đã đăng nhập) --%>
                    <c:if test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/add-comment" method="POST" class="comment-form">
                            <input type="hidden" name="newsId" value="${news.id}">
                            <div class="form-group">
                                <textarea name="content" placeholder="Viết bình luận của bạn..." required></textarea>
                            </div>
                            <button type="submit" class="btn-primary">Gửi bình luận</button>
                        </form>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <div class="login-prompt">
                            Vui lòng <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để bình luận.
                        </div>
                    </c:if>

                    <%-- Danh sách bình luận --%>
                    <div class="comment-list">
                        <c:forEach var="comment" items="${comments}">
                            <div class="comment-item">
                                <div class="comment-avatar">
                                    ${comment.userFullname.substring(0, 1)} <%-- Lấy chữ cái đầu --%>
                                </div>
                                <div class="comment-content">
                                    <div class="comment-author">${comment.userFullname}</div>
                                    <div class="comment-date"><fmt:formatDate value="${comment.postedDate}" pattern="HH:mm 'ngày' dd/MM/yyyy"/></div>
                                    <p class="comment-text">${comment.content}</p>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty comments}">
                            <p style="text-align: center; color: var(--secondary-text-color);">Chưa có bình luận nào. Hãy là người đầu tiên!</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%-- SCRIPT XỬ LÝ (Tích điểm, Cảm xúc, Lưu bài) --%>
<script>
    const newsId = "${news.id}";
    const contextPath = "${pageContext.request.contextPath}";
    const isLoggedIn = ${not empty sessionScope.user};

    // 1. Script Tích điểm
    <c:if test="${sessionScope.user != null && (sessionScope.user.role == 0 || sessionScope.user.role == 1)}">
        const countdownElement = document.getElementById('countdown');
        const timerBox = document.getElementById('point-timer-box');
        if (timerBox) {
            let timeLeft = 10;
            const countdownInterval = setInterval(() => {
                timeLeft--;
                countdownElement.textContent = timeLeft;
                if (timeLeft <= 0) {
                    clearInterval(countdownInterval);
                    fetch(contextPath + '/add-point', { method: 'POST' })
                        .then(response => {
                            if(response.ok) {
                                timerBox.innerHTML = '<strong>+10 điểm!</strong> Bạn đã nhận được điểm thưởng.';
                                timerBox.classList.add('success');
                            }
                        });
                }
            }, 1000);
        }
    </c:if>

    // 2. Script Lưu bài viết (AJAX)
    const saveBtn = document.getElementById('save-article-btn');
    if (saveBtn) {
        saveBtn.addEventListener('click', function() {
            if (!isLoggedIn) {
                window.location.href = contextPath + '/login';
                return;
            }

            fetch(contextPath + '/toggle-save', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'newsId=' + newsId
            })
            .then(res => {
                if (res.status === 401) window.location.href = contextPath + '/login';
                if (res.ok) return res.json();
            })
            .then(data => {
                if (data.isSaved) {
                    saveBtn.innerHTML = '<i class="fa-solid fa-bookmark"></i> Đã lưu';
                    saveBtn.classList.add('saved');
                } else {
                    saveBtn.innerHTML = '<i class="fa-regular fa-bookmark"></i> Lưu bài viết';
                    saveBtn.classList.remove('saved');
                }
            });
        });
    }

    // 3. Script Thả cảm xúc (AJAX)
    const reactionContainer = document.getElementById('reaction-container');
    if (reactionContainer) {
        reactionContainer.addEventListener('click', function(e) {
            if (!e.target.classList.contains('reaction-btn')) return;
            if (!isLoggedIn) {
                window.location.href = contextPath + '/login';
                return;
            }

            const type = e.target.dataset.type;

            // Gửi request lên server
            fetch(contextPath + '/react', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'newsId=' + newsId + '&type=' + type
            })
            .then(res => {
                if (res.status === 401) window.location.href = contextPath + '/login';
                if (res.ok) {
                    // Cập nhật giao diện
                    reactionContainer.querySelectorAll('.reaction-btn').forEach(btn => {
                        btn.classList.remove('active');
                    });
                    e.target.classList.add('active');
                }
            });
        });
    }
</script>

<jsp:include page="/layout/footer.jsp"/>