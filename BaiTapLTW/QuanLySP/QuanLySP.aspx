<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLySP.aspx.cs" Inherits="BaiTapCuoiKy.QuanLySP" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Sản Phẩm</title>
    <style>
        .chon-btn {
            font-weight: bold;
            font-size: 14px;
            background: linear-gradient(90deg, #000000, #6a0dad);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            cursor: pointer;
        }
        .chon-btn:hover {
            background: linear-gradient(90deg, #6a0dad, #000000);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txtMaSP" runat="server" Placeholder="Mã SP" />
        <asp:TextBox ID="txtTenSP" runat="server" Placeholder="Tên SP" />
        <asp:TextBox ID="txtHinhAnh" runat="server" Placeholder="URL hình ảnh" />
        <asp:TextBox ID="txtGia" runat="server" Placeholder="Giá" />

        <asp:Button ID="btnThem" runat="server" Text="Thêm" OnClick="btnThem_Click" />
        <asp:Button ID="btnSua" runat="server" Text="Sửa" OnClick="btnSua_Click" />
        <asp:Button ID="btnXoa" runat="server" Text="Xóa" OnClick="btnXoa_Click" />
    </div>

   <asp:Repeater ID="rptSanPham" runat="server" OnItemCommand="rptSanPham_ItemCommand">
    <HeaderTemplate>
        <table border="1" style="border-collapse:collapse; width:100%;">
            <tr>
                <th>Chọn</th>
                <th>Mã SP</th>
                <th>Tên SP</th>
                <th>Hình ảnh</th>
                <th>Giá</th>
            </tr>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td>
                <asp:LinkButton ID="btnChon" runat="server"
                    Text="Chọn"
                    CommandName="Chon"
                    CommandArgument='<%# Eval("ProductID") %>'
                    CssClass="chon-btn" />
            </td>
            <td><%# Eval("ProductID") %></td>
            <td><%# Eval("Name") %></td>
            <td><img src='<%# Eval("ImagePath") %>' alt="Ảnh sản phẩm" style="width:80px;height:auto;" /></td>
            <td><%# Eval("Price", "{0:N0}") %> ₫</td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
        </table>
    </FooterTemplate>
</asp:Repeater>

</form>
</body>
</html>
