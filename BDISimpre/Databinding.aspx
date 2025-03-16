<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Databinding.aspx.cs" Inherits="BDISimpre.Databinding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="denumire" DataValueField="idEditura" Height="29px" Width="185px">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [Editura]"></asp:SqlDataSource>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="idCarte" DataSourceID="SqlDataSource2" Height="204px" Width="388px" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                    <asp:BoundField DataField="idCarte" HeaderText="idCarte" InsertVisible="False" ReadOnly="True" SortExpression="idCarte" />
                    <asp:BoundField DataField="titlu" HeaderText="titlu" SortExpression="titlu" />
                    <asp:BoundField DataField="pret" HeaderText="pret" SortExpression="pret" />
                    <asp:BoundField DataField="idEditura" HeaderText="idEditura" SortExpression="idEditura" />
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Carte] WHERE ([idEditura] = @idEditura)" DeleteCommand="DELETE FROM [Carte] WHERE [idCarte] = @idCarte" InsertCommand="INSERT INTO [Carte] ([titlu], [pret], [idEditura]) VALUES (@titlu, @pret, @idEditura)" UpdateCommand="UPDATE [Carte] SET [titlu] = @titlu, [pret] = @pret, [idEditura] = @idEditura WHERE [idCarte] = @idCarte">
                <DeleteParameters>
                    <asp:Parameter Name="idCarte" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="titlu" Type="String" />
                    <asp:Parameter Name="pret" Type="Double" />
                    <asp:Parameter Name="idEditura" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="idEditura" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="titlu" Type="String" />
                    <asp:Parameter Name="pret" Type="Double" />
                    <asp:Parameter Name="idEditura" Type="Int32" />
                    <asp:Parameter Name="idCarte" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="Label2" runat="server" Text="Titlu"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Pret"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Editura"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="denumire" DataValueField="idEditura" Height="23px" Width="155px">
            </asp:DropDownList>
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Insert" />
            <br />
            <br />
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="idCarte" DataSourceID="SqlDataSource3">
                <Columns>
                    <asp:BoundField DataField="idCarte" HeaderText="idCarte" InsertVisible="False" ReadOnly="True" SortExpression="idCarte" />
                    <asp:BoundField DataField="titlu" HeaderText="titlu" SortExpression="titlu" />
                    <asp:BoundField DataField="pret" HeaderText="pret" SortExpression="pret" />
                    <asp:BoundField DataField="idEditura" HeaderText="idEditura" SortExpression="idEditura" />
                </Columns>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FFF1D4" />
                <SortedAscendingHeaderStyle BackColor="#B95C30" />
                <SortedDescendingCellStyle BackColor="#F1E5CE" />
                <SortedDescendingHeaderStyle BackColor="#93451F" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="GetCarteByPret" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox3" Name="pret" PropertyName="Text" Type="Double" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </div>
    </form>
</body>
</html>
