<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IndexOld.aspx.cs" Inherits="OurReview.Index" %>

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
                <div class="grid wrapper__header">
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
                        <asp:Image runat="server" ID="imgAvatar" src="./Assets/img/avatar/DefaultAvatar.png" 
                            title="Avatar" alt="Ảnh đại diện"/>
                    </a>
                    <ul class="header__user-option">
                        <li class="user__option-item">
                            <a href="#">Sửa thông tin tài khoản</a>
                        </li>
                        <li class="user__option-item">
                            <a href="#">Đăng xuất</a>
                        </li>
                    </ul>
                </div>
                </div>
            </div> 


            <div class="content ">
                <div class="wrapper grid">
                    <div class="categories">
                        <h3 class="categories__header"> <i class="category__heading-icon fa-solid fa-list"></i> <span>Danh mục</span></h3>
                        <asp:Repeater ID="rptCategories" runat="server">
                            <ItemTemplate>
                                <div class="categories__item">
                                    <a class="categories__item-link" href=""><%#Eval("sCategoryName")%></a>
                                    <%--<asp:Repeater runat="server" ID="rptPost">
                                        <ItemTemplate>
                                            <>
                                        </ItemTemplate>
                                    </asp:Repeater>--%>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="content__main">
                        <div class="content__post-upload"> 
                            <h2 class="upload__header">Thêm bài viết mới</h2>
                            <div class="upload__body">
                                <div class="upload__categories">
                                    <span>Chọn danh mục:</span>
                                    <asp:dropdownList ID="drlCategories" runat="server"></asp:dropdownList>
                                </div>
                                <div class="upload__input">
                                    <span>Nhập nội dung bài viết:</span>
                                    <asp:TextBox ID="tbPostContent" runat="server" CssClass="upload__content"></asp:TextBox>
                                </div>
                                <div class="upload__picture">
                                    <span>Chọn ảnh</span>
                                    <asp:FileUpload runat="server" ID="fuPostImage"  />
                                </div>
                                <div class="upload__buttons">
                                    <asp:Button runat="server" text="Đăng bài viết"/>
                                    <asp:Button runat="server" Text="Hủy" />
                                </div>
                            </div>
                            
                        </div>
                        <div class="content__post-view"> 

                        </div>
                    </div>
                </div>

            </div>
            <div class="footer">
                <h3 class="footer__credit">Thiết kế và phát triển bởi N01 - AAW0212022.002</h3>
                
            </div>
        </div>
    </form>
</body>
</html>
