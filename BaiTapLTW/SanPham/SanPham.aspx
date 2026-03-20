<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="BaiTapLTW.SanPham" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sản Phẩm</title>
    <link rel="stylesheet" href="Product.css" runat="server">
     <script type="text/javascript">
       const isLoggedIn = <%= (Session["LoggedUser"] != null).ToString().ToLower() %>;
     </script>
</head>
<body>
    <form id="form1" runat="server">
          <asp:ScriptManager ID="ScriptManager1" runat="server" />
      <header>
        <a href="../TrangChu/Home.aspx"><span>TRANG CHỦ</span></a>
    <a href="SanPham.aspx"><span>SẢN PHẨM</span></a>
    <img id="logo" src="../imgs/logo.png" alt="calie">
    <a href="../TrangChu/Home.aspx"><span>HỆ THỐNG CỬA HÀNG </span></a>
   <div class="foruser">
   <% if (Session["LoggedUser"] == null) { %>
   <a href="../DangNhap/Login.aspx"><img src="../imgs/computer-icons-google-account-icon-design-login-png-favpng-jFjxPac6saRuDE3LiyqsYTEZM-removebg-preview.png " alt="">
    <span>ĐĂNG NHẬP</span>
</a>
       <% } else { %>
       <div class="account-wrapper">
    <a " id="acc" onclick="toggleLogout(event)">
        <img src="../imgs/loggedin.png">
        <span>Xin chào, <%= Session["UserName"] %></span>
    </a>
    <div id="logoutBtn" class="logout-menu">
        <a href="../DangXuat/LogOut.aspx">Đăng xuất</a>
    </div>
</div>
<% } %>
   <a href="../GioHang/Cart.aspx"><img src="../imgs/local_mall_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg" alt=""></a>
</div> 
</header>
<div class="body">
    <div class="grid">
  <asp:Repeater ID="rptProducts" runat="server">
  <ItemTemplate>
    <div class="product">
    <asp:HyperLink ID="hlImage" runat="server" 
    NavigateUrl='<%# "ChiTietSP.aspx?id=" + Eval("ProductID") %>'>
    <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("Name") %>' />
</asp:HyperLink>

      <span><%# Eval("Name") %></span>
      <strong><%# Eval("Price") %> đ</strong>
      <span class="stars">★★★★★</span>
      <asp:Button ID="btnAddToCart" runat="server" 
                  Text="Thêm vào giỏ hàng" 
                  CssClass="add-to-cart"
                  CommandArgument='<%# Eval("ProductID") %>' 
                  OnCommand="btnAddToCart_Command" />
    </div>
  </ItemTemplate>
</asp:Repeater>

  </div>
</div>
<footer>
  <img src="../imgs/footer.png" alt="" class="footer-banner">

  <div class="footer-content">
    <div class="foot1">
      <h4>VỀ CALIE HOUSE</h4>
      <a href="#">Giới thiệu</a>
      <a href="#">Liên hệ</a>
      <a href="#">Tuyển dụng</a>
      <a href="#">Tin tức</a>
      <a href="#">Hệ thống cửa hàng</a>
    </div>

    <div class="foot1">
      <h4>HỖ TRỢ KHÁCH HÀNG</h4>
      <a href="#">Chính sách bảo mật </a>
       <a href="#">Chính sách thanh toán </a>
        <a href="#">Chính sách kiểm hàng </a>
         <a href="#">Chính sách vận chuyển </a>
          <a href="#">Chính sách đổi trả </a>
    </div>

    <div class="foot1">
      <div id="help">
        <h4>STORE CALIE HOUSE</h4>
        <span>099.999.999</span><br>
        <p>(Từ 0h00 đến 24h00)</p>
      </div>
      <div id="media">
        <h4>Kết nối với chúng tôi</h4>
          <div id="icon">
          <a href="#"><img src="../imgs/2023_Facebook_icon.svg.webp" alt=""></a>
          <a href="#"><img src="../imgs/logoyt.jpg" alt=""></a>
          <a href="#"><img src="../imgs/logotiktok.jpg" alt=""></a>
          <a href="#"><img src="../imgs/logoins.jpg" alt=""></a>
        </div>
      </div>
    </div>
  </div>
</footer>
        </form>
</body>
</html>
