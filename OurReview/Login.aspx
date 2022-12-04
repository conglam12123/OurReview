<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OurReview.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="./Assets/css/global.css" />
    <link rel="stylesheet" href="./Assets/css/register.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="register-body">    
            <img class="register-logo" src="./Assets/img/Logo.png"/ alt="OurReview" title="OurReview"/>

            <div class ="register-input">
                <span class="required">Email:</span>
                <asp:TextBox runat="server" ID="tbEmail" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="rfvEmail" runat="server" 
                    ControlToValidate="tbEmail" 
                    SetFocusOnError="true" 
                    ErrorMessage="Hãy nhập email!" 
                    Display="None"></asp:RequiredFieldValidator>     
            </div>
            <div class ="register-input">
                <span class="required">Mật khẩu:</span>
                <asp:TextBox runat="server" ID="tbPassword" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="rfvPass" runat="server" 
                    ControlToValidate="tbPassword" 
                    SetFocusOnError="true" 
                    ErrorMessage="Hãy nhập mật khẩu!" 
                    Display="None"></asp:RequiredFieldValidator>     
            </div>
            <div class="register-action">
                <asp:Label runat="server" ID="lbError" CssClass="login-errormsg"></asp:Label>
                <asp:ValidationSummary runat="server" ID="vSummary" DisplayMode="BulletList" ShowSummary="true" ForeColor="Red" Font-Size="12px"/>
                <asp:Button runat="server" ID="btnLogin" text="Đăng nhập" OnClick="btnLogin_Click"/> <br />
                <span > Hoặc <a href="" id="registerLink" runat="server"> Đăng Ký </a> nếu bạn là thành viên mới</span>
            </div>
        </div>
        </div>
    </form>
</body>
</html>
