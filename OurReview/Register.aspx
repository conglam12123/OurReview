<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OurReview.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng ký tài khoản</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="./Assets/css/global.css" />
    <link rel="stylesheet" href="./Assets/css/register.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-body">    
            <img class="register-logo" src="./Assets/img/Logo.png"/ alt="OurReview" title="OurReview"/>
            <div class ="register-input">
                <span class="required">Họ và tên:</span>
                <asp:TextBox runat="server" ID="tbUsername">  </asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="rfvUsername" runat="server" 
                    ControlToValidate="tbUsername" 
                    SetFocusOnError="true" 
                    ErrorMessage="Hãy nhập tên bạn!" 
                    Display="None"></asp:RequiredFieldValidator>              
            </div>
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
            <div class ="register-input">
                <span class="required">Nhập lại mật khẩu:</span>
                <asp:TextBox runat="server" ID="tbRepass" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="rfvRepass" runat="server" 
                    ControlToValidate="tbRepass" 
                    SetFocusOnError="true" 
                    ErrorMessage="Hãy nhập lại mật khẩu!" 
                    Display="None"></asp:RequiredFieldValidator>     
                <asp:CompareValidator ID="cvRepass"
                    runat="server" 
                    ControlToValidate="tbRepass" 
                    ControlToCompare="tbPassword" 
                    Operator="Equal"
                    Display="None"
                    ErrorMessage="Bạn phải nhập đúng mật khẩu!"
                    ></asp:CompareValidator>
            </div>
            <div class ="register-input">
                <span>Thêm ảnh đại diện của bạn:</span>
                <asp:FileUpload runat="server" ID="fuUserAvatar"/>
            </div>
            <div class="register-action">
                <asp:ValidationSummary runat="server" ID="vSummary" DisplayMode="BulletList" ShowSummary="true" ForeColor="Red" Font-Size="12px"/>
                <asp:Button runat="server" ID="btnRegister" text="Đăng ký" OnClick="btnRegister_Click"/> <br />
                <span > Hoặc <a href="#" runat="server" id="loginLink"> Đăng nhập </a> nếu đã có tài khoản</span>
            </div>
        </div>
    </form>
</body>
</html>
