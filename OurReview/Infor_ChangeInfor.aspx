<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Infor_ChangeInfor.aspx.cs" Inherits="OurReview.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .total {
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container_wrap {
      /*      width: 100vw;
            height: 100vh;*/
            display: block;
            justify-content: center;
            align-items: center;
        }

        .container {
            border: 1px solid #0094ff;
            width: 360px;
            margin: auto;
            padding: 20px;
            border-radius: 2px;
        }

        .avatarImg {
            object-fit: cover;
            border-radius: 2px;
        }


        .updateName {
            display: flex;
            justify-content: space-between;
        }

        .updateAvatar {
            display: flex;
            justify-content: space-between;
        }
        /*  update name*/
        .changeNameGr {
            border: 1px solid #0094ff;
            width: 215px;
            margin: auto;
            padding: 10px;
            border-radius: 2px;
            margin-top: 20px;
        }

        .confirmName {
            display: flex;
            justify-content: space-evenly;
            margin-bottom: 0;
        }

        .nameChange {
            margin: auto;
            text-align: center;
        }
        /* update avatar*/
        .changeAvatarGr {
            border: 1px solid #0094ff;
            width: 215px;
            margin: auto;
            padding: 10px;
            border-radius: 2px;
            margin-top: 20px;
        }

        .confirmAvatar {
            display: flex;
            justify-content: space-evenly;
            margin-bottom: 0;
        }

        .avatarChange {
            margin: auto;
            text-align: center;
            margin-bottom: 12px
        }

        .title {
            font-size: 15px;
            margin-bottom: 16px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--all để trong ContentTemplate, ContenTemplate để trong UpdatePanel--%>
    <asp:ScriptManager ID="ScriptManager1"
        runat="server">
    </asp:ScriptManager>
    <%--muốn update gì để nó trong UpdatePanel, k để tất cả thường chỉ update 1,2 cái--%>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="content">
                <div class="container_wrap">
                    <div class="container">
                        <h1 style="margin-bottom: 4px; text-align: center; font-size: 18px;">Thông tin cá nhân</h1>
                        <asp:Repeater ID="rptInforGr" runat="server" OnItemCommand="rptInforGr_ItemCommand" OnItemDataBound="rptInforGr_ItemDataBound">
                            <ItemTemplate>
                                <div>
                                    <p>
                                        <asp:HiddenField ID="hfID" runat="server" Value='<%#Eval("PK_iUserID") %>' />
                                    </p>

                                    <div class="updateName">
                                        <p class="title">Tên: <span style="font-weight: bold"><%#Eval("sUserName") %></span></p>
                                        <p>
                                            <asp:LinkButton ID="btnUpdateNames" runat="server" Text="Chỉnh sửa" OnClick="btnUpdateNames_Click"></asp:LinkButton>
                                        </p>
                                    </div>
                                    <div class="updateAvatar">
                                        <p class="title">Ảnh đại diện </p>
                                        <p>
                                            <asp:LinkButton ID="btnUpdateAvatar" runat="server" Text="Chỉnh sửa" OnClick="btnUpdateAvatar_Click"></asp:LinkButton>
                                        </p>
                                    </div>

                                    <div class="imageContain">
                                        <img class="avatarImg" width="360" height="360" src="<%#Eval("sUserAvatar") %>"></img>
                                    </div>

                                </div>
                            </ItemTemplate>

                        </asp:Repeater>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                        <%--            <asp:Repeater ID="rptImg" runat="server">
                <ItemTemplate>
                    <p>
                        <img class="avatar" src="<%#Eval("sImageAvatar") %>"></img>
                    </p>
                </ItemTemplate>
            </asp:Repeater>--%>
                    </div>
                    <div class="changeNameGr" id="changeNameGr" runat="server">
                        <p class="nameChange" style="margin-bottom: 16px">
                            Tên: 
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                        </p>
                        <p class="confirmName">
                            <asp:Button ID="btnCancelUpdateName" runat="server" Text="Hủy" OnClick="btnCancelUpdateName_Click" />
                            <asp:Button ID="btnUpdateName" runat="server" Text="Lưu" OnClick="btnUpdateName_Click" />
                        </p>
                    </div>

                    <div class="changeAvatarGr" id="changeAvatarGr" runat="server">
                        <p style="margin-bottom: 5px; margin-top: 2px; font-weight: bold;">
                            Chọn ảnh đại diện:
                        </p>
                        <p class="avatarChange">
                            <asp:FileUpload ID="fulAvatar" runat="server" />
                        </p>
                        <p class="confirmAvatar">
                            <asp:Button ID="btnCancelUpdateAva" runat="server" Text="Hủy" OnClick="btnCancelUpdateAva_Click" />
                            <asp:Button ID="btnUpdateAva" runat="server" Text="Lưu" OnClick="btnUpdateAva_Click" />
                        </p>
                    </div>
        </ContentTemplate>
        <%--lưu lại hình ảnh khi update lên server, nếu k có khi sửa k lưu đc ảnh--%>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnUpdateAva" />
        </Triggers>
    </asp:UpdatePanel>
    </div>
    </div>
</asp:Content>
