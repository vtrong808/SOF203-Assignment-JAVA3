<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/layout/header.jsp">
    <jsp:param name="activePage" value="${category.id}"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/category.css">

<div class="container">
    <h1 class="page-title">Tin tức Danh mục: ${category.name}</h1>

    <div class="category-news-list">
        <c:forEach var="news" items="${newsList}">
            <div class="news-item-row">
                <%-- UPDATE THIS LINE --%>
                <a href="${pageContext.request.contextPath}/news-detail?id=${news.id}" class="news-item-image">
                    <img src="${pageContext.request.contextPath}/${news.image}" alt="${news.title}">
                </a>
                <div class="news-item-content">
                    <%-- AND UPDATE THIS LINE --%>
                    <h3 class="news-item-title"><a href="${pageContext.request.contextPath}/news-detail?id=${news.id}">${news.title}</a></h3>
                    <p class="news-item-excerpt">${fn:substring(news.content, 0, 200)}...</p>
                    <div class="news-card-meta">
                         <span><i class="fa fa-user"></i> ${news.author}</span>
                         <span><i class="fa fa-calendar-alt"></i> <fmt:formatDate value="${news.postedDate}" pattern="dd-MM-yyyy"/></span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/layout/footer.jsp"/>