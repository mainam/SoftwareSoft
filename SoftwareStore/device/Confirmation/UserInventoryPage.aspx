<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInventoryPage.aspx.cs" Inherits="DeviceManagement.device.Confirmation.UserInventoryPage" %>

<%@ Register Src="~/device/Controls/ctUserNeedConfirm.ascx" TagPrefix="uc1" TagName="ctUserNeedConfirm" %>
<%@ Register Src="~/device/Controls/ctUserHasConfirm.ascx" TagPrefix="uc1" TagName="ctUserHasConfirm" %>
<%@ Register Src="~/device/Controls/ctUserLeaderAccept.ascx" TagPrefix="uc1" TagName="ctUserLeaderAccept" %>
<%@ Register Src="~/device/Controls/ctUserLeaderReject.ascx" TagPrefix="uc1" TagName="ctUserLeaderReject" %>

<link href="/css/common.css" rel="stylesheet" />
<link href="/device/style/styleText.css" rel="stylesheet" />
<style>
    .tabs-left > .tab-content {
        margin-left: 210px;
    }

    .smart-form header {
        font-weight: bold;
        margin-top: 0px;
    }

    .trError td {
        background: #FF8A80 !important;
        color: white;
    }

    .jarviswidget {
        display: block !important;
    }

    .popover-title, .popover-content {
        padding: 10px;
    }
</style>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="row" style="margin-bottom: 5px;">


        <div class="col-sm-12 col-md-12 col-lg-12">

            <div class="well">
                <div class="alert alert-info alert-block" style="margin: 0px; font-size: 14px; line-height: 30px;">
                    <h4 class="alert-heading">Request inventory!</h4>

                </div>
                <table style="margin: 10px 50px; font-size: 14px; line-height: 30px; width: 100%; text-transform: uppercase; color: #000;">
                    <tr>
                        <td style="width: 200px;">
                            <label class="labelform">Request Name</label>
                        </td>
                        <td>:
                            <label id="txtInventoryName" style="font-size: 15px; font-weight: bold; color: #ff6a00;">?</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="labelform">Create Date</label>
                        </td>
                        <td>:
                            <label id="txtCreateDate" style="font-size: 15px; font-weight: bold; color: #ff6a00;">?</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="labelform">Created By</label>
                        </td>
                        <td>:                           
                            <label id="txtCreatedBy" style="width: 98%; font-size: 15px; font-weight: bold; color: #ff6a00;">?</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="labelform">Device Borrowing</label>
                        </td>
                        <td>:                           
                            <label id="txtTotalDeviceBorrowing" style="width: 98%; font-size: 15px; font-weight: bold; color: #ff6a00;">?</label>
                        </td>
                    </tr>
                </table>

                <div class="alert alert-block alert-warning" style="margin: 0px; font-size: 14px; line-height: 30px; margin-top: 20px;">
                    <h4 class="alert-heading">Warning!</h4>
                    Inventory is importance procedure of our Company. Checking your devices careful and confirm your device information. These information will be sent to your leader to confirm before sent to device manager.
                </div>
            </div>

        </div>

        <article class="col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget  jarviswidget-color-teal" id="confirmation" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <h2>Request inventory </h2>
                </header>

                <!-- widget div-->
                <div>
                    <div class="widget-body">
                        <div class="tabs-left">
                            <ul class="nav nav-tabs tabs-left" id="demo-pill-nav" style="min-height: 600px; margin-right: 0px;">
                                <li class="active">
                                    <a href="#tabListNeedConfirm" id="tabNeedConfirm" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp Need Confirm</a>
                                </li>
                                <li style="width: 200px;">
                                    <a href="#tabListHasConfirm" id="tabHasConfirm" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp List has Confirmed</a>
                                </li>
                                <li style="width: 200px;">
                                    <a href="#tabListLeaderAccept" id="tabLeaderAccept" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp Leader Accepted</a>
                                </li>
                                <li style="width: 200px;">
                                    <a href="#tabListLeaderReject" id="tabLeaderReject" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp Leader Rejected</a>
                                </li>
                                <li style="width: 200px;">
                                    <a href="javascript:void(0);" style="color: #555 !important" onclick="GotoRequestList()"><i class="fa fa-hand-o-right"></i>&nbsp List Request Inventory</a>
                                </li>
                            </ul>
                            <div class="tab-content" id="divtabcontent">
                                <div class="tab-pane active" id="tabListNeedConfirm" style="float: left">
                                    <uc1:ctUserNeedConfirm runat="server" ID="ctUserNeedConfirm" />
                                </div>
                                <div class="tab-pane" id="tabListHasConfirm" style="float: left">
                                    <uc1:ctUserHasConfirm runat="server" ID="ctUserHasConfirm" />
                                </div>
                                <div class="tab-pane" id="tabListLeaderAccept" style="float: left">
                                    <uc1:ctUserLeaderAccept runat="server" ID="ctUserLeaderAccept" />
                                </div>
                                <div class="tab-pane" id="tabListLeaderReject" style="float: left">
                                    <uc1:ctUserLeaderReject runat="server" ID="ctUserLeaderReject" />
                                </div>
                                <div style="clear: both">
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->

            </div>
            <!-- end widget -->

        </article>

    </div>

</section>
<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
<script type="text/javascript">
    var UserPage = {
        inventoryid: 0,
        currentpageListNeedConfirm: 1,
        currentpageListHasConfirmed: 1,
        currentpageLeaderAccepted: 1,
        currentpageLeaderRejected: 1,
        LoadData: function () {
            AJAXFunction.CallAjax("POST", "/device/confirmation/userinventorypage.aspx", "LoadData", {
                inventoryid: UserPage.inventoryid,
                keywordneedconfirm: "",
                keywordhasconfirmed: "",
                keywordlistaccept: "",
                keywordlistreject: "",
            }, function (obj) {
                if (obj.Status) {
                    UserNeedConfirm.ShowData(obj.Data.NeedConfirm);
                    ListHasConfirmed.ShowData(obj.Data.HasConfirmed);
                    LeaderReject.ShowData(obj.Data.Rejected);
                    LeaderAccept.ShowData(obj.Data.Accepted);
                    $(".numberinventory").remove();
                    $("#tabNeedConfirm").append(Common.CreateSpanNumber(obj.Data.NeedConfirm.Data.length, "numberinventory"));
                    $("#tabHasConfirm").append(Common.CreateSpanNumber(obj.Data.HasConfirmed.Data.length, "numberinventory"));
                    $("#tabLeaderAccept").append(Common.CreateSpanNumber(obj.Data.Accepted.Data.length, "numberinventory"));
                    $("#tabLeaderReject").append(Common.CreateSpanNumber(obj.Data.Rejected.Data.length, "numberinventory"));

                    $("#txtInventoryName").text(obj.Data.RequestName);
                    $("#txtCreateDate").text(obj.Data.Date);
                    $("#txtCreatedBy").text(obj.Data.CreatedBy);
                    $("#txtTotalDeviceBorrowing").text(obj.Data.TotalDevice);
                   
                }
                else {

                }
                pageSetUp();

            });
        }
    }

    $(document).ready(function () {
        var _inventoryid = GetQueryStringHash("inventoryid");
        if (_inventoryid != null)
            UserPage.inventoryid = _inventoryid;
        else
            UserPage.inventoryid = inventoryid;
        UserPage.LoadData();
    });
    function GotoRequestList() {
        loadURL("/device/ConfirmDevice.aspx", $("#pageconfirmdevice"));
        return false;
    }
    $("#demo-pill-nav > li").click(function () {
        $("#demo-pill-nav").css("min-height", $($(this).find("a").attr("href")).height());
    });
    $("#divtabcontent > div").resize(function () {
        $("#demo-pill-nav").css("min-height", $($("#demo-pill-nav > li.active").find("a").attr("href")).height());
    });


    pageSetUp();
</script>
