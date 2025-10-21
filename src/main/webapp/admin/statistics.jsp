<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="/layout/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/management.css">

<div class="container">
    <h1 class="page-title">Thống kê Lượt xem Bài viết</h1>
    <c:if test="${not empty dateError}">
            <div class="date-error-message">
                ${dateError}
            </div>
        </c:if>

    <%-- ===== THANH LỌC THỜI GIAN ===== --%>
    <div class="filter-controls">
        <%-- Bộ lọc nhanh --%>
        <div class="filter-bar quick-filters">
            <span>Lọc nhanh:</span>
            <a href="${pageContext.request.contextPath}/admin/statistics"
               class="btn ${empty activeFilter || activeFilter == 'all' ? 'active' : ''}">Tất cả</a>
            <a href="${pageContext.request.contextPath}/admin/statistics?filter=day"
               class="btn ${activeFilter == 'day' ? 'active' : ''}">Hôm nay</a>
            <a href="${pageContext.request.contextPath}/admin/statistics?filter=week"
               class="btn ${activeFilter == 'week' ? 'active' : ''}">Tuần này</a>
            <a href="${pageContext.request.contextPath}/admin/statistics?filter=month"
               class="btn ${activeFilter == 'month' ? 'active' : ''}">Tháng này</a>
            <a href="${pageContext.request.contextPath}/admin/statistics?filter=year"
               class="btn ${activeFilter == 'year' ? 'active' : ''}">Năm này</a>
        </div>

        <%-- Bộ lọc tùy chỉnh theo ngày --%>
        <form action="${pageContext.request.contextPath}/admin/statistics" method="GET" class="filter-bar date-range-filter">
             <span>Lọc tùy chỉnh:</span>
            <input type="date" name="startDate" value="${startDateValue}" required>
            <span>-</span>
            <input type="date" name="endDate" value="${endDateValue}" required>
            <button type="submit" class="btn ${activeFilter == 'custom' ? 'active' : ''}">Lọc</button>
        </form>
    </div>


    <table class="management-table">
        <thead>
        <tr>
            <th>Xếp hạng</th>
            <th>Tiêu đề</th>
            <th>Tác giả</th>
            <th>Ngày đăng</th>
            <th>Lượt xem</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="news" items="${statisticsList}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td><a href="${pageContext.request.contextPath}/news-detail?id=${news.id}" target="_blank">${news.title}</a></td>
                <td>${userMap[news.author]}</td>
                <td><fmt:formatDate value="${news.postedDate}" pattern="dd-MM-yyyy HH:mm"/></td>
                <td><fmt:formatNumber value="${news.viewCount}" groupingUsed="true"/></td>
            </tr>
        </c:forEach>
         <c:if test="${empty statisticsList}">
             <tr><td colspan="5">Không có dữ liệu thống kê phù hợp.</td></tr>
        </c:if>
        </tbody>
    </table>
</div>

<%-- CSS cho thanh lọc --%>
    <style>
        .filter-controls {
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex; /* Sắp xếp các nhóm filter */
            flex-direction: column; /* Xếp chồng lên nhau */
            gap: 1rem; /* Khoảng cách giữa các nhóm */
        }
        .filter-bar {
            display: flex;
            gap: 0.75rem; /* Tăng nhẹ khoảng cách */
            align-items: center;
            flex-wrap: wrap;
        }
        .filter-bar span {
            margin-right: 0.5rem;
            font-weight: 500;
            color: var(--secondary-text-color);
            white-space: nowrap; /* Không xuống dòng chữ "Lọc..." */
        }
        .filter-bar .btn {
            padding: 8px 15px;
            background-color: var(--surface-color);
            color: var(--secondary-text-color);
            border: 1px solid var(--border-color);
            margin-bottom: 0;
            line-height: 1.2; /* Căn chữ giữa nút tốt hơn */
        }
        .filter-bar .btn.active {
            background-color: var(--primary-color);
            color: #000;
            border-color: var(--primary-color);
            font-weight: bold;
        }
        /* Style riêng cho phần chọn ngày */
        .date-range-filter {
            /* Bỏ wrap để luôn nằm trên 1 hàng */
            flex-wrap: nowrap;
        }
        .date-range-filter input[type="date"] {
            padding: 8px 10px;
            background-color: var(--background-color);
            border: 1px solid var(--border-color);
            border-radius: 5px;
            color: var(--text-color);
            color-scheme: dark;
            line-height: 1.2;
        }
        .date-range-filter button.btn {
            background-color: #3498db;
            border-color: #3498db;
            color: white;
        }
         .date-range-filter button.btn.active {
            background-color: var(--primary-color);
            color: #000;
            border-color: var(--primary-color);
            font-weight: bold;
         }

         /* Style cho bảng thống kê */
         .management-table td a {
            color: var(--text-color);
         }
         .management-table td a:hover {
            color: var(--primary-color);
         }

         /* Style cho thông báo lỗi ngày tháng */
         .date-error-message {
            color: #e74c3c;
            background-color: rgba(231, 76, 60, 0.1);
            border: 1px solid #e74c3c;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 1.5rem;
         }
    </style>

<jsp:include page="/layout/footer.jsp"/>