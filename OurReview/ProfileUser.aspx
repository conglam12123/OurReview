<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="ProfileUser.aspx.cs" Inherits="OurReview.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        html {
            background-color: #e1f3f0;
        }

        .container_wrap {
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .search_function_gr {
            border-radius: 3px;
            margin: 12px auto;
            background-color: #ffd800;
            padding-top: 8px;
            padding-bottom: px;
        }

        .search_function {
            display: flex;
            justify-content: space-around;
            height: 42px;
        }

        .search_result_wrap {
            display: block;
            border: 1px solid #ff0000;
            width: 420px;
        }

        .search_result {
            display: block;
            justify-content: space-around;
            /*border: 1px solid #ccc;*/
            width: 500px;
            margin: auto
        }

        .container {
            border: 1px solid #ffd800;
            width: 500px;
            margin: auto;
        }

        .search_result_detail {
            display: block;
            justify-content: space-around;
            /*margin: 2px auto;*/
            /*text-align: center;*/
            padding: 16px;
            background-color: ghostwhite;
            margin-bottom: 12px;
        }

        .avatarImg {
            border-radius: 50%;
        }

        .lbMessage {
            margin: 0px auto 8px 70px;
            color: #787272;
        }

        .title {
            text-align: center;
            margin-bottom: 0;
            margin: 14px auto;
        }

        .avatar {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
        }

        .post__image {
            width: 468px;
            height: 468px;
            object-fit: cover;
            border: 1px solid #808080;
            border-radius: 3px;
        }

        .name_avatar {
            display: flex;
        }

        .name-post-gr {
            padding-top: 10px;
            margin-left: 10px;
        }

        .user-name {
            /*padding-top: 18px;*/
            font-weight: bold;
            margin-bottom: 4px;
        }


        .post-time {
            color: cadetblue;
            font-size: 11px;
        }

        .post-content {
            margin: 12px auto;
            /*background-color: antiquewhite;*/
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="container">
            <div class="search_result">
                <asp:Repeater runat="server" ID="RptSearch"  >
                <ItemTemplate>
                    <asp:Panel runat="server" ID="pnPost" CssClass="post" ClientIDMode="Predictable" >
                        <asp:HiddenField runat="server" ID="hfPostID" Value='<%#Eval("PK_iPostID") %>'/>
                        <asp:HiddenField runat="server"  ID="hfPosterID" Value='<%#Eval("FK_iUserID") %>'/>
                        <div class="post__user">
                            <a class="post__user-link" href="#" >
                                <img Class="post__user-avatar" src="<%#Eval("sUserAvatar") %>" />
                            </a>
                            <a class="post__user-link" href="#" >
                                <span Class="post__user-name"><%#Eval("sUserName") %></span>
                            </a>
                            <span class="post__time"><%#Eval("dPostedDateTime") %></span>
                        </div>
                        <p class="post__content"><%#Eval("sPostContent") %></p>
                        <img class="post__image" src="<%#Eval("sPostImageUrl") %>"/>
                        <div class="post__action">
                            <a class="post__action-btn" href="javascript:LikePost(<%#Eval("PK_iPostID") %>)" >
                                <i class="fa-solid fa-thumbs-up"></i>
                                <span>Thích </span>
                                <span class="post__like-count" >(<%#Eval("likecount") %>)</span>
                            </a>
                            <a class="post__action-btn"><i class="fa-solid fa-comment"></i>Bình luận <span class="post__comment-count">(<%#Eval("commentcount") %>)</span> </a>
                            <asp:Label runat="server" ID="lbAlternate" CssClass="post__action-option ">
                                    <a  class="post__action-btn" href="javascript:DeletePost(<%#Eval("PK_iPostID")%>)">Xóa</a>
                                    <a  class="post__action-btn" href="javascript:">Chỉnh sửa</a>
                            </asp:Label>
                        </div>
                    </asp:Panel>
                </ItemTemplate>
            </asp:Repeater>
            </div>
        </div>
</asp:Content>
