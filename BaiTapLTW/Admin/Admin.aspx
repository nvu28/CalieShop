<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="BaiTapLTW.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin</title>
       <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #000;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .btn-link {
            display: inline-block;
            padding: 8px 12px;
            background: linear-gradient(90deg, #1e90ff, #6a0dad);
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            margin-right: 10px;
        }
        .btn-link:hover {
            background: linear-gradient(90deg, #6a0dad, #1e90ff);
        }
        .btn-logout {
            background: linear-gradient(45deg, #1e90ff, #32cd32);
            color: white;
            font-weight: bold;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s ease;
        }
        .btn-logout:hover {
            background: linear-gradient(45deg, #32cd32, #1e90ff);
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:Repeater ID="rptDonHang" runat="server" OnItemCommand="rptDonHang_ItemCommand">
    <HeaderTemplate>
        <table>
            <tr>
                <th>Mã đơn</th>
                <th>UserID</th>
                <th>Tên khách</th>
                <th>SĐT</th>
                <th>Email</th>
                <th>Mã SP</th>
                  <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                 <th>Size</th>
                <th>Giá</th>
                <th>Tổng tiền</th>
                <th>Ngày đặt</th>
                <th>Thao tác</th>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Eval("OrderID") %></td>
            <td><%# Eval("UserID") %></td>
            <td><%# Eval("CustomerName") %></td>
            <td><%# Eval("Phone") %></td>
            <td><%# Eval("Email") %></td>
            <td><%# Eval("ProductID") %></td>
             <td><%# Eval("TenSP") %></td>
            <td><%# Eval("Quantity") %></td>
             <td><%# Eval("Size") %></td>
            <td><%# Eval("Price", "{0:N0}") %> ₫</td>
            <td><%# Eval("TongTien", "{0:N0}") %> ₫</td>
            <td><%# ((DateTime)Eval("OrderDate")).ToString("dd/MM/yyyy HH:mm") %></td>
            <td>
                <asp:Button runat="server" Text="Xác nhận" CommandName="xacnhan" CommandArgument='<%# Eval("OrderID") %>' />
                <asp:Button runat="server" Text="Xóa" CommandName="xoa" CommandArgument='<%# Eval("OrderID") %>' />
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>
         <div style="margin-top:20px; text-align:right;">
            <asp:HyperLink ID="lnkQuanLySP" runat="server" 
                Text="Quản lý sản phẩm" 
                NavigateUrl="../QuanLySP/QuanLySP.aspx" 
                CssClass="btn-link" />
            <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" 
                OnClick="btnLogout_Click" CssClass="btn-logout" />
        </div>
    </form>
</body>
</html>
