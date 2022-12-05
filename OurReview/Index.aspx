<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OurReview.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OurReview</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="true"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="./Assets/css/global.css" />
    <link rel="stylesheet" type="text/css" href="./Assets/css/index1.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" 
        integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" 
        crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">
            <div class="header">
                
                <a class="header__logo" href="Index.aspx">
                    <img class="logo__image" src="./Assets/img/small_logo.png" title="OurReview" alt="Mạng xã hội review"/>
                
                </a>
                <div class="header__search">
                    <asp:TextBox runat="server" placeholder="Tìm kiếm..."
                        ID="tbSearch" CssClass="header__search-box">
                    </asp:TextBox>
                    <div> 
                        <asp:DropDownList CssClass="header__search-option" runat="server" ID="lbxSearchOption">
                            <asp:ListItem id="liUser" Value="soUser">
                                Tìm người dùng
                            </asp:ListItem>
                            <asp:ListItem id="liPost" Value="soPost">
                                Tìm bài viết
                            </asp:ListItem>

                        </asp:DropDownList>
                        <button class="header__search-button">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </div>
                <div class="header__account header__account--user">
                    <a class="header__account-link" href="Login.aspx">Đăng nhập/Đăng ký</a>
                    <a href="#" class="header__account-avatar">
                        <img  src="./Assets/img/avatar/DefaultAvatar.png" 
                            title="Avatar" alt="Ảnh đại diện"/>
                    </a>
                </div>
            </div> 


            <div class="content">

            </div>
            <div class="footer">

            </div>
        </div>
    </form>
</body>
</html>
