<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication4100.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Admin Page</h1>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connShop %>" DeleteCommand="DELETE FROM [UserAccounts] WHERE [Id] = @Id" InsertCommand="INSERT INTO [UserAccounts] ([UserName], [PasswordHash], [Role], [Enabled]) VALUES (@UserName, @PasswordHash, @Role, @Enabled)" SelectCommand="SELECT * FROM [UserAccounts]" UpdateCommand="UPDATE [UserAccounts] SET [UserName] = @UserName, [PasswordHash] = @PasswordHash, [Role] = @Role, [Enabled] = @Enabled WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Enabled" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="PasswordHash" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Enabled" Type="Boolean" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
        </Columns>
    </asp:GridView>
</asp:Content>
