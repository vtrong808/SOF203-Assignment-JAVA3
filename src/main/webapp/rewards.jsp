<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/layout/header.jsp">
    <jsp:param name="activePage" value="rewards"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/rewards.css">

<div class="container">
    <h1 class="page-title">Cửa hàng Đổi thưởng</h1>

    <%-- ===== KHU VỰC HIỂN THỊ THÔNG BÁO ===== --%>
    <c:if test="${not empty sessionScope.redeem_success}">
        <div class="alert alert-success">${sessionScope.redeem_success}</div>
        <c:remove var="redeem_success" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.redeem_error}">
        <div class="alert alert-error">${sessionScope.redeem_error}</div>
        <c:remove var="redeem_error" scope="session"/>
    </c:if>
    <%-- ========================================== --%>

    <div class="rewards-grid">
        <c:forEach var="reward" items="${rewardsList}">
            <div class="reward-card">
                <div class="reward-image">
                    <img src="${pageContext.request.contextPath}/${reward.image}" alt="${reward.name}">
                </div>
                <div class="reward-content">
                    <h3 class="reward-name">${reward.name}</h3>
                    <div class="reward-points">${reward.pointsRequired} điểm</div>
                </div>
                <div class="reward-action">
                    <c:choose>
                        <c:when test="${sessionScope.user.points >= reward.pointsRequired}">
                            <%-- BIẾN NÚT BẤM THÀNH FORM --%>
                            <form action="${pageContext.request.contextPath}/redeem" method="post">
                                <input type="hidden" name="rewardName" value="${reward.name}">
                                <input type="hidden" name="pointsRequired" value="${reward.pointsRequired}">
                                <button type="submit" class="redeem-btn">Đổi</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <button class="redeem-btn disabled" disabled>Không đủ điểm</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/layout/footer.jsp"/>