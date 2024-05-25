<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication4100.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1> Registraion Page </h1>
    <p>
        Enter email as your username : 
        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
    </p>
    <p>
        Enter Password : 
        <asp:TextBox ID="txtPassword" runat="server"
            TextMode ="Password"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />

    </p>
    <p>
        <asp:Label ID="lblMessage" runat="server" Text="Status:"></asp:Label>
        </p>
</asp:Content>
