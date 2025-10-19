CREATE DATABASE ABCNewsDB;
GO

USE ABCNewsDB;
GO

-- Bảng người dùng (Quản trị và Phóng viên)
CREATE TABLE USERS (
    Id NVARCHAR(50) PRIMARY KEY,
    [Password] NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Birthday DATE,
    Gender BIT, -- 1 for Male, 0 for Female
    Moble VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    [Role] BIT NOT NULL -- 1 for Admin, 0 for Reporter
);
GO

-- Bảng loại tin
CREATE TABLE CATEGORIES (
    Id VARCHAR(10) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL
);
GO

-- Bảng tin tức
CREATE TABLE NEWS (
    Id VARCHAR(20) PRIMARY KEY,
    Title NVARCHAR(MAX) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    Image NVARCHAR(255),
    PostedDate DATETIME DEFAULT GETDATE(),
    Author NVARCHAR(50) FOREIGN KEY REFERENCES USERS(Id),
    ViewCount INT DEFAULT 0,
    CategoryId VARCHAR(10) FOREIGN KEY REFERENCES CATEGORIES(Id),
    Home BIT DEFAULT 0 -- 1 sẽ xuất hiện trên trang chủ
);
GO

-- Bảng đăng ký nhận tin
CREATE TABLE NEWSLETTERS (
    Email VARCHAR(100) PRIMARY KEY,
    Enabled BIT DEFAULT 1 -- 1 là còn hiệu lực
);
GO

--=============================================================================================================================================--

USE ABCNewsDB;
GO

-- XÓA DỮ LIỆU CŨ TRƯỚC KHI THÊM DỮ LIỆU MỚI
DELETE FROM NEWSLETTERS;
DELETE FROM NEWS;
DELETE FROM CATEGORIES;
DELETE FROM USERS;
GO

-- 1. THÊM DỮ LIỆU CHO BẢNG NGƯỜI DÙNG (USERS)
-- Role: 1 = Admin, 0 = Reporter (Phóng viên)
INSERT INTO USERS (Id, [Password], Fullname, Birthday, Gender, Moble, Email, [Role]) VALUES
('admin', '123', N'Trần Quản Trị', '1990-01-15', 1, '0905111222', 'quantri@gmail.com', 1),
('pv01', '123', N'Nguyễn Nhà Báo', '1995-05-20', 0, '0912333444', 'nhabao@gmail.com', 0),
('pv02', '123', N'Lê Hồng Phong', '1992-09-10', 1, '0987555666', 'hongphong@gmail.com', 0),
('pv03', '123', N'Phạm Phóng Viên', '1994-06-23', 0, '0908765467', 'phongvien@gmail.com', 0);
GO

-- 2. THÊM DỮ LIỆU CHO BẢNG LOẠI TIN (CATEGORIES)
INSERT INTO CATEGORIES (Id, [Name]) VALUES
('TG', N'Thế giới'),
('CN', N'Công nghệ'),
('TT', N'Thể thao'),
('GT', N'Giải trí');
GO

-- 3. THÊM DỮ LIỆU CHO BẢNG TIN TỨC (NEWS)
-- Dựa trên các sự kiện và xu hướng dự đoán năm 2025
-- Home: 1 = Hiển thị trên trang chủ
INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
(
    'TG001', N'Căng thẳng địa chính trị gia tăng trong bối cảnh chính quyền mới của Mỹ',
    N'Năm 2025 chứng kiến nhiều thay đổi lớn trên bàn cờ chính trị thế giới. Các chuyên gia phân tích chính sách đối ngoại mới của Mỹ và những ảnh hưởng có thể có đối với quan hệ thương mại với Trung Quốc và châu Âu.',
    'images/politics_2025.jpg', '2025-10-04 22:15:00', 'pv01', 1580, 'TG', 1
),
(
    'CN001', N'AI tạo sinh (Agentic AI): Xu hướng công nghệ định hình năm 2025',
    N'Không chỉ dừng lại ở việc tạo ra nội dung, AI giờ đây có thể tự đưa ra quyết định và thực hiện các hành động tự chủ để đạt được mục tiêu. Các chuyên gia công nghệ hàng đầu lý giải về tiềm năng và thách thức của Agentic AI.',
    'images/agent_ai.jpg', '2025-10-05 11:30:00', 'pv02', 2150, 'CN', 1
),
(
    'TT001', N'Chung kết UEFA Champions League 2025 sẽ diễn ra tại sân Allianz Arena, Munich',
    N'Thành phố Munich của Đức đã được chọn làm nơi đăng cai trận chung kết cúp C1 danh giá. Sự kiện hứa hẹn sẽ là một đêm hội bóng đá không thể bỏ lỡ cho người hâm mộ toàn cầu.',
    'images/champions_league_2025.jpg', '2025-10-03 15:00:00', 'pv01', 3200, 'TT', 1
),
(
    'GT001', N'Bom tấn điện ảnh "Superman" khởi động lại vũ trụ DC sẽ ra rạp vào tháng 7',
    N'Sau nhiều mong đợi, bộ phim "Superman" do James Gunn đạo diễn sẽ chính thức ra mắt, mở ra một chương mới cho vũ trụ điện ảnh DC. Liệu bộ phim có đáp ứng được kỳ vọng của người hâm mộ?',
    'images/superman_2025.jpg', '2025-10-02 09:45:00', 'pv02', 4100, 'GT', 0
),
(
    'TT002', N'FIFA Club World Cup 2025 phiên bản mở rộng tổ chức tại Mỹ',
    N'Lần đầu tiên với thể thức 32 đội, FIFA Club World Cup 2025 hứa hẹn sẽ là giải đấu cấp câu lạc bộ hấp dẫn nhất hành tinh, quy tụ những đội bóng hàng đầu từ các châu lục.',
    'images/club_world_cup.jpg', '2025-09-28 18:00:00', 'pv01', 1950, 'TT', 0
),
(
    'CN002', N'Bước đột phá trong Điện toán Lượng tử có thể thay đổi ngành dược phẩm',
    N'Các nhà nghiên cứu tại MIT công bố một thuật toán lượng tử mới có khả năng mô phỏng phân tử phức tạp, mở đường cho việc phát minh thuốc nhanh hơn và hiệu quả hơn.',
    'images/quantum_computing.jpg', '2025-09-30 14:00:00', 'pv02', 1800, 'CN', 1
),
(
    'GT002', N'Captain America: Brave New World nhận được phản ứng tích cực sau buổi chiếu sớm',
    N'Phần thứ tư của loạt phim Captain America với sự tham gia của Anthony Mackie được khen ngợi về mặt hành động và chiều sâu nhân vật, hứa hẹn một thành công phòng vé.',
    'images/captain_america.jpg', '2025-09-29 10:20:00', 'pv02', 3500, 'GT', 1
),
(
    'TG002', N'IMF cảnh báo về triển vọng kinh tế không đồng đều cho các quốc gia đang phát triển',
    N'Báo cáo mới nhất của Quỹ Tiền tệ Quốc tế (IMF) cho thấy sự phục hồi kinh tế toàn cầu năm 2025 sẽ chậm lại, đặc biệt ảnh hưởng đến các nền kinh tế mới nổi do lạm phát và lãi suất cao.',
    'images/imf_report.jpg', '2025-09-27 19:00:00', 'pv01', 950, 'TG', 0
),
(
    'TT003', N'Lịch thi đấu Wimbledon 2025 được công bố, hứa hẹn nhiều trận cầu đỉnh cao',
    N'Ban tổ chức giải Grand Slam trên mặt sân cỏ đã công bố lịch thi đấu chính thức, với sự trở lại của các tay vợt hàng đầu thế giới.',
    'images/wimbledon.jpg', '2025-09-26 11:00:00', 'pv01', 2800, 'TT', 0
),
(
    'CN003', N'Kỷ nguyên "Spatial Computing": Apple và Meta cạnh tranh gay gắt',
    N'Với các sản phẩm kính thực tế ảo và tăng cường mới, cuộc chiến giành quyền thống trị không gian làm việc và giải trí ảo trong năm 2025 đang trở nên nóng hơn bao giờ hết.',
    'images/spatial_computing.jpg', '2025-09-25 08:30:00', 'pv02', 1200, 'CN', 0
),
(
    'GT003', N'Zootopia 2 công bố ngày phát hành chính thức vào cuối năm 2025',
    N'Disney xác nhận phần tiếp theo của bộ phim hoạt hình ăn khách Zootopia sẽ ra mắt khán giả vào kỳ nghỉ lễ, tiếp tục cuộc phiêu lưu của bộ đôi Judy Hopps và Nick Wilde.',
    'images/zootopia_2.jpg', '2025-09-24 16:45:00', 'pv02', 5100, 'GT', 1
),
(
    'TG003', N'Hội nghị thượng đỉnh về khí hậu COP30 đặt ra mục tiêu tham vọng mới',
    N'Các nhà lãnh đạo thế giới nhóm họp tại Brazil để thảo luận về các biện pháp khẩn cấp nhằm cắt giảm khí thải nhà kính và hỗ trợ các quốc gia dễ bị tổn thương.',
    'images/cop30.jpg', '2025-09-23 21:00:00', 'pv01', 750, 'TG', 0
),
(
    'TT004', N'Super Bowl LIX: New Orleans chuẩn bị cho sự kiện thể thao lớn nhất nước Mỹ',
    N'Thành phố New Orleans đang hoàn tất những khâu chuẩn bị cuối cùng để đăng cai Super Bowl lần thứ 59, một sự kiện thể thao và giải trí hoành tráng.',
    'images/super_bowl_lix.jpg', '2025-09-22 13:10:00', 'pv01', 2500, 'TT', 1
),
(
    'CN004', N'Luật quản lý AI toàn cầu: Bước tiến và những tranh cãi',
    N'Nhiều quốc gia đang gấp rút đưa ra các khung pháp lý để quản lý sự phát triển của Trí tuệ nhân tạo, tập trung vào các vấn đề đạo đức, an ninh và quyền riêng tư.',
    'images/ai_governance.jpg', '2025-09-21 10:00:00', 'pv02', 1100, 'CN', 0
),
(
    'GT004', N'Marvel Studios hé lộ dàn diễn viên cho "The Fantastic Four: First Steps"',
    N'Sau nhiều đồn đoán, dàn diễn viên chính thức cho bộ phim được mong chờ nhất của Marvel đã được công bố, tạo ra một làn sóng phấn khích trong cộng đồng người hâm mộ.',
    'images/fantastic_four.jpg', '2025-09-20 17:30:00', 'pv02', 6200, 'GT', 0
),
(
    'TG004', N'Tình hình chiến sự Ukraine: Nỗ lực ngoại giao tìm kiếm hòa bình',
    N'Các cuộc đàm phán ngoại giao tiếp tục được thúc đẩy trong năm 2025 nhằm tìm kiếm một giải pháp hòa bình bền vững cho cuộc xung đột kéo dài tại Ukraine.',
    'images/ukraine_peace.jpg', '2025-09-19 23:00:00', 'pv01', 890, 'TG', 0
),
(
    'TT005', N'Lộ trình Tour de France 2025 được hé lộ với nhiều chặng đua khắc nghiệt',
    N'Giải đua xe đạp danh giá nhất hành tinh công bố lộ trình cho mùa giải mới, hứa hẹn những màn tranh tài nảy lửa trên các cung đường đèo hiểm trở của Pháp.',
    'images/tour_de_france.jpg', '2025-09-18 12:00:00', 'pv01', 1400, 'TT', 0
),
(
    'CN005', N'Mạng 5G và IoT: Tương lai của thành phố thông minh đang đến gần',
    N'Sự phổ cập của mạng 5G trong năm 2025 đang thúc đẩy mạnh mẽ sự phát triển của các thiết bị Internet of Things (IoT), từ nhà ở thông minh đến hệ thống giao thông tự hành.',
    'images/5g_iot.jpg', '2025-09-17 09:00:00', 'pv02', 1350, 'CN', 0
),
(
    'GT005', N'"Tron: Ares" với sự tham gia của Jared Leto ấn định ngày ra mắt',
    N'Phần tiếp theo của loạt phim khoa học viễn tưởng kinh điển "Tron" sẽ trở lại màn ảnh rộng, hứa hẹn mang đến những trải nghiệm hình ảnh mãn nhãn.',
    'images/tron_ares.jpg', '2025-09-16 18:20:00', 'pv02', 3800, 'GT', 0
),
(
    'TG005', N'Ba Lan tổ chức bầu cử tổng thống trong bối cảnh châu Âu nhiều biến động',
    N'Cuộc bầu cử tổng thống tại Ba Lan năm 2025 được coi là một sự kiện quan trọng, có thể ảnh hưởng đến các chính sách của Liên minh châu Âu và tình hình an ninh khu vực.',
    'images/poland_election.jpg', '2025-09-15 20:00:00', 'pv01', 600, 'TG', 0
);
GO

-- 4. THÊM DỮ LIỆU CHO BẢNG ĐĂNG KÝ NHẬN TIN (NEWSLETTERS)
-- Enabled: 1 = Còn hiệu lực
INSERT INTO NEWSLETTERS (Email, Enabled) VALUES
('testuser1@gmail.com', 1),
('testuser2@gmail.com', 1),
('testuser3@gmail.com', 0), -- Email này đã hủy đăng ký
('testuser4@gmail.com', 1),
('testuser5@gmail.com', 1);
GO

-- ================================================================= --
-- ===== CẬP NHẬT CSDL CHO HỆ THỐNG PHÂN QUYỀN MỞ RỘNG (4 TẦNG) ===== --
-- ================================================================= --

-- 1. Thay đổi cột Role trong bảng USERS từ BIT thành INT
ALTER TABLE USERS
ALTER COLUMN [Role] INT NOT NULL;
GO

-- Cập nhật lại vai trò cho các user hiện có theo quy ước mới
-- 0 = Độc giả, 1 = Phóng viên, 2 = Quản trị viên
UPDATE USERS SET [Role] = 2 WHERE Id = 'admin';
UPDATE USERS SET [Role] = 1 WHERE Id LIKE 'pv%';
GO

-- 2. Thêm cột Point cho bảng USERS để lưu điểm tích lũy
ALTER TABLE USERS
ADD Points INT DEFAULT 0;
GO

-- 3. Tạo bảng REWARDS để lưu thông tin vật phẩm đổi thưởng
CREATE TABLE REWARDS (
    Id VARCHAR(20) PRIMARY KEY,
    [Name] NVARCHAR(255) NOT NULL,
    PointsRequired INT NOT NULL,
    Image NVARCHAR(255)
);
GO

-- 4. Thêm một vài vật phẩm mẫu
INSERT INTO REWARDS (Id, [Name], PointsRequired, Image) VALUES
('VOUCHER_20K', N'Voucher giảm giá 20.000đ', 200, 'images/rewards/voucher_20k.png'),
('CUP_ABC', N'Ly sứ ABC News', 500, 'images/rewards/cup_abc.png');
GO
