<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="BaiTapLTW.Home" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang Chủ</title>
     <link rel="stylesheet" href="TrangChu.css" runat="server" >
     <script type="text/javascript">
       const isLoggedIn = <%= (Session["LoggedUser"] != null).ToString().ToLower() %>;
     </script>
</head>
<body>
    <header>
        <a href="Home.aspx"><span>TRANG CHỦ</span></a>
    <a href="../SanPham/SanPham.aspx"><span>SẢN PHẨM</span></a>
    <img id="logo" src="../imgs/logo.png" alt="calie">
    <a href="Home.aspx"><span>HỆ THỐNG CỬA HÀNG </span></a>
   <div class="foruser">
       <% if (Session["LoggedUser"] == null) { %>
   <a href="../DangNhap/Login.aspx"><img src="../imgs/computer-icons-google-account-icon-design-login-png-favpng-jFjxPac6saRuDE3LiyqsYTEZM-removebg-preview.png " alt="">
    <span>ĐĂNG NHẬP</span>
</a>
       <% } else { %>
       <div class="account-wrapper">
    <a  id="acc" onclick="toggleLogout(event)">
        <img src="../imgs/loggedin.png">
        <span>Xin chào, <%= Session["UserName"] %></span>
    </a>
    <div id="logoutBtn" class="logout-menu">
        <a href="../DangXuat/LogOut.aspx">Đăng xuất</a>
    </div>
</div>
<% } %>
   <a href="Cart.aspx"><img src="../imgs/local_mall_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg" alt=""></a>
</div> 
</header>
<div class="body">
    <section class="body1"> <img src="../imgs/banner.jpg" alt="BAPN"></section>
      <section class="carousel-wrapper">
  <h2>NEW COLLECTION</h2>
  <div class="carousel">
    <div class="carousel-track">
      <img src="../imgs/bm1.jpeg" />
      <img src="../imgs/bm2.jpeg" />
      <img src="../imgs/bm3.jpeg" />
      <img src="../imgs/bm4.jpeg" />
      <img src="../imgs/bm5.jpeg" />
      <img src="../imgs/bm6.jpeg" />
      <img src="../imgs/bm7.jpeg" />
      <img src="../imgs/bm8.jpeg" />
    </div>
  </div>
</section>
<section class="multi-carousel-wrapper">
  <h2>CALIE'S CELEB</h2>
  <div class="multi-carousel">
    <div class="multi-carousel-track">
      <img src="../imgs/bm10.png" />
      <img src="../imgs/bm9.png" />
      <img src="../imgs/bm11.png" />
      <img src="../imgs/bm12.png" />
      <img src="../imgs/bm5.jpeg" />
      <img src="../imgs/bm13.png" />
      <img src="../imgs/bm7.jpeg" />
      <img src="../imgs/bm8.jpeg" />
    </div>
  </div>
</section>
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
<script src="TrangChu.js"></script>
</body>
</html>
