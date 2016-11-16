<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DeviceManagement.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .item-icon {
            margin:0 auto;
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
                <div class="item-soft">
                    <img src="http://static.nguyenkimmall.com/images/thumbnails/250/250/detailed/180/dien-thoai-samsung-galaxy-j7-2016-vang-0.jpg" alt="Điện thoại Samsung Galaxy J7 2016 chính hãng tại Nguyễn Kim" title="SAMSUNG GALAXY J7 2016" class="item-icon"/>
                    Phần mềm diệt vi rut
                <a href="index.php?dispatch=products.view&amp;product_id=45098" class="btn btn-primary">Xem ngay</a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
