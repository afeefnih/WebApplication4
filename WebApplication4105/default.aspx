<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebApplication4100._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connShop %>" SelectCommand="SELECT * FROM [Items] ORDER BY [ItemTitle]"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ItemId" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="ItemId" HeaderText="ItemId" InsertVisible="False" ReadOnly="True" SortExpression="ItemId" />
            <asp:BoundField DataField="CatId" HeaderText="CatId" SortExpression="CatId" />
            <asp:BoundField DataField="ItemTitle" HeaderText="ItemTitle" SortExpression="ItemTitle" />
            <asp:BoundField DataField="ItemPrice" DataFormatString="{0:n2}" HeaderText="ItemPrice" SortExpression="ItemPrice" />
            <asp:BoundField DataField="ItemDesc" HeaderText="ItemDesc" SortExpression="ItemDesc" />
            <asp:ImageField DataImageUrlField="ItemImage" DataImageUrlFormatString="Images/{0}" HeaderText="Image">
                <ControlStyle Height="50px" />
            </asp:ImageField>
        </Columns>
    </asp:GridView>
</asp:Content>
