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