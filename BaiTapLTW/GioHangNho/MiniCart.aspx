<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiniCart.aspx.cs" Inherits="BaiTapLTW.MiniCart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Mua Hàng</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #fdfdfd;
        padding: 40px;
        color: #333;
    }

    form {
        max-width: 500px;
        margin: auto;
        background-color: #fff;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }

    h2, h3 {
        text-align: center;
        color: #2c3e50;
    }

    p {
        margin-bottom: 15px;
    }

    input[type="text"], input[type="email"], textarea, select, .aspNetTextBox {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .aspNetButton {
        display: block;
        width: 100%;
        padding: 10px;
        background-color: #27ae60;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 20px;
    }

    .aspNetButton:hover {
        background-color: #219150;
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
    <h2>🛒 Đặt Mua sản phẩm</h2>
    <p><strong>Tên sản phẩm:</strong> <asp:Label ID="lblTenSP" runat="server" /></p>
    <p><strong>Giá:</strong> <asp:Label ID="lblGia" runat="server" /></p>
    <p><strong>Số lượng:</strong> <asp:TextBox ID="txtSoLuong" runat="server" Text="1" /></p>

    <hr />
    <h3>Thông tin người mua</h3>
    <p>Tên: <asp:TextBox ID="txtTen" runat="server" /></p>
    <p>SĐT: <asp:TextBox ID="txtSdt" runat="server" /></p>
    <p>Email: <asp:TextBox ID="txtEmail" runat="server" /></p>

    <asp:Button ID="btnXacNhan" runat="server" Text="Xác nhận mua" CssClass="aspNetButton" OnClick="btnXacNhan_Click" />
</form>
</body>
</html>
