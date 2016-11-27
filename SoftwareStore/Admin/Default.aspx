<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SoftwareStore.Admin.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeftMenu" runat="server">
    <li>
        <a href="chuyenmuc/ChuyenMucMgr.aspx"><i class="fa fa-lg fa-fw fa-hdd-o"></i><span class="menu-item-parent">Quản lý chuyên mục</span></a>
    </li>
    <li>
        <a href="taikhoan/TaiKhoanMgr.aspx"><i class="fa fa-lg fa-fw fa-hdd-o"></i><span class="menu-item-parent">Quản lý tài khoản</span></a>
    </li>
    <li>
        <a href="#"><i class="fa fa-lg fa-fw fa-hdd-o"></i><span class="menu-item-parent">Quản lý giao dịch</span></a>
        <ul>
            <li>
                <a href="giaodich/tatcagiaodich.aspx">Tất cả giao dịch</a>
            </li>
            <li>
                <a href="giaodich/giaodichcuatoi.aspx">Giao dịch của bạn</a>
            </li>
        </ul>
    </li>

    <li>
        <a href="giaodich/GiaoDichMgr.aspx"><i class="fa fa-lg fa-fw fa-hdd-o"></i><span class="menu-item-parent">Quản lý giao dịch</span></a>
    </li>
    <li>
        <a href="#"><i class="fa fa-lg fa-fw fa-hdd-o"></i><span class="menu-item-parent">DEVICES</span></a>
        <ul>
            <li runat="server" id="liDeviceManagement"><a href="#">Device Management</a>
                <ul>
                    <li>
                        <a href="device/DeviceManagement.aspx">Device Management</a>
                    </li>
                    <li>
                        <a href="device/management/ListDeviceAvailable.aspx">Set Borrow Devices</a>
                    </li>
                    <li>
                        <a href="device/CommonManagement.aspx">Common</a>
                    </li>
                    <li>
                        <a href="device/ReturnDevice.aspx">Return Devices</a>
                    </li>
                </ul>
            </li>
            <li runat="server" id="menuInventory"><a href="#">Inventory Device</a>
                <ul>
                    <li runat="server" id="liInventoryResolve">
                        <a href="device/InventoryRequest.aspx">Request</a>
                    </li>
                    <li style="display: none">
                        <a href="device/InventoryResolve.aspx">Inventory Resolve</a>
                    </li>
                    <li>
                        <a href="device/ConfirmDevice.aspx">Confirmation</a>
                    </li>
                </ul>
            </li>
            <li runat="server" id="menuListDevice">
                <a href="device/ListAllDeviceAllowBorrow.aspx">List of Devices</a>
            </li>
            <li runat="server" id="menuListDevice2">
                <a href="device/ListAllDevice.aspx">List of Devices</a>
            </li>
            <li>
                <a href="device/DeviceInTeam.aspx">Device In Team</a>
            </li>
            <li>
                <a href="#">My devices</a>
                <ul>
                    <li>
                        <a href="device/MyDevice/ListDeviceBorrowing.aspx">List Borrowing</a>
                    </li>
                    <li>
                        <a href="device/MyDevice/ListDeviceKeeping.aspx">List Keeping</a>
                    </li>
                    <li>
                        <a href="#">Transfer Device</a>
                        <ul>
                            <%--                                        <li>
                                            <a href="device/MyDevice/ConfirmKeepingDevice.aspx">Request Transfer</a>
                                        </li>
                                        <li>
                                            <a href="device/MyDevice/ConfirmKeepingDevice.aspx">Approve Transfer</a>
                                        </li>--%>
                            <li>
                                <a href="device/MyDevice/ConfirmKeepingDevice.aspx">Confirm Keeping</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li>
            <li runat="server" id="menuBorrowDevice"><a href="#">Borrow Device</a>
                <ul>
                    <li>
                        <a href="device/BorrowDevice/BorrowByModel.aspx">Borrow by Model</a>
                    </li>
                    <li>
                        <a href="device/BorrowDevice/Borrow.aspx">Borrow by Device</a>
                    </li>
                    <li>
                        <a href="device/BorrowDevice/BorrowDeviceHaveReturn.aspx">Device has returned</a>
                    </li>
                </ul>
            </li>
            <li><a href="#">Approval</a>
                <ul>
                    <li>
                        <a href="device/MyApprove/ApproveGroupByDevice.aspx">Approval Device</a>
                    </li>
                    <li>
                        <a href="device/MyApprove/ApproveGroupByModel.aspx">Approval Model</a>
                    </li>
                    <li>
                        <a href="device/Request.aspx">Request</a>
                    </li>
                </ul>
            </li>
        </ul>
    </li>
</asp:Content>
