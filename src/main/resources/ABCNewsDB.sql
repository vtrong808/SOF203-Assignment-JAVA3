CREATE DATABASE ABCNewsDB;
GO

USE ABCNewsDB;
GO

-- Bảng người dùng (USERS)
CREATE TABLE USERS (
    Id NVARCHAR(50) PRIMARY KEY,
    [Password] NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Birthday DATE,
    Gender BIT, -- 1 for Male, 0 for Female
    Moble VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    [Role] INT NOT NULL, -- 0: Độc giả, 1: Phóng viên, 2: Admin
    Points INT DEFAULT 0
);
GO

-- Bảng loại tin (CATEGORIES)
CREATE TABLE CATEGORIES (
    Id VARCHAR(10) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL
);
GO

-- Bảng tin tức (NEWS)
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

-- Bảng đăng ký nhận tin (NEWSLETTERS)
CREATE TABLE NEWSLETTERS (
    Email VARCHAR(100) PRIMARY KEY,
    Enabled BIT DEFAULT 1 -- 1 là còn hiệu lực
);
GO

-- Bảng vật phẩm đổi thưởng (REWARDS)
CREATE TABLE REWARDS (
    Id VARCHAR(20) PRIMARY KEY,
    [Name] NVARCHAR(255) NOT NULL,
    PointsRequired INT NOT NULL,
    Image NVARCHAR(255)
);
GO

--=============================================================================================================================================--
--                                                     THÊM DỮ LIỆU MẪU                                                                        --
--=============================================================================================================================================--

-- 1. THÊM DỮ LIỆU CHO BẢNG NGƯỜI DÙNG (USERS)
-- Role: 0 = Độc giả, 1 = Phóng viên, 2 = Quản trị viên
INSERT INTO USERS (Id, [Password], Fullname, Email, [Role], Points) VALUES
('admin', '123', N'Trần Quản Trị', 'admin@abc.com', 2, 0),
('pv01', '123', N'Nguyễn Nhà Báo', 'pv01@abc.com', 1, 0),
('pv02', '123', N'Lê Hồng Phong', 'pv02@abc.com', 1, 0),
('docgia01', '123', N'Trần Văn Đọc', 'docgia01@email.com', 0, 150),
('docgia02', '123', N'Nguyễn Thị Giả', 'docgia02@email.com', 0, 50);
GO

-- 2. THÊM DỮ LIỆU CHO BẢNG LOẠI TIN (CATEGORIES)
INSERT INTO CATEGORIES (Id, [Name]) VALUES
('TG', N'Thế giới'),
('CN', N'Công nghệ'),
('TT', N'Thể thao'),
('GT', N'Giải trí'),
('PL', N'Pháp luật'); -- Thêm danh mục mới
GO

-- 3. THÊM DỮ LIỆU CHO BẢNG TIN TỨC (NEWS)
-- Các tin tức đã có
-- NHÓM 1: TỪ TG001 ĐẾN GT002

INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
(
    'TG001', 
    N'Căng thẳng địa chính trị gia tăng trong bối cảnh chính quyền mới của Mỹ',
    N'Năm 2025 mở ra với nhiều chuyển biến lớn trên bàn cờ chính trị quốc tế, khi chính quyền mới của Mỹ bắt đầu triển khai những chính sách đối ngoại được cho là mang tính định hình lại trật tự toàn cầu. Giới quan sát cho rằng các quyết định gần đây của Washington về thương mại, quốc phòng và công nghệ đang tạo ra những làn sóng phản ứng khác nhau từ các quốc gia lớn. Trung Quốc, Liên minh châu Âu và nhiều nền kinh tế mới nổi đang theo dõi sát sao động thái của Mỹ, nhất là trong lĩnh vực chuỗi cung ứng và an ninh công nghệ cao. Một số chuyên gia nhận định, cách tiếp cận “cứng rắn nhưng hợp tác có điều kiện” của chính quyền mới có thể làm gia tăng căng thẳng ngắn hạn nhưng cũng mở ra cơ hội tái cấu trúc quan hệ trong dài hạn. Ngoài ra, sự thay đổi trong chính sách năng lượng xanh, cam kết về khí hậu và đầu tư hạ tầng quốc tế của Mỹ đang đặt ra thách thức mới cho các đối tác truyền thống. Các nhà phân tích cũng cảnh báo rằng nếu không có cơ chế đối thoại hiệu quả, căng thẳng địa chính trị có thể tiếp tục leo thang, ảnh hưởng trực tiếp đến thương mại, giá năng lượng và ổn định tài chính toàn cầu trong thời gian tới.',
    'images/politics_2025.jpg', 
    '2025-10-04 22:15:00', 'pv01', 1580, 'TG', 1
),
(
    'CN001', 
    N'AI tạo sinh (Agentic AI): Xu hướng công nghệ định hình năm 2025',
    N'Năm 2025 được xem là giai đoạn bùng nổ của AI tạo sinh thế hệ mới, trong đó Agentic AI — trí tuệ nhân tạo có khả năng tự hành động và đưa ra quyết định — đang trở thành tâm điểm chú ý của ngành công nghệ toàn cầu. Khác với các hệ thống AI truyền thống chỉ phản hồi dựa trên đầu vào của con người, Agentic AI được thiết kế để chủ động lập kế hoạch, thu thập dữ liệu và tự điều chỉnh hành vi nhằm đạt mục tiêu được giao. Các tập đoàn công nghệ hàng đầu như Google, Microsoft và OpenAI đều đang thử nghiệm mô hình này trong các ứng dụng quản lý kinh doanh, chăm sóc khách hàng và sáng tạo nội dung. Tuy nhiên, cùng với tiềm năng khổng lồ, công nghệ này cũng đặt ra những lo ngại về kiểm soát đạo đức, tính minh bạch và an toàn dữ liệu. Các chuyên gia khuyến nghị rằng cần sớm thiết lập khuôn khổ pháp lý quốc tế để đảm bảo sự phát triển bền vững của AI tự chủ, tránh nguy cơ lạm dụng hoặc sai lệch mục tiêu. Dù còn nhiều thách thức, Agentic AI được kỳ vọng sẽ thay đổi căn bản cách con người tương tác với công nghệ, mở ra một kỷ nguyên mới nơi máy móc không chỉ hỗ trợ mà còn trở thành đối tác thực thụ trong quá trình ra quyết định.',
    'images/agent_ai.jpg', 
    '2025-10-05 11:30:00', 'pv02', 2150, 'CN', 1
),
(
    'TT001', 
    N'Chung kết UEFA Champions League 2025 sẽ diễn ra tại sân Allianz Arena, Munich',
    N'Liên đoàn Bóng đá châu Âu (UEFA) đã chính thức xác nhận trận chung kết UEFA Champions League 2025 sẽ được tổ chức tại sân vận động Allianz Arena, thành phố Munich, Đức. Đây là lần thứ hai trong vòng hơn một thập kỷ Munich được vinh dự đăng cai sự kiện thể thao danh giá này. Công tác chuẩn bị đang được chính quyền thành phố và ban tổ chức địa phương gấp rút hoàn thiện, bao gồm nâng cấp cơ sở hạ tầng, giao thông và an ninh. UEFA cho biết họ kỳ vọng trận đấu năm nay sẽ thu hút hàng trăm nghìn người hâm mộ từ khắp nơi trên thế giới, không chỉ tạo ra bầu không khí lễ hội bóng đá sôi động mà còn mang lại nguồn thu lớn cho ngành du lịch và dịch vụ địa phương. Bên cạnh yếu tố chuyên môn, UEFA cũng nhấn mạnh cam kết về phát triển bền vững, khi áp dụng nhiều biện pháp giảm phát thải và tái chế rác thải trong suốt giải đấu. Các đội bóng hàng đầu châu Âu đang bước vào giai đoạn nước rút của mùa giải, và giới chuyên môn dự đoán trận chung kết sẽ là màn so tài hấp dẫn giữa hai đại diện mạnh nhất, hứa hẹn một đêm bóng đá không thể quên tại Munich.',
    'images/champions_league_2025.jpg', 
    '2025-10-03 15:00:00', 'pv01', 3200, 'TT', 1
),
(
    'GT001', 
    N'Bom tấn điện ảnh "Superman" khởi động lại vũ trụ DC sẽ ra rạp vào tháng 7',
    N'Sau nhiều năm chờ đợi, bộ phim "Superman" phiên bản tái khởi động do đạo diễn James Gunn thực hiện đã chính thức ấn định ngày ra mắt toàn cầu vào tháng 7 năm 2025. Dự án này đánh dấu bước khởi đầu cho giai đoạn mới của vũ trụ điện ảnh DC, được kỳ vọng sẽ mang lại luồng gió mới cho thương hiệu siêu anh hùng nổi tiếng. Theo nhà sản xuất, phim sẽ tập trung khắc họa sâu hơn về nguồn gốc, giá trị con người và trách nhiệm của Superman trong một thế giới hiện đại đầy phức tạp. Các nhà phê bình nhận định việc tái định nghĩa nhân vật huyền thoại này là bước đi táo bạo, nhằm tạo sự khác biệt với các phiên bản trước đây. Quá trình quay phim kéo dài gần hai năm với nhiều kỹ xảo tiên tiến và bối cảnh hoành tráng. Warner Bros. cho biết họ đặt nhiều kỳ vọng vào bộ phim, không chỉ ở doanh thu phòng vé mà còn ở khả năng định hình lại hình ảnh DC trong mắt khán giả. Trong khi đó, người hâm mộ toàn cầu đang nóng lòng chờ đợi để xem liệu "Superman" có thể mang lại một cú hích mới cho vũ trụ siêu anh hùng vốn đang cạnh tranh khốc liệt với Marvel hay không.',
    'images/superman_2025.jpg', 
    '2025-10-02 09:45:00', 'pv02', 4100, 'GT', 0
),
(
    'TT002', 
    N'FIFA Club World Cup 2025 phiên bản mở rộng tổ chức tại Mỹ',
    N'Liên đoàn Bóng đá Thế giới (FIFA) xác nhận giải FIFA Club World Cup 2025 sẽ được tổ chức tại Hoa Kỳ với thể thức mở rộng lên 32 đội bóng. Đây là lần đầu tiên trong lịch sử, giải đấu cấp câu lạc bộ quy tụ đông đảo đại diện từ các châu lục đến vậy, tạo ra sự háo hức lớn trong cộng đồng người hâm mộ. Giới chuyên môn đánh giá, việc tổ chức tại Mỹ không chỉ mang ý nghĩa thể thao mà còn thể hiện tầm nhìn chiến lược của FIFA trong việc mở rộng sức ảnh hưởng của bóng đá tại thị trường Bắc Mỹ, nơi World Cup 2026 cũng sẽ diễn ra. Các sân vận động hiện đại tại Los Angeles, Miami, Dallas và New York đang được xem xét để đăng cai những trận đấu quan trọng. FIFA nhấn mạnh mục tiêu của giải đấu lần này là mang đến sân chơi công bằng, hấp dẫn và giàu tính cạnh tranh hơn cho các câu lạc bộ hàng đầu thế giới. Bên cạnh đó, công tác an ninh, truyền thông và hậu cần được đánh giá là ưu tiên hàng đầu nhằm đảm bảo trải nghiệm trọn vẹn cho cầu thủ và khán giả. Với quy mô mở rộng, FIFA Club World Cup 2025 được kỳ vọng sẽ trở thành sự kiện bóng đá cấp câu lạc bộ hoành tráng nhất trong lịch sử.',
    'images/club_world_cup.jpg', 
    '2025-09-28 18:00:00', 'pv01', 1950, 'TT', 0
);
GO

-- NHÓM 2: TỪ CN002 ĐẾN CN003

INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
(
    'CN002',
    N'Bước đột phá trong Điện toán Lượng tử có thể thay đổi ngành dược phẩm',
    N'Một nhóm nghiên cứu tại Viện Công nghệ Massachusetts (MIT) vừa công bố bước tiến quan trọng trong lĩnh vực điện toán lượng tử, hứa hẹn sẽ làm thay đổi toàn bộ quy trình nghiên cứu và phát triển thuốc trong tương lai. Theo báo cáo được đăng tải trên tạp chí Science Advances, các nhà khoa học đã phát triển một thuật toán lượng tử có khả năng mô phỏng các phân tử phức tạp ở cấp độ nguyên tử, điều mà máy tính cổ điển hiện nay chưa thể thực hiện với độ chính xác cao. Công nghệ này có thể giúp rút ngắn đáng kể thời gian thử nghiệm thuốc, đồng thời giảm chi phí nghiên cứu cho các công ty dược phẩm. Các chuyên gia nhận định, nếu được thương mại hóa thành công, điện toán lượng tử sẽ mở ra kỷ nguyên mới trong việc phát hiện hợp chất sinh học, từ đó tăng khả năng chữa trị cho nhiều loại bệnh hiểm nghèo. Tuy nhiên, các nhà phân tích cũng cảnh báo rằng, việc ứng dụng công nghệ này vào thực tế vẫn còn đối mặt với nhiều rào cản kỹ thuật như độ ổn định của qubit, khả năng xử lý lỗi và chi phí sản xuất. Dẫu vậy, thông báo của MIT đã tạo ra làn sóng quan tâm mạnh mẽ trong cộng đồng khoa học, khi nhiều tập đoàn công nghệ và dược phẩm lớn tuyên bố sẽ hợp tác để khai thác tiềm năng to lớn của điện toán lượng tử trong những năm tới.',
    'images/quantum_computing.jpg',
    '2025-09-30 14:00:00', 'pv02', 1800, 'CN', 1
),
(
    'GT002',
    N'Captain America: Brave New World nhận được phản ứng tích cực sau buổi chiếu sớm',
    N'Bộ phim “Captain America: Brave New World” đã có buổi công chiếu sớm tại Los Angeles và nhận về nhiều đánh giá tích cực từ giới phê bình lẫn khán giả. Đây là phần thứ tư trong loạt phim Captain America, đồng thời là tác phẩm đầu tiên có Anthony Mackie đảm nhận vai chính kể từ sau khi nhân vật Steve Rogers nghỉ hưu trong “Avengers: Endgame”. Theo phản hồi ban đầu, bộ phim mang đến sự kết hợp hài hòa giữa hành động kịch tính, yếu tố chính trị và chiều sâu nhân vật. Đạo diễn Julius Onah được khen ngợi vì đã mang lại phong cách kể chuyện mới mẻ, trong khi phần âm nhạc và kỹ xảo cũng được đánh giá là một trong những điểm mạnh của phim. Nhà sản xuất Marvel Studios cho biết, đây là tác phẩm quan trọng mở đầu cho giai đoạn mới của vũ trụ điện ảnh Marvel, đánh dấu hướng đi trưởng thành và thực tế hơn. Dù vẫn còn một số ý kiến cho rằng mạch phim hơi dài, phần lớn đánh giá đều khẳng định “Brave New World” đã thành công trong việc làm mới biểu tượng Captain America cho thế hệ khán giả mới. Phim dự kiến sẽ ra mắt toàn cầu vào cuối tháng 10, với kỳ vọng trở thành một trong những bom tấn doanh thu lớn nhất năm 2025.',
    'images/captain_america.jpg',
    '2025-09-29 10:20:00', 'pv02', 3500, 'GT', 1
),
(
    'TG002',
    N'IMF cảnh báo về triển vọng kinh tế không đồng đều cho các quốc gia đang phát triển',
    N'Báo cáo triển vọng kinh tế thế giới mới nhất của Quỹ Tiền tệ Quốc tế (IMF) cho thấy đà phục hồi kinh tế toàn cầu trong năm 2025 đang có dấu hiệu chậm lại, đặc biệt tại các quốc gia đang phát triển. Nguyên nhân chính được cho là do lạm phát kéo dài, chi phí vay vốn tăng cao và sự biến động trong thương mại quốc tế. IMF nhận định, trong khi các nền kinh tế phát triển như Mỹ và khu vực đồng euro đang dần ổn định trở lại, nhiều nước ở châu Phi, Nam Á và Mỹ Latinh vẫn đang phải đối mặt với nguy cơ suy giảm tăng trưởng. Báo cáo cũng cảnh báo về sự bất bình đẳng gia tăng trong phân bổ vốn đầu tư và nguồn lực tài chính toàn cầu, khi các quốc gia giàu có dễ dàng tiếp cận nguồn vốn rẻ hơn. Giới chuyên gia cho rằng các tổ chức tài chính quốc tế cần tăng cường hỗ trợ các nền kinh tế dễ tổn thương thông qua các gói tín dụng ưu đãi và chính sách nợ linh hoạt. IMF kêu gọi các nước phối hợp chính sách tiền tệ và tài khóa nhằm đảm bảo ổn định tài chính, đồng thời thúc đẩy thương mại bền vững. Dù dự báo tăng trưởng toàn cầu năm 2025 đạt khoảng 3%, IMF nhấn mạnh rủi ro vẫn còn cao nếu căng thẳng địa chính trị và biến động giá năng lượng tiếp tục leo thang.',
    'images/imf_report.jpg',
    '2025-09-27 19:00:00', 'pv01', 950, 'TG', 0
),
(
    'TT003',
    N'Lịch thi đấu Wimbledon 2025 được công bố, hứa hẹn nhiều trận cầu đỉnh cao',
    N'Ban tổ chức giải quần vợt Wimbledon đã chính thức công bố lịch thi đấu cho mùa giải 2025, đánh dấu sự trở lại của một trong bốn giải Grand Slam danh giá nhất thế giới. Theo kế hoạch, giải sẽ diễn ra từ ngày 23 tháng 6 đến ngày 6 tháng 7 tại All England Club, London. Nhiều tay vợt hàng đầu như Novak Djokovic, Carlos Alcaraz, Iga Świątek và Coco Gauff đã xác nhận tham dự. Wimbledon năm nay được dự đoán sẽ chứng kiến sự cạnh tranh khốc liệt giữa các thế hệ vận động viên, đặc biệt khi những gương mặt trẻ đang dần khẳng định vị thế trên bảng xếp hạng thế giới. Ban tổ chức cũng cho biết họ đã đầu tư nâng cấp hệ thống sân bãi và công nghệ hỗ trợ thi đấu, đồng thời tăng cường các biện pháp bảo vệ môi trường như sử dụng năng lượng tái tạo và hạn chế rác thải nhựa. Ngoài yếu tố chuyên môn, Wimbledon 2025 còn thu hút sự quan tâm nhờ các hoạt động văn hóa bên lề, giúp du khách có thêm trải nghiệm tại London. Giới hâm mộ kỳ vọng giải đấu năm nay sẽ tiếp tục duy trì phong độ chuyên nghiệp, tinh thần thể thao và truyền thống lịch sử đã làm nên tên tuổi của Wimbledon suốt hơn một thế kỷ qua.',
    'images/wimbledon.jpg',
    '2025-09-26 11:00:00', 'pv01', 2800, 'TT', 0
),
(
    'CN003',
    N'Kỷ nguyên "Spatial Computing": Apple và Meta cạnh tranh gay gắt',
    N'Năm 2025 đánh dấu giai đoạn cạnh tranh khốc liệt giữa hai ông lớn công nghệ Apple và Meta trong lĩnh vực Spatial Computing – công nghệ kết hợp giữa thực tế ảo (VR), thực tế tăng cường (AR) và trí tuệ nhân tạo (AI) nhằm tạo ra không gian kỹ thuật số tương tác ba chiều. Apple tiếp tục mở rộng hệ sinh thái Vision Pro, trong khi Meta đẩy mạnh dòng sản phẩm Quest thế hệ mới, hướng đến người dùng doanh nghiệp và giáo dục. Các chuyên gia nhận định, Spatial Computing sẽ là nền tảng chủ chốt định hình tương lai của giao tiếp, làm việc và giải trí. Bên cạnh những bước tiến công nghệ, cả hai công ty đều phải đối mặt với bài toán về quyền riêng tư, chi phí phần cứng và thói quen người dùng. Một số nhà phân tích cho rằng, nếu tìm được mô hình ứng dụng thực tiễn, Spatial Computing có thể trở thành bước ngoặt tương tự sự ra đời của điện thoại thông minh hơn một thập kỷ trước. Trong khi đó, các doanh nghiệp khởi nghiệp cũng đang tận dụng xu hướng này để phát triển ứng dụng y tế, đào tạo và thiết kế 3D. Dù còn nhiều thách thức, cuộc đua giữa Apple và Meta đang góp phần thúc đẩy mạnh mẽ sự phát triển của công nghệ tương tác không gian, mở ra chương mới cho ngành công nghiệp số toàn cầu.',
    'images/spatial_computing.jpg',
    '2025-09-25 08:30:00', 'pv02', 1200, 'CN', 0
);
GO

-- NHÓM 3: TỪ GT003 ĐẾN TT004

INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
(
    'GT003',
    N'Zootopia 2 công bố ngày phát hành chính thức vào cuối năm 2025',
    N'Studio Walt Disney Animation đã chính thức xác nhận phần tiếp theo của bộ phim hoạt hình đình đám “Zootopia” sẽ ra mắt khán giả toàn cầu vào kỳ nghỉ lễ cuối năm 2025. Thông tin này đã khiến cộng đồng người hâm mộ trên toàn thế giới vô cùng háo hức, khi phần đầu tiên ra mắt năm 2016 từng đạt doanh thu hơn 1 tỷ USD và giành giải Oscar cho “Phim hoạt hình xuất sắc nhất”. Theo đại diện Disney, “Zootopia 2” sẽ tiếp nối câu chuyện của hai nhân vật chính Judy Hopps và Nick Wilde trong bối cảnh thành phố động vật đang phải đối mặt với những thay đổi lớn về xã hội. Bộ phim được cho là sẽ khai thác sâu hơn các chủ đề về niềm tin, sự đa dạng và tinh thần đoàn kết – những yếu tố từng làm nên thành công của phần đầu. Các nhà sản xuất tiết lộ rằng nhóm biên kịch cũ đã trở lại, đồng thời áp dụng công nghệ hoạt hình mới giúp hình ảnh mượt mà và sống động hơn. Disney cũng cho biết phần âm nhạc tiếp tục được đầu tư mạnh, với sự tham gia của nhiều nghệ sĩ nổi tiếng. Giới phân tích nhận định “Zootopia 2” có tiềm năng trở thành một trong những tác phẩm hoạt hình được mong đợi nhất thập kỷ, hứa hẹn vừa đáp ứng kỳ vọng của khán giả cũ, vừa thu hút thế hệ khán giả trẻ mới.',
    'images/zootopia_2.jpg',
    '2025-09-24 16:45:00', 'pv02', 5100, 'GT', 1
),
(
    'TG003',
    N'Hội nghị thượng đỉnh về khí hậu COP30 đặt ra mục tiêu tham vọng mới',
    N'Hội nghị thượng đỉnh về khí hậu COP30 diễn ra tại thành phố Belém, Brazil đã thu hút sự tham dự của hơn 190 quốc gia cùng hàng nghìn nhà hoạt động môi trường và tổ chức quốc tế. Năm 2025 được xem là thời điểm quan trọng khi các nước cần đánh giá lại tiến độ thực hiện cam kết cắt giảm phát thải theo Thỏa thuận Paris. Tại hội nghị, nhiều quốc gia phát triển cam kết tăng mức đóng góp tài chính cho Quỹ Khí hậu Xanh, nhằm hỗ trợ các nền kinh tế đang phát triển ứng phó với biến đổi khí hậu. Một trong những điểm nhấn của COP30 là việc thống nhất mục tiêu giảm ít nhất 50% lượng khí thải toàn cầu vào năm 2035 và đạt phát thải ròng bằng 0 vào năm 2050. Tuy nhiên, các nhà quan sát cho rằng việc hiện thực hóa các cam kết này vẫn gặp nhiều thách thức, đặc biệt là vấn đề nguồn lực và sự chênh lệch trong năng lực công nghệ giữa các quốc gia. Đại diện Liên Hợp Quốc nhấn mạnh, hợp tác quốc tế là chìa khóa để đạt được tiến bộ thực chất. Hội nghị cũng khép lại với lời kêu gọi các chính phủ đưa chính sách xanh vào chiến lược phát triển kinh tế quốc gia, qua đó cân bằng giữa tăng trưởng và bảo vệ môi trường. Các tổ chức môi trường đánh giá COP30 là bước tiến tích cực nhưng cho rằng cần thêm hành động cụ thể thay vì chỉ cam kết.',
    'images/cop30.jpg',
    '2025-09-23 21:00:00', 'pv01', 750, 'TG', 0
),
(
    'TT004',
    N'Super Bowl LIX: New Orleans chuẩn bị cho sự kiện thể thao lớn nhất nước Mỹ',
    N'Thành phố New Orleans đang gấp rút hoàn tất công tác chuẩn bị cho Super Bowl lần thứ 59 (Super Bowl LIX), sự kiện thể thao được mong đợi nhất trong năm tại Hoa Kỳ. Trận đấu dự kiến diễn ra vào tháng 2 năm 2025 tại sân vận động Caesars Superdome, với sức chứa hơn 70.000 khán giả. Giới chức thành phố cho biết họ đã phối hợp chặt chẽ với các cơ quan an ninh, y tế và giao thông nhằm đảm bảo mọi hoạt động diễn ra suôn sẻ. Ngoài trận đấu chính, hàng loạt sự kiện âm nhạc, diễu hành và chương trình văn hóa bên lề cũng đang được lên kế hoạch, dự kiến thu hút hàng trăm nghìn du khách trong và ngoài nước. Ban tổ chức NFL nhấn mạnh rằng năm nay họ sẽ áp dụng nhiều công nghệ mới để cải thiện trải nghiệm của người hâm mộ, bao gồm phát sóng 8K và hệ thống tương tác thời gian thực. Bên cạnh đó, Super Bowl LIX cũng hướng đến mục tiêu phát triển bền vững với các chương trình tái chế, giảm rác thải và sử dụng năng lượng sạch. Các chuyên gia kinh tế ước tính sự kiện này có thể mang lại doanh thu hơn 500 triệu USD cho New Orleans. Với truyền thống thể thao, âm nhạc và ẩm thực đặc sắc, Super Bowl LIX được kỳ vọng không chỉ là ngày hội bóng bầu dục mà còn là dịp quảng bá hình ảnh nước Mỹ đến toàn cầu.',
    'images/super_bowl_lix.jpg',
    '2025-09-22 13:10:00', 'pv01', 2500, 'TT', 1
);
GO

-- NHÓM 4: TỪ CN004 ĐẾN GT004

INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
(
    'CN004',
    N'Luật quản lý AI toàn cầu: Bước tiến và những tranh cãi',
    N'Nhiều quốc gia trên thế giới đang khẩn trương xây dựng khung pháp lý để quản lý sự phát triển của trí tuệ nhân tạo (AI), trong bối cảnh công nghệ này ngày càng có ảnh hưởng sâu rộng đến đời sống kinh tế – xã hội. Liên minh châu Âu đã đi đầu với Đạo luật AI (AI Act) dự kiến có hiệu lực vào cuối năm nay, đặt ra các tiêu chuẩn nghiêm ngặt về tính minh bạch, an toàn và trách nhiệm của nhà phát triển. Trong khi đó, Mỹ, Anh, Trung Quốc và nhiều nước châu Á cũng đang nghiên cứu các mô hình điều chỉnh phù hợp với hệ thống pháp luật riêng. Tuy nhiên, quá trình này không hề dễ dàng khi nhiều ý kiến cho rằng việc kiểm soát AI cần linh hoạt để không cản trở đổi mới sáng tạo. Các chuyên gia cảnh báo rằng nếu quy định quá chặt, doanh nghiệp nhỏ có thể gặp khó trong việc tiếp cận công nghệ mới; ngược lại, nếu quá lỏng lẻo, rủi ro lạm dụng và vi phạm quyền riêng tư sẽ gia tăng. Nhiều tổ chức nhân quyền cũng kêu gọi các chính phủ cần có quy định rõ ràng về việc sử dụng AI trong giám sát, quảng cáo và ra quyết định tự động. Theo các nhà phân tích, việc thiết lập chuẩn mực toàn cầu về AI sẽ cần thêm thời gian và đối thoại đa phương, song đây là bước đi cần thiết để đảm bảo công nghệ phục vụ lợi ích chung của nhân loại thay vì trở thành mối nguy tiềm ẩn.',
    'images/ai_governance.jpg',
    '2025-09-21 10:00:00', 'pv02', 1100, 'CN', 0
),
(
    'GT004',
    N'Marvel Studios hé lộ dàn diễn viên cho "The Fantastic Four: First Steps"',
    N'Sau nhiều đồn đoán kéo dài, Marvel Studios đã chính thức công bố dàn diễn viên chính cho bộ phim “The Fantastic Four: First Steps”, dự kiến ra mắt vào mùa hè năm 2026. Đây là dự án mở đầu cho giai đoạn tiếp theo của vũ trụ điện ảnh Marvel (MCU) và được xem là một trong những bộ phim được kỳ vọng nhất trong những năm gần đây. Theo thông tin từ hãng, bộ phim sẽ có sự góp mặt của các diễn viên trẻ tiềm năng cùng một số ngôi sao kỳ cựu nhằm tạo nên sự cân bằng giữa sức hút thương mại và chiều sâu diễn xuất. Đạo diễn Matt Shakman cho biết ông muốn mang đến một tầm nhìn mới mẻ cho nhóm siêu anh hùng biểu tượng này, tập trung nhiều hơn vào yếu tố gia đình, tình đồng đội và những mâu thuẫn nội tâm của từng nhân vật. Phần kịch bản được đánh giá là có chiều sâu hơn, khai thác bối cảnh khoa học song hành cùng cảm xúc con người. Giới chuyên môn nhận định đây là nỗ lực của Marvel nhằm khôi phục vị thế sau giai đoạn phim siêu anh hùng bị đánh giá là bão hòa. Trong khi đó, cộng đồng người hâm mộ bày tỏ sự háo hức nhưng cũng kỳ vọng hãng phim sẽ mang đến những đổi mới đáng kể về nội dung lẫn hình ảnh. “The Fantastic Four: First Steps” được kỳ vọng sẽ mở ra chương mới đầy hứng khởi cho vũ trụ điện ảnh Marvel.',
    'images/fantastic_four.jpg',
    '2025-09-20 17:30:00', 'pv02', 6200, 'GT', 0
);
GO

-- NHÓM 5: TỪ TG004 ĐẾN TG005

INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
(
    'TG004',
    N'Tình hình chiến sự Ukraine: Nỗ lực ngoại giao tìm kiếm hòa bình',
    N'Tình hình xung đột tại Ukraine tiếp tục là tâm điểm chú ý của cộng đồng quốc tế trong năm 2025, khi các bên liên quan đang tăng cường các nỗ lực ngoại giao nhằm tìm kiếm giải pháp hòa bình bền vững. Theo nhiều nguồn tin ngoại giao, Liên Hợp Quốc, Liên minh châu Âu và Tổ chức An ninh và Hợp tác châu Âu (OSCE) đang đóng vai trò trung gian thúc đẩy đối thoại giữa các bên. Các cuộc gặp cấp cao gần đây tại Thổ Nhĩ Kỳ và Thụy Sĩ được xem là tín hiệu tích cực, dù vẫn còn nhiều khác biệt về lập trường. Giới quan sát cho rằng mục tiêu trước mắt là đạt được thỏa thuận ngừng bắn nhân đạo, mở đường cho việc viện trợ dân sự và trao đổi tù nhân. Trong khi đó, các nước châu Âu tiếp tục cung cấp viện trợ nhân đạo và hỗ trợ tái thiết các vùng bị ảnh hưởng nặng nề bởi chiến sự. Mỹ và nhiều quốc gia G7 kêu gọi duy trì các biện pháp trừng phạt kinh tế cho đến khi đạt được tiến triển rõ ràng về mặt ngoại giao. Tại Kyiv, chính quyền Ukraine khẳng định sẽ không từ bỏ mục tiêu bảo vệ toàn vẹn lãnh thổ nhưng sẵn sàng đối thoại trên cơ sở tôn trọng chủ quyền quốc gia. Các chuyên gia phân tích nhận định, con đường hướng tới hòa bình vẫn còn dài, song việc các bên bắt đầu quay lại bàn đàm phán cho thấy hy vọng về một giải pháp chính trị lâu dài đang dần xuất hiện.',
    'images/ukraine_peace.jpg',
    '2025-09-19 23:00:00', 'pv01', 890, 'TG', 0
),
(
    'TT005',
    N'Lộ trình Tour de France 2025 được hé lộ với nhiều chặng đua khắc nghiệt',
    N'Ban tổ chức Tour de France vừa công bố lộ trình chính thức cho mùa giải 2025, hứa hẹn sẽ mang đến những chặng đua đầy thử thách và kịch tính. Giải đấu năm nay sẽ bắt đầu tại thành phố Lille ở miền Bắc nước Pháp và kết thúc tại đại lộ Champs-Élysées, Paris, sau hơn 3.400 km tranh tài. Điểm đáng chú ý là việc ban tổ chức bổ sung thêm nhiều chặng leo núi mới ở dãy Alps và Pyrenees, được đánh giá là sẽ làm thay đổi cục diện cuộc đua. Các tay đua hàng đầu thế giới như Tadej Pogačar, Jonas Vingegaard và Remco Evenepoel đều đã xác nhận tham dự, hứa hẹn cuộc cạnh tranh gay gắt cho chiếc áo vàng danh giá. Ngoài yếu tố chuyên môn, Tour de France 2025 còn chú trọng đến công tác bảo vệ môi trường khi toàn bộ đoàn đua sẽ sử dụng phương tiện hỗ trợ điện và giảm thiểu chất thải nhựa. Sự kiện cũng mang lại lợi ích kinh tế to lớn cho các địa phương đăng cai, thu hút hàng triệu khách du lịch và người hâm mộ. Theo thống kê, Tour de France là giải thể thao được theo dõi nhiều thứ hai thế giới chỉ sau Olympic. Với những thay đổi mang tính chiến lược, mùa giải năm 2025 được kỳ vọng sẽ là một trong những kỳ Tour hấp dẫn và khó đoán nhất trong lịch sử.',
    'images/tour_de_france.jpg',
    '2025-09-18 12:00:00', 'pv01', 1400, 'TT', 0
),
(
    'CN005',
    N'Mạng 5G và IoT: Tương lai của thành phố thông minh đang đến gần',
    N'Sự phổ cập mạnh mẽ của mạng 5G trên toàn cầu đang tạo động lực lớn cho sự phát triển của Internet vạn vật (IoT), đặc biệt trong lĩnh vực đô thị thông minh. Theo báo cáo mới nhất của Liên minh Viễn thông Quốc tế (ITU), năm 2025 đánh dấu bước ngoặt khi hơn 70% thành phố lớn trên thế giới đã triển khai hệ thống kết nối 5G, giúp các thiết bị và hạ tầng đô thị hoạt động đồng bộ, hiệu quả hơn. Ứng dụng IoT trong giao thông, năng lượng và y tế đang mang lại nhiều lợi ích rõ rệt như giảm ùn tắc, tiết kiệm điện năng và nâng cao chất lượng chăm sóc sức khỏe. Các chuyên gia cho rằng sự kết hợp giữa 5G và IoT sẽ đóng vai trò quan trọng trong quá trình chuyển đổi số, giúp chính quyền đô thị quản lý dữ liệu theo thời gian thực, tối ưu hóa dịch vụ công và nâng cao an toàn xã hội. Tuy nhiên, đi kèm với đó là những thách thức về bảo mật và quyền riêng tư, khi số lượng thiết bị kết nối tăng nhanh kéo theo nguy cơ rò rỉ dữ liệu. Nhiều quốc gia đang triển khai các tiêu chuẩn an ninh mạng nghiêm ngặt để đảm bảo tính toàn vẹn hệ thống. Dù còn một số trở ngại, giới quan sát tin rằng việc kết hợp 5G và IoT sẽ là nền tảng quan trọng thúc đẩy sự hình thành của các thành phố thông minh bền vững trong thập kỷ tới.',
    'images/5g_iot.jpg',
    '2025-09-17 09:00:00', 'pv02', 1350, 'CN', 0
),
(
    'GT005',
    N'"Tron: Ares" với sự tham gia của Jared Leto ấn định ngày ra mắt',
    N'Hãng phim Walt Disney đã chính thức công bố ngày phát hành của “Tron: Ares” – phần tiếp theo trong loạt phim khoa học viễn tưởng kinh điển “Tron”, với sự tham gia của nam diễn viên Jared Leto trong vai chính. Bộ phim được ấn định ra mắt vào đầu năm 2026, đánh dấu sự trở lại của thương hiệu điện ảnh từng được xem là biểu tượng công nghệ trong thập niên 1980. “Tron: Ares” do đạo diễn Joachim Rønning chỉ đạo, hứa hẹn mang đến một thế giới kỹ thuật số hoành tráng kết hợp giữa hiệu ứng hình ảnh tiên tiến và cốt truyện nhân văn. Theo thông tin từ Disney, phần mới sẽ tiếp nối câu chuyện từ “Tron: Legacy” (2010), tập trung vào nhân vật Ares – chương trình máy tính đầu tiên có khả năng bước vào thế giới con người. Các nhà sản xuất cho biết quá trình quay phim đã hoàn tất và khâu hậu kỳ đang được thực hiện với công nghệ đồ họa tiên tiến nhất hiện nay. Giới phê bình nhận định “Tron: Ares” có thể trở thành một trong những tác phẩm đánh dấu sự phục hưng của thể loại khoa học viễn tưởng, vốn đang lấy lại sức hút sau thời gian dài trầm lắng. Với sự tham gia của dàn diễn viên tài năng và đội ngũ sản xuất giàu kinh nghiệm, bộ phim được kỳ vọng sẽ mang đến một trải nghiệm hình ảnh mãn nhãn và sâu sắc cho khán giả yêu điện ảnh công nghệ cao.',
    'images/tron_ares.jpg',
    '2025-09-16 18:20:00', 'pv02', 3800, 'GT', 0
),
(
    'TG005',
    N'Ba Lan tổ chức bầu cử tổng thống trong bối cảnh châu Âu nhiều biến động',
    N'Cuộc bầu cử tổng thống tại Ba Lan năm 2025 đang thu hút sự chú ý đặc biệt của cộng đồng quốc tế, khi kết quả được dự báo có thể ảnh hưởng đáng kể đến định hướng chính trị của cả Liên minh châu Âu. Các ứng cử viên chính đang tập trung vào những vấn đề then chốt như an ninh khu vực, chính sách năng lượng và quan hệ với Brussels. Theo các cuộc khảo sát gần đây, tỷ lệ cử tri quan tâm đến bầu cử năm nay cao hơn so với kỳ trước, cho thấy mức độ kỳ vọng lớn vào sự thay đổi. Chính phủ đương nhiệm cam kết duy trì lập trường cứng rắn về an ninh, đồng thời tăng cường hợp tác kinh tế trong khu vực. Trong khi đó, phe đối lập kêu gọi chính sách cân bằng hơn với EU, hướng tới cải thiện quan hệ ngoại giao và thu hút đầu tư nước ngoài. Các quan sát viên từ Tổ chức An ninh và Hợp tác châu Âu (OSCE) đã được mời tham gia giám sát quá trình bỏ phiếu để đảm bảo tính minh bạch. Giới phân tích cho rằng kết quả bầu cử tại Ba Lan có thể tác động đến cục diện chính trị toàn châu Âu, đặc biệt trong bối cảnh khối EU đang đối mặt với nhiều thách thức như khủng hoảng năng lượng, di cư và an ninh biên giới. Dù kết quả ra sao, cuộc bầu cử này được xem là phép thử quan trọng đối với nền dân chủ của Ba Lan và vai trò của nước này trong khu vực Trung – Đông Âu.',
    'images/poland_election.jpg',
    '2025-09-15 20:00:00', 'pv01', 600, 'TG', 0
);
GO

-- 4. THÊM DỮ LIỆU CHO BẢNG ĐĂNG KÝ NHẬN TIN (NEWSLETTERS)
INSERT INTO NEWSLETTERS (Email, Enabled) VALUES
('testuser1@gmail.com', 1),
('testuser2@gmail.com', 1),
('testuser3@gmail.com', 0);
GO

-- 5. THÊM DỮ LIỆU CHO BẢNG VẬT PHẨM (REWARDS)
INSERT INTO REWARDS (Id, [Name], PointsRequired, Image) VALUES
('VOUCHER_20K', N'Voucher giảm giá 20.000đ', 200, 'images/rewards/voucher_20k.png'),
('CUP_ABC', N'Ly sứ độc quyền ABC News', 500, 'images/rewards/cup_abc.png'),
('TSHIRT_ABC', N'Áo thun ABC News', 1200, 'images/rewards/tshirt_abc.png'),
('VOUCHER_100K', N'Voucher mua sắm 100.000đ', 1000, 'images/rewards/voucher_100k.png');
GO

-- 1️⃣ Cập nhật Role cho tài khoản có tên 'Trọng Văn' thành 2
UPDATE USERS
SET Role = 2
WHERE Fullname = N'Trọng Văn';

-- 2️⃣ Cập nhật Role cho tài khoản có tên '8th November' thành 1
UPDATE USERS
SET Role = 1
WHERE Fullname = N'8th November';



