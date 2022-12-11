<%@ Page Title="OurReview" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OurReview.Index1" %>
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
                                ControlToValidate="tbPostContent" Display="Dynamic" 
                                ErrorMessage="Bạn cần nhập nội dung bài viết" 
                                ValidationGroup="upload-post" ForeColor="Red">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="upload__picture">
                            <span>Chọn ảnh</span>
                            <asp:FileUpload runat="server" ID="fuPostImage"  />
                        </div>
                        <div class="upload__buttons">
                            <asp:Button ID="btnUpload" runat="server" text="Đăng bài viết" OnClick="btnUpload_Click" ValidationGroup="upload-post"/>
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
                            <asp:HiddenField ID="hfCategoryID" runat="server" Value='<%#Eval("PK_iCategoryID") %>' />
                            <asp:Repeater runat="server" ID="rptPostsOfCategories" OnItemDataBound="rptPostsOfCategories_ItemDataBound" >
                                <ItemTemplate>
                                    <asp:Panel runat="server" ID="pnPost" CssClass="post" ClientIDMode="Predictable" >
                                        <asp:HiddenField runat="server" ID="hfPostID" Value='<%#Eval("PK_iPostID") %>'/>
                                        <asp:HiddenField runat="server"  ID="hfPosterID" Value='<%#Eval("FK_iUserID") %>'/>
                                        <div class="post__user">
                                            <a class="post__user-link" href="ProfileUser.aspx?ProfileID1=<%#Eval("FK_iUserID") %>" >
                                                <img Class="post__user-avatar" src="<%#Eval("sUserAvatar") %>" />
                                            </a>
                                            <a class="post__user-link" href="ProfileUser.aspx?ProfileID1=<%#Eval("FK_iUserID") %>" >
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
                        </ItemTemplate>
                    </asp:Repeater> <%--repeater categories--%>
                </div> <%--Content__post-view--%>
            </div><%--Content__main--%>
        </div>
    </div>
    <script>

        var callbackCompleted = function (data, context) {
            var result = [];
            result = context.split(':');
            console.log('Data: ' + data + ' context= ' + context);
            switch (result[0]) {
                case '<%=DELETE_COMMAND_NAME%>': deleteResult(result[1], data); break;
                case '<%=UNLIKE_COMMAND_NAME%>': unlikeResult(result[1],data) ;break;
                case '<%=LIKE_COMMAND_NAME%>': likeResult(result[1], data); break;
                case '<%=GETLIKE_COMMAND_NAME%>': likeStatusResult(data); break;
            }

        }

        var DeletePost = function (id) {
            confirm('Bạn có chắc là muốn xóa bài viết này không ?');
            let args = '<%=DELETE_COMMAND_NAME%>' + ":" + id;
            let context = '<%=DELETE_COMMAND_NAME%>' + ":" + id;
            <%=CallbackRef %>
        };

        var deleteResult = function (context, data) {
            if (data == 0) {
                alert('Xóa thất bại');
            } else {
                alert('Xóa bài viết thành công');
                var listOfPost = [];
                listOfPost = document.getElementsByClassName("post");
                for (e of listOfPost) {
                    if (e.firstElementChild.value == context) {
                        e.remove();
                    }
                }
            }
        }

        var LikePost = function (id) {
            let args = '';
            let context = '';
            listOfPost = document.getElementsByClassName("post");
            for (e of listOfPost) {
                if (e.firstElementChild.value == id) {
                    if (e.children[5].children[0].classList.contains("liked")) {
                        args = '<%=UNLIKE_COMMAND_NAME%>' + ":" + id;
                        context = '<%=UNLIKE_COMMAND_NAME%>' + ":" + id;
                    }
                    else if (!e.children[5].children[0].classList.contains("liked")) {
                        args = '<%=LIKE_COMMAND_NAME%>' + ":" + id;
                        context = '<%=LIKE_COMMAND_NAME%>' + ":" + id;
                    }
                }
             }
            <%=CallbackRef %>
        }
        var unlikeResult = function (context, data) {
            if (data != -1) {
                listOfPost = document.getElementsByClassName("post");
                for (e of listOfPost) {
                    if (e.firstElementChild.value == context) {
                        e.children[5].children[0].classList.remove("liked");
                        e.children[5].children[0].children[2].innerText = '(' + data + ')';
                    }
                }
            }
        }
        var likeResult = function (context, data) {
            if (data != -1) {
                listOfPost = document.getElementsByClassName("post");
                for (e of listOfPost) {
                    if (e.firstElementChild.value == context) {
                        e.children[5].children[0].classList.add("liked");
                        e.children[5].children[0].children[2].innerText = '(' + data + ')';
                    }
                }
            }
        }
</script>
    <script>
        var getLikeStatus = function () {
            let args = '<%=GETLIKE_COMMAND_NAME%>';
            let context = '<%=GETLIKE_COMMAND_NAME%>';
            <%=CallbackRef %>;
        }

        var likeStatusResult = function  (data) {
            let arr = data.split(':');
            let postlist = [];
            postlist = document.getElementsByClassName("post");
            if (postlist[0] != undefined) {
                for (e of postlist) {
                    for (x of arr) {
                        if (e.firstElementChild.value == x) {
                            e.children[5].children[0].classList.add("liked");
                        }
                    }
                }
            }
        }
        window.onload = getLikeStatus;
    </script>
</asp:Content>
