<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="BaiTapLTW.Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="GioHang.css" runat="server" >
    <script type="text/javascript">
        function selectSize(size, btn) {
            const cartItem = btn.closest(".cart-item");
            const hfSize = cartItem.querySelector("input[id$='hfSize']");
            if (hfSize) hfSize.value = size;

            const sizeInfo = cartItem.querySelector(".size-value");
            if (sizeInfo) {
                switch (size) {
                    case "S": sizeInfo.innerHTML = "<b>S</b> (45-50kg; 150-155cm)"; break;
                    case "M": sizeInfo.innerHTML = "<b>M</b> (48-54kg; 157-160cm)"; break;
                    case "L": sizeInfo.innerHTML = "<b>L</b> (55-60kg; 160-165cm)"; break;
                    case "XL": sizeInfo.innerHTML = "<b>XL</b> (60-70kg; 165-170cm)"; break;
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager1" runat="server" />
       <div class="panel">
    <div class="leftpanel">  
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
    <asp:Repeater ID="rptCart" runat="server">
      <ItemTemplate>
        <div class="cart-item">
          <!-- Ảnh sản phẩm -->
          <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("Name") %>' class="product-img" />

          <!-- Thông tin sản phẩm -->
          <div class="details">
            <h2><%# Eval("Name") %></h2>
            <p class="price"><%# Eval("Price") %> đ</p>
<!-- Khối chọn size -->
<div class="clicksize">
  <div class="size">
  <span>Kích cỡ</span>
  <span class="size-value">Chưa chọn</span>
  </div>
  <div class="btsize">
    <button type="button" onclick="selectSize('S', this)">S</button>
    <button type="button" onclick="selectSize('M',this)">M</button>
    <button type="button" onclick="selectSize('L',this)">L</button>
    <button type="button" onclick="selectSize('XL',this)">XL</button>
  </div>
</div>
<asp:HiddenField ID="hfSize" runat="server" Value="M" />
<asp:HiddenField ID="hfProductID" runat="server" Value='<%# Eval("ProductID") %>' />




            <!-- Khối số lượng -->
         <div class="quantity-block">
    <label>Số lượng</label>
    <div class="quantity">
        <asp:Button ID="btnDecrease" runat="server" Text="-" 
            CommandArgument='<%# Eval("ProductID") %>' 
            OnCommand="btnDecrease_Command" 
            CssClass="qty-btn" />

        <asp:TextBox ID="txtQty" runat="server" 
            Text='<%# Eval("Quantity") %>' 
            CssClass="qty-box" ReadOnly="true" />

        <asp:Button ID="btnIncrease" runat="server" Text="+" 
            CommandArgument='<%# Eval("ProductID") %>' 
            OnCommand="btnIncrease_Command" 
            CssClass="qty-btn" />
    </div>
</div>

          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>

    <!-- Tổng tiền -->
    <div class="summary">
      <p><strong>Tổng tiền cần thanh toán:</strong> 
         <asp:Label ID="lblTotal" runat="server" CssClass="total" />
      </p>
    </div>
  </ContentTemplate>
</asp:UpdatePanel>
    </div>
  


<div class="right-panel">
    <h3>Thông tin đặt hàng</h3>
    <p class="note">Bạn cần nhập đầy đủ các trường thông tin có dấu *</p>
   <asp:TextBox ID="txtName" runat="server" placeholder="Họ tên *" CssClass="input" />
<asp:TextBox ID="txtPhone" runat="server" placeholder="Số điện thoại *" CssClass="input" />
<asp:TextBox ID="txtEmail" runat="server" placeholder="Email *" CssClass="input" />

<asp:Button ID="btnConfirm" runat="server" Text="XÁC NHẬN VÀ ĐẶT HÀNG"
            CssClass="confirm-btn" OnClick="btnConfirm_Click" />

  </div>
</div>
<script src="GioHang.js"></script>
        </form>
</body>
</html>
