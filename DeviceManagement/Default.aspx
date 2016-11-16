<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DeviceManagement.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater runat="server" ID="repListSoftware">
        <ItemTemplate>
            <div style="float:left; border: 1px solid #d7d7d7; padding: 10px; margin: 20px;">
                test
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
