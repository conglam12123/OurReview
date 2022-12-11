<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="SearchUser.aspx.cs" Inherits="OurReview.SearchUser" %>
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
        .SearchFunction {
            display: flex;
            justify-content: space-around;
            height: 42px;
        }
        .SearchResult {
            display: block;
            justify-content: space-around;
            width: 250px;
            margin: auto;
            border-radius: 3px;
        }
        .container {
            border: 1px solid #1f7bf9;
            width: 300px;
            border-radius: 3px;
        }
        .SearchResultDetail {
            display: flex;
            justify-content: space-around;
            text-align: center;
            background-color: ghostwhite;
            margin-bottom: 4px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .avatarImg {
            border-radius: 50%;
            margin: 15px auto 12px;
        }
        .lbMessage {
            color: #787272;
            padding: 4px 0;
            background-color: #ffd800;
            padding-left: 40px;
            margin: 12px auto;
            width: 210px;
        }
        .title {
            text-align: center;
            margin-bottom: 0;
            margin-top: 6px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <div class="container">
            <%--            <h3 class="title">Tìm kiếm người dùng</h3>
            <div class="SearchFunction">
                <p>
                    <asp:TextBox ID="txtFind" runat="server"></asp:TextBox>
                </p>
                <p>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </p>
            </div>--%>
            <p class="lbMessage">
                <asp:Label ID="lbMessage" runat="server" Text=""></asp:Label>
            </p>

            <div class="SearchResult">
                <asp:Repeater ID="RptSearch" runat="server">
                    <ItemTemplate>
                        <div class="SearchResultDetail">
                            <p>
                                <img class="avatarImg" width="50" height="50" src="<%#Eval("sUserAvatar") %>" />
                            </p>

                            <p style="font-weight: bold; margin: 30px;">
                                <a style="text-decoration: none;"
                                    href="ProfileUser.aspx?ProfileID1=<%#Eval("PK_iUserID") %>" ><%#Eval("sUserName") %></a>
                            </p>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
