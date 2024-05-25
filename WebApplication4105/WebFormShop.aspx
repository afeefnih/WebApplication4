
<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="WebFormShop.aspx.cs" Inherits="WebApplication4105.WebFormShop" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="Styles/StyleSheet1.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="leftColumn">
    <h4>Sales Item</h4>
    <p>
        Select Category: &nbsp;
        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceCategories" DataTextField="CatTitle" DataValueField="CatId" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
        <br />
    </p>
    <asp:GridView ID="GridViewItems" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ItemId" DataSourceID="SqlDataSourceItems" PageSize="5" OnSelectedIndexChanged="GridViewItems_SelectedIndexChanged">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="ItemId" HeaderText="ItemId" InsertVisible="False" ReadOnly="True" SortExpression="ItemId" />
            <asp:BoundField DataField="ItemTitle" HeaderText="ItemTitle" SortExpression="ItemTitle" />
            <asp:BoundField DataField="ItemPrice" DataFormatString="{0:n2}" HeaderText="ItemPrice (RM)" SortExpression="ItemPrice" />
            <asp:BoundField DataField="ItemDesc" HeaderText="ItemDesc" SortExpression="ItemDesc" />
            <asp:ImageField DataImageUrlField="ItemImage" DataImageUrlFormatString="Images/{0}" HeaderText="Image">
                <ControlStyle Width="30px" />
            </asp:ImageField>
        </Columns>
    </asp:GridView>

    <p>
        Item ID:
        <asp:Label ID="lblItemId" runat="server"></asp:Label>&nbsp;|
        Title:
        <asp:Label ID="lblItemTitle" runat="server"></asp:Label>&nbsp;|
        Item Price: RM
        <asp:Label ID="lblItemPrice" runat="server"></asp:Label>&nbsp;
    </p>
    <p>
        Quantity:
        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Width="50px">1</asp:TextBox>&nbsp;
        <asp:Button ID="btnAddItem" runat="server" Text="Add Item to Cart" OnClick="btnAddItem_Click" />
    </p>
    <p>
        <asp:Label ID="lblMessage1" runat="server"></asp:Label>
    </p>
</div>
<br />
<div class="rightColumn">
    <h4>Sales Cart</h4>
    <p>
        Sales ID:
        <asp:Label ID="lblSalesId" runat="server"></asp:Label>&nbsp;|
        Date & Time:
        <asp:Label ID="lblDateTime" runat="server"></asp:Label>&nbsp;|
    </p>
    <p>
        <asp:GridView ID="GridViewCart" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCart">
            <Columns>
                <asp:BoundField DataField="ItemId" HeaderText="ItemId" SortExpression="ItemId" />
                <asp:BoundField DataField="ItemTitle" HeaderText="ItemTitle" SortExpression="ItemTitle" />
                <asp:BoundField DataField="ItemPrice" HeaderText="ItemPrice (RM)" SortExpression="ItemPrice" DataFormatString="{0:n2}" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                <asp:BoundField DataField="SubTotal" HeaderText="SubTotal (RM)" ReadOnly="True" SortExpression="SubTotal" DataFormatString="{0:n2}" />
            </Columns>
        </asp:GridView>
        Total Amount:
        <asp:Label ID="lblTotalAmountCart" runat="server" Text="RM0.00"></asp:Label>
    </p>
    <p>
        <asp:Button ID="btnConfirm" runat="server" Text="Confirm Sales" OnClick="btnConfirm_Click" />&nbsp;
        <asp:Button ID="btnCancel" runat="server" Text="Cancel Sales" OnClick="btnCancel_Click" />&nbsp;
        <asp:Button ID="btnNew" runat="server" Text="New Sales" OnClick="btnNew_Click" />
    </p>
    <p>
        <asp:Label ID="lblMessage2" runat="server"></asp:Label>
    </p>
    <p>
        <asp:Label ID="lblTotalAmount" runat="server"></asp:Label><br />
        <asp:Label ID="lblServiceTax" runat="server"></asp:Label><br />
        <asp:Label ID="lblAmountAfterTax" runat="server"></asp:Label><br />
        <asp:Label ID="lblRounding" runat="server"></asp:Label><br />
        <asp:Label ID="lblAmountRounded" runat="server"></asp:Label>
    </p>
</div>
<asp:SqlDataSource ID="SqlDataSourceCategories" runat="server" ConnectionString="<%$ ConnectionStrings:connShop %>" SelectCommand="SELECT * FROM [Categories] ORDER BY [CatTitle]"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:connShop %>" SelectCommand="SELECT * FROM [Items] WHERE ([CatId] = @CatId)">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlCategory" Name="CatId" PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceCart" runat="server" ConnectionString="<%$ ConnectionStrings:connShop %>" SelectCommand="spSalesGetItems" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="lblSalesId" Name="salesid" PropertyName="Text" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>




