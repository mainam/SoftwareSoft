<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SoftwareStore.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .item-icon {
            margin: 0 auto;
            width: 230px;
            height: 250px;
        }

        .item-soft {
            float: left;
            border: 1px solid #d7d7d7;
            padding: 10px;
            margin: 10px;
            width: 250px;
            height: 350px;
            overflow: hidden;
        }

            .item-soft:hover {
                -webkit-box-shadow: 0px 3px 15px rgba(0,0,0,0.3);
                -moz-box-shadow: 0px 3px 15px rgba(0,0,0,0.3);
                box-shadow: 0px 3px 15px rgba(0,0,0,0.3);
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin: 0 auto">
        <asp:Repeater runat="server" ID="repListSoftware">
            <ItemTemplate>
                <a class="item-soft" href="/Detail.aspx?id=12334">
                    <img src="http://static.nguyenkimmall.com/images/thumbnails/250/250/detailed/180/dien-thoai-samsung-galaxy-j7-2016-vang-0.jpg" alt="Điện thoại Samsung Galaxy J7 2016 chính hãng tại Nguyễn Kim" title="SAMSUNG GALAXY J7 2016" class="item-icon" />
                    Phần mềm diệt vi rut
                    <br />
                    Mai Ngoc Nam
                    <br />
                    20.11.2016
                <span class="btn btn-primary">Xem ngay</span>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
