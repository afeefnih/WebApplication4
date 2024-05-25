<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginStatus.ascx.cs" Inherits="WebApplication4105.UserControls.WebUserControl1" %>

<asp:HyperLink ID="HyperLinkLogin" runat="server" NavigateUrl ="~/Login.aspx">Login</asp:HyperLink>
&nbsp;&nbsp;

<asp:HyperLink ID="HyperLinkRegister" runat="server" NavigateUrl ="~/Register.aspx">Register</asp:HyperLink>
&nbsp;&nbsp;

<asp:Label ID="lblLoginStatus" runat="server"></asp:Label> &nbsp;&nbsp;

<asp:Button ID="btnLogout" runat="server" Text="Logut" OnClick="btnLogout_Click" />
