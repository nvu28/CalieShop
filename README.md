CalieShop 

Giới thiệu
Dự án FashionShop là website bán hàng thời trang nữ được xây dựng bằng ASP.NET Web Forms.

Mục tiêu: giúp người dùng có thể xem chi tiết sản phẩm, thêm vào giỏ hàng, đặt hàng và quản lý đơn hàng.

Công nghệ sử dụng
Frontend: HTML, CSS, JavaScript
Backend: ASP.NET Web Forms (C#)
Database: SQL Server
Công cụ: Visual Studio, SQL Server Management Studio

Chức năng chính
Đăng nhập/Đăng ký người dùng
Quản lý sản phẩm (thêm, sửa, xóa, xem chi tiết)
Giỏ hàng (thêm sản phẩm, cập nhật số lượng, xóa sản phẩm)
Đặt hàng và quản lý đơn hàng
Phân quyền cơ bản (Admin/User)

Cài đặt & chạy dự án

1.Clone repo về máy:

```bash
git clone https://github.com/<username>/<repo-name>.git
```

2.Tạo database:
Mở SQL Server Management Studio (SSMS).
Import file database.sql (nằm cùng cấp với .sln).
Nếu cần, chỉnh sửa tên database trong file SQL cho phù hợp.

3.Cấu hình kết nối database:
Mở file Web.config trong dự án ASP.NET.
Tìm phần <connectionStrings> và chỉnh sửa:
Thay YOUR_SERVER_NAME bằng tên server SQL của bạn.
Thay YOUR_DATABASE_NAME bằng tên database đã tạo từ file SQL.

4.Chạy dự án:
Mở bằng Visual Studio.
Build và chạy (F5).
