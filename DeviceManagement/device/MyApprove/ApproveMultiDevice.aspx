<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveMultiDevice.aspx.cs" Inherits="DeviceManagement.device.MyApprove.ApproveMultiDevice" %>


<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">

    var ApproveMultiDevice = {
        approve: null,
        SaveNote: function () {
            if (DeviceID == null) {
                alertbox("Please select device want to note");
                return;
            }
            confirm("Confirmation", "Do you want to save this data", "OK", "Cancel", function () {
                AJAXFunction.CallAjax("POST", "/device/MyDevice/MyNote.aspx", "SaveNote", { DeviceID: DeviceID, NoteContent: $("#NoteContent").val() }, function (response) {
                    if (response.Status) {
                        alertSmallBox("Save data successful", "1 second ago!!", "success");
                        LoadData(currentpage);
                        DeviceID = null;
                        $("#remoteModal").modal("hide");
                        LoadData(currentpage);
                    }
                    else {
                        alertSmallBox("Save data failed", "1 second ago!!", "error");
                    }
                });
            });
        },

        loadApprove: function (device) {
            if (device != null) {
                $("#lbModel").text(device.Model);
                $("#lbType").text(device.Type);
                $("#lbTag").text(device.Tag);
                $("#lbBorrower").append(Common.ShowSingleStatus(device.UserName, device.FullName));
                $("#lbQuantity").append(device.Count);

            }
        },
        Approve: function () {
            if ($("#chSelectTag").val() == null) {
                alertSmallBox("Please select device want to approval", "1 second ago!!", "error");
                return;
            }
            AJAXFunction.CallAjax("POST", "/device/MyApprove/ApproveMultiDevice.aspx", "Approve", {
                username: ApproveMultiDevice.approve.UserName,
                model: ApproveMultiDevice.approve.Model,
                countdevice: ApproveMultiDevice.approve.Count,
                listselected: $("#chSelectTag").val()
            }, function (response) {
                if (response.Status) {
                    alertSmallBox("Approve successful", "1 second ago!!", "success");
                    ApproveGroupByModelPage.LoadData(ApproveGroupByModelPage.currentpage);
                    $("#remoteModal2").modal("hide");
                }
                else {
                    alertSmallBox("Approve failed", "1 second ago!!", "error");
                }
            });
        }

    }

    $("#chSelectTag").change(function () {
        if ($("#chSelectTag").val() == null)
            $("#numberselected").text("(0)");
        else
            $("#numberselected").text("(" + $("#chSelectTag").val().length + ")");
    });

    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(500);
        ApproveMultiDevice.approve = ApproveGroupByModelPage.FindApprove(ApproveGroupByModelPage.IDApprove);
        ApproveMultiDevice.loadApprove(ApproveMultiDevice.approve);
        $("#<%=chSelectTag.ClientID%>").select2();
        $("#<%=chSelectTag.ClientID%>").select2({
            maximumSelectionSize: ApproveMultiDevice.approve.Count
        });
    });


</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 700px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">APPROVE DEVICE
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row">
                <div class="row smart-form " style="padding-bottom: 10px; padding-left: 10px; padding-right: 10px;">
                    <table style="margin-left: 40px; line-height: 30px;">
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Borrower</label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbBorrower"></label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Model</label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbModel"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="labelform">Type</label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbType"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="labelform">Quantity</label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbQuantity"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="labelform">Selected </label>
                                <div id="numberselected">(0) </div>
                            </td>
                            <td>
                                <div style="max-height: 200px; overflow: auto; overflow-x: hidden;">

                                    <select class="select2" multiple="true" id="chSelectTag" runat="server" style="width: 535px;"></select>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        <div class="modal-body no-padding" style="margin: 0px auto; background: white; padding: 30px; margin-top: 10px;">
            <section>
                <div class="btn btn-sm btn btn-default" style="float: right; margin: 2px; width: 95px;" data-dismiss="modal" aria-hidden="true">Close</div>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="ApproveMultiDevice.Approve(); ">Approve</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
