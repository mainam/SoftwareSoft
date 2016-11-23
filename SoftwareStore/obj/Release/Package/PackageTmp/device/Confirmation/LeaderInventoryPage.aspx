<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeaderInventoryPage.aspx.cs" Inherits="DeviceManagement.device.Confirmation.LeaderInventoryPage" %>

<%@ Register Src="~/device/Controls/ctLeaderUserNotConfirm.ascx" TagPrefix="uc1" TagName="ctLeaderUserNotConfirm" %>
<%@ Register Src="~/device/Controls/ctLeaderHasRejected.ascx" TagPrefix="uc1" TagName="ctLeaderHasRejected" %>
<%@ Register Src="~/device/Controls/ctLeaderNeedAccept.ascx" TagPrefix="uc1" TagName="ctLeaderNeedAccept" %>
<%@ Register Src="~/device/Controls/ctLeaderHasAccepted.ascx" TagPrefix="uc1" TagName="ctLeaderHasAccepted" %>





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
                    Please check device in your team careful before confirm information
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
                            <ul class="nav nav-tabs tabs-left" id="demo-pill-nav" style="min-height: 800px; margin-right: 0px;">
                                <li class="active">
                                    <a href="#tabListNeedToApprove" id="tabNeedApprove" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp Need to approve</a>
                                </li>
                                <li style="width: 220px;">
                                    <a href="#tabListHasAccepted" id="tabHasAccepted" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp List has Accepted</a>
                                </li>
                                <li style="width: 220px;">
                                    <a href="#tabListHasRejected" id="tabHasRejected" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp List has Reject</a>
                                </li>
                                <li style="width: 220px;">
                                    <a href="#tabListMemberNotConfirm" id="tabMemberNotConfirm" data-toggle="tab" style="color: #555 !important"><i class="fa fa-hand-o-right"></i>&nbsp Member not confirm</a>
                                </li>
                                <li style="width: 220px;">
                                    <a href="javascript:void(0);" style="color: #555 !important" onclick="GotoRequestList()"><i class="fa fa-hand-o-right"></i>&nbsp List Request Inventory</a>
                                </li>


                            </ul>
                            <div class="tab-content" id="divtabcontent" style="margin-left: 230px;">
                                <div class="tab-pane active" id="tabListNeedToApprove" style="height: auto; float: left">
                                    <uc1:ctLeaderNeedAccept runat="server" ID="ctLeaderNeedAccept" />
                                </div>
                                <div class="tab-pane" id="tabListHasAccepted" style="float: left">
                                    <uc1:ctLeaderHasAccepted runat="server" ID="ctLeaderHasAccepted" />
                                </div>
                                <div class="tab-pane" id="tabListHasRejected" style="float: left">
                                    <uc1:ctLeaderHasRejected runat="server" ID="ctLeaderHasRejected" />
                                </div>
                                <div class="tab-pane" id="tabListMemberNotConfirm" style="float: left">
                                    <uc1:ctLeaderUserNotConfirm runat="server" ID="ctLeaderUserNotConfirm" />
                                </div>
                                <div style="clear: both"></div>
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
    var LeaderPage = {
        inventoryid: 0,
        currentpageListNeedConfirm: 1,
        currentpageListHasConfirmed: 1,
        currentpageLeaderAccepted: 1,
        currentpageLeaderRejected: 1,
        LoadData: function () {
            AJAXFunction.CallAjax("POST", "/device/confirmation/leaderinventorypage.aspx", "LoadData", {
                inventoryid: LeaderPage.inventoryid,
                keywordneedapprove: "",
                keywordhasaccepted: "",
                keywordhasrejected: "",
                keywordnotconfirm: "",
            }, function (obj) {
                if (obj.Status) {
                    LeaderNeedApprove.ShowData(obj.Data.NeedApprove);
                    MyAccept.ShowData(obj.Data.HasAccept);
                    MyReject.ShowData(obj.Data.HasReject);
                    NotConfirm.ShowData(obj.Data.NotConfirm);
                    $("#txtInventoryName").text(obj.Data.RequestName);
                    $("#txtCreateDate").text(obj.Data.Date);
                    $("#txtCreatedBy").text(obj.Data.CreatedBy);
                    $("#txtTotalDeviceBorrowing").text(obj.Data.TotalDevice);

                    $(".numberinventory").remove();
                    $("#tabNeedApprove").append(Common.CreateSpanNumber(obj.Data.NeedApprove.Data.length, "numberinventory"));
                    $("#tabHasAccepted").append(Common.CreateSpanNumber(obj.Data.HasAccept.Data.length, "numberinventory"));
                    $("#tabHasRejected").append(Common.CreateSpanNumber(obj.Data.HasReject.Data.length, "numberinventory"));
                    $("#tabMemberNotConfirm").append(Common.CreateSpanNumber(obj.Data.NotConfirm.Data.length, "numberinventory"));
                    
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
            LeaderPage.inventoryid = _inventoryid;
        else
            LeaderPage.inventoryid = inventoryid;
        LeaderPage.LoadData();
    });
    function GotoRequestList() {
        loadURL("/device/ConfirmDevice.aspx", $("#pageconfirmdevice"));
    }
    $("#demo-pill-nav > li").click(function () {
        $("#demo-pill-nav").css("min-height", $($(this).find("a").attr("href")).height());
    });
    $("#divtabcontent > div").resize(function () {
        $("#demo-pill-nav").css("min-height", $($("#demo-pill-nav > li.active").find("a").attr("href")).height());
    });
</script>

