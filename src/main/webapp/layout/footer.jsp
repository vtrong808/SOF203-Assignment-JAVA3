</main>

<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="site-footer">
    <div class="container-fluid">
        <div class="footer-grid">
            <div class="footer-column">
                <h4>ABC NEWS</h4>
                <p>Trang tin tức tổng hợp, cập nhật nhanh chóng và chính xác nhất các sự kiện nóng hổi trong nước và quốc tế.</p>
            </div>
            <div class="footer-column">
                <h4>Danh mục</h4>
                <ul>
                    <li><a href="#">Văn hóa</a></li>
                    <li><a href="#">Pháp luật</a></li>
                    <li><a href="#">Thể thao</a></li>
                    <li><a href="#">Công nghệ</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Đăng ký nhận tin</h4>
                <p>Nhận các tin tức mới nhất mỗi ngày qua email của bạn.</p>
                <form class="newsletter-form" action="${pageContext.request.contextPath}/subscribe" method="post">
                    <input type="email" name="email" placeholder="Nhập email của bạn..." required>
                    <button type="submit">Đăng ký</button>
                </form>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2025 ABC News. All rights reserved. | FPT Polytechnic Assignment - SOF203</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/script.js"></script>

</body>
</html>