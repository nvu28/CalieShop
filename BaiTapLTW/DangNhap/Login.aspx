<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BaiTapLTW.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>
    <style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f5f5f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .box {
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.2);
        width: 350px;
        text-align: center;
    }
    .form-input {
        width: 100%;
        padding: 12px 40px 12px 12px;
        margin: 8px 0;
        border: 1.5px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 15px;
        transition: border 0.3s;
    }
    .form-input:focus {
        border-color: #43a047;
        outline: none;
    }
    .password-wrapper {
        position: relative;
    }
    .toggle-password {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: #666;
        font-size: 14px;
        user-select: none;
    }
    .toggle-password:hover {
        color: #43a047;
    }
    .btn {
        background-color: #43a047;
        color: white;
        border: none;
        padding: 12px;
        width: 100%;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
        font-size: 16px;
        margin-top: 10px;
        transition: 0.3s;
    }
    .btn:hover {
        background-color: #2e7d32;
    }
    .signup, .login-link {
        margin-top: 15px;
        font-size: 14px;
    }
    .signup a, .login-link a {
        color: #43a047;
        text-decoration: none;
        font-weight: bold;
    }
    .signup a:hover, .login-link a:hover {
        text-decoration: underline;
    }
</style>

<script>
    function togglePassword(inputId, spanElement) {
        var input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            spanElement.textContent = "Ẩn";
        } else {
            input.type = "password";
            spanElement.textContent = "Hiện";
        }
    }
</script>
</head>
<body>
      <form id="form1" runat="server">
       <div class="box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png" alt="Logo" style="width:60px; margin-bottom:10px;" />
            <h2>Đăng nhập tài khoản</h2>

            <asp:TextBox ID="txtUsername" runat="server" placeholder="Tên đăng nhập" CssClass="form-input" ClientIDMode="Static"></asp:TextBox>

            <div class="password-wrapper">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Mật khẩu" CssClass="form-input" ClientIDMode="Static"></asp:TextBox>
                <span class="toggle-password" onclick="togglePassword('txtPassword', this)">Hiện</span>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display:block; margin:10px 0;"></asp:Label>

            <div class="login-link">
                Chưa có tài khoản? <a href="../DangKy/DangKy.aspx">Đăng ký ngay</a>
            </div>
</div>
    </form>
</body>
</html>
