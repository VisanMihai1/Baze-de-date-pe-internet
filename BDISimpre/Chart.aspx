<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Chart.aspx.cs" Inherits="BDISimpre.Chart" %>
<%@ Register assembly="ZedGraph.Web" namespace="ZedGraph.Web" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <cc1:ZedGraphWeb ID="ZedGraphWeb1" runat="server">
    </cc1:ZedGraphWeb>
</asp:Content>
