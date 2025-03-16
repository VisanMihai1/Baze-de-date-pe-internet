<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Graphics.aspx.cs" Inherits="BDISimpre.Graphics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Width="285px">
        <asp:ListItem Selected="True"></asp:ListItem>
        <asp:ListItem>Linie</asp:ListItem>
        <asp:ListItem>Bare</asp:ListItem>
        <asp:ListItem>Pie</asp:ListItem>
    </asp:DropDownList>
    <asp:GridView ID="GridView1" runat="server">
</asp:GridView>
</asp:Content>
