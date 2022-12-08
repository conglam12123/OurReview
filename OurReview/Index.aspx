<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OurReview.Index1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                            <asp:RequiredFieldValidator ID="vPostContentUpload" runat="server" 
                                ControlToValidate="tbPostContent" Display="Dynamic" ErrorMessage="Bạn cần nhập nội dung bài viết" 
                                ValidationGroup="upload" ForeColor="Red">

                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="upload__picture">
                            <span>Chọn ảnh</span>
                            <asp:FileUpload runat="server" ID="fuPostImage"  />
                        </div>
                        <div class="upload__buttons">
                            <asp:Button ID="btnUpload" runat="server" text="Đăng bài viết" OnClick="btnUpload_Click" ValidationGroup="upload"/>
                            <asp:Button ID="btnCancelUpload" runat="server" Text="Hủy" OnClick="btnCancelUpload_Click"/>
                        </div>
                    </div>
                            
                </div>
                <div class="content__post-view"> 
                    <asp:Repeater ID="rptPostsByCategories" runat="server" OnItemDataBound="rptPostsByCategories_ItemDataBound">
                        <ItemTemplate>
                            <div class="post__view-category">
                                <a class="post__view-category-header"  href="Category.aspx?id=<%#Eval("PK_iCategoryID") %>"><%#Eval("sCategoryName") %></a>
                            </div>
                            <asp:HiddenField ID="hfCategoryID" runat="server" Value='<%#Eval("PK_iCategoryID") %>'/>
                            <asp:Repeater runat="server" ID="rptPostsOfCategories">
                                <ItemTemplate>
                                    <div class="post">
                                        <div class="post__user">
                                            <a class="post__user-link" href="" >
                                                <img Class="post__user-avatar" src="<%#Eval("sUserAvatar") %>" />
                                            </a>
                                            <a class="post__user-link" href="" >
                                                <span Class="post__user-name"><%#Eval("sUserName") %></span>
                                            </a>
                                            <span class="post__time"><%#Eval("dPostedDateTime") %></span>
                                        </div>
                                        <p class="post__content"><%#Eval("sPostContent") %></p>
                                        <img class="post__image" src="<%#Eval("sPostImageUrl") %>"/>
                                        <div class="post__action">
                                            <button class="post__action-like"><i class="fa-solid fa-thumbs-up"></i> Thích (<%#Eval("likecount") %>)</button>
                                            <button claa="post__action-comment"><i class="fa-solid fa-comment"></i>Bình luận (<%#Eval("commentcount") %>)</button>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:Repeater> <%--repeater categories--%>
                </div> <%--Content__post-view--%>
            </div><%--Content__main--%>
        </div>
    </div>
</asp:Content>
