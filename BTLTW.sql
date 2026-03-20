create database BTLTW
on(
name=BTLTW_dat,
filename = 'C:\ThucHanhSQL_Vu_2310A03\BTLTWdat.mdf',

size = 10,

maxsize =50,
filegrowth=5
)
log on (
name =BanHang_log,
filename = 'C:\ThucHanhSQL_Vu_2310A03\BTLTWlog.ldf',
size=5,

maxsize =25,
filegrowth=5
)
USE BTLTW;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),   -- Mã sản phẩm tự tăng
    Name NVARCHAR(255) NOT NULL,               -- Tên sản phẩm
    Price DECIMAL(18,0) NOT NULL,              -- Giá sản phẩm
    ImagePath NVARCHAR(255) NOT NULL     -- Đường dẫn ảnh
);
INSERT INTO Products (Name, Price, ImagePath)
VALUES 
(N'Quần jean ống loe cạp cao', 495000, '../imgs/sp01.jpeg'),
(N'Áo sơ mi dáng suông thêu nơ ngực', 465000, '../imgs/sp02.jpeg'),
(N'Váy dáng A giả set phối cổ kem', 695000, '../imgs/sp03.jpeg'),
(N'Váy dáng xòe phối cổ đính nơ ngực', 645000, '../imgs/sp04.jpeg'),
(N'Váy dáng xòe smoking phối cổ trắng', 695000, '../imgs/sp05.jpeg'),
(N'Áo cách điệu đính nơ kim loại', 465000, '../imgs/sp06.jpeg'),
(N'Áo cách điệu dáng lửng phối đáp ngực', 495000, '../imgs/sp07.jpeg'),
(N'Váy dáng xòe giả sét đính nơ ngực', 695000, '../imgs/sp08.jpeg'),
(N'Váy dáng xòe giả sét xếp ly ngực', 695000, '../imgs/sp09.jpeg'),
(N'Áo cách điệu xếp smoking thân trước', 495000, '../imgs/sp10.jpeg'),
(N'Áo cổ polo tay cộc basic', 395000, '../imgs/sp11.jpeg'),
(N'Áo dệt kim cổ tròn basic', 345000, '../imgs/sp12.jpeg'),
(N'Chân váy xòe dáng ngắn xếp ly', 465000, '../imgs/sp13.jpeg'),
(N'Áo peplum cổ đức phối bèo tay cộc', 455000, '../imgs/sp14.jpeg'),
(N'Váy dáng xòe đức nơ rời', 635000, '../imgs/sp15.jpeg'),
(N'Chân váy dáng xòe 7 mảnh chun sau', 395000, '../imgs/sp16.jpeg');

CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,             -- ID người dùng
    ProductID INT NOT NULL,          -- ID sản phẩm
    Quantity INT NOT NULL DEFAULT 1, -- số lượng mặc định = 1
    CONSTRAINT FK_Cart_Product FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),   -- Khóa chính, tự tăng
    Username NVARCHAR(50) UNIQUE NOT NULL,  -- Tên đăng nhập, không trùng
    Password NVARCHAR(255) NOT NULL, 
	 Role NVARCHAR(20) NOT NULL DEFAULT 'user'
);
INSERT INTO Users (Username, Password, Role)
VALUES ('admin', '123456', 'admin');

CREATE TABLE DonHang (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Size NVARCHAR(10) NULL,   -- 👉 thêm cột Size
    OrderDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);




