// Hiệu ứng Fade In cho nội dung chính khi trang tải xong
document.addEventListener('DOMContentLoaded', function() {
    const mainContent = document.querySelector('.main-content');

    if (mainContent) {
        // Bắt đầu ẩn đi
        mainContent.style.opacity = '0';
        mainContent.style.transform = 'translateY(20px)';
        mainContent.style.transition = 'opacity 0.8s ease, transform 0.8s ease';

        // Hiện ra sau một khoảng trễ ngắn
        setTimeout(() => {
            mainContent.style.opacity = '1';
            mainContent.style.transform = 'translateY(0)';
        }, 100);
    }
});