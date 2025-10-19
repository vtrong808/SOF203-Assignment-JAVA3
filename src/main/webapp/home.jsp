<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/layout/header.jsp">
    <jsp:param name="activePage" value="home"/>
</jsp:include>

<main class="container">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/home.css">

    <div class="homepage-grid">
        <div class="main-news-column">
            <c:if test="${not empty featuredNews}">
                <div class="featured-news-card">
                    <a href="${pageContext.request.contextPath}/news-detail?id=${featuredNews.id}" class="news-card-image"><img src="${pageContext.request.contextPath}/${featuredNews.image}" alt="${featuredNews.title}"></a>
                    <div class="news-card-content">
                        <h2 class="news-card-title"><a href="${pageContext.request.contextPath}/news-detail?id=${featuredNews.id}">${featuredNews.title}</a></h2>
                        <p class="news-card-excerpt">${fn:substring(featuredNews.content, 0, 150)}...</p>
                    </div>
                </div>
            </c:if>
        </div>
        <aside class="sidebar-column">
            <div class="sidebar-widget">
                <h3 class="widget-title">Đọc nhiều nhất</h3>
                <ul class="most-viewed-list">
                    <c:forEach var="news" items="${mostViewedNews}" varStatus="loop">
                        <li>
                            <span class="rank">${loop.count}</span>
                            <a href="${pageContext.request.contextPath}/news-detail?id=${news.id}">${news.title}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </aside>
    </div>

<%-- ===== KHỐI CHUYÊN MỤC CÔNG NGHỆ ===== --%>
<section class="category-section">
    <h2 class="section-title"><a href="${pageContext.request.contextPath}/category?id=CN">Công nghệ</a></h2>
    <div class="category-grid">
        <c:if test="${not empty techNews}">
            <div class="category-main-news">
                <div class="news-card-small">
                    <a href="${pageContext.request.contextPath}/news-detail?id=${techNews[0].id}" class="news-card-image"><img src="${pageContext.request.contextPath}/${techNews[0].image}" alt="${techNews[0].title}"></a>
                    <div class="news-card-content">
                        <h3 class="news-card-title"><a href="${pageContext.request.contextPath}/news-detail?id=${techNews[0].id}">${techNews[0].title}</a></h3>
                        <p class="news-card-excerpt-small">${fn:substring(techNews[0].content, 0, 100)}...</p>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="category-sub-news">
            <c:forEach var="news" items="${techNews}" begin="1">
                <h4 class="sub-news-title"><a href="${pageContext.request.contextPath}/news-detail?id=${news.id}">${news.title}</a></h4>
            </c:forEach>
        </div>
    </div>
</section>

<%-- ===== KHỐI CHUYÊN MỤC THỂ THAO ===== --%>
<section class="category-section">
    <%-- Sửa 1: Đổi link sang CategoryId 'TT' --%>
    <h2 class="section-title"><a href="${pageContext.request.contextPath}/category?id=TT">Thể thao</a></h2>
    <div class="category-grid">
        <%-- Sửa 2: Sử dụng biến 'sportNews' --%>
        <c:if test="${not empty sportNews}">
            <div class="category-main-news">
                <div class="news-card-small">
                    <a href="${pageContext.request.contextPath}/news-detail?id=${sportNews[0].id}" class="news-card-image"><img src="${pageContext.request.contextPath}/${sportNews[0].image}" alt="${sportNews[0].title}"></a>
                    <div class="news-card-content">
                        <h3 class="news-card-title"><a href="${pageContext.request.contextPath}/news-detail?id=${sportNews[0].id}">${sportNews[0].title}</a></h3>
                        <p class="news-card-excerpt-small">${fn:substring(sportNews[0].content, 0, 100)}...</p>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="category-sub-news">
            <%-- Sửa 3: Sử dụng biến 'sportNews' cho vòng lặp --%>
            <c:forEach var="news" items="${sportNews}" begin="1">
                <h4 class="sub-news-title"><a href="${pageContext.request.contextPath}/news-detail?id=${news.id}">${news.title}</a></h4>
            </c:forEach>
        </div>
    </div>
</section>

<jsp:include page="/layout/footer.jsp"/>