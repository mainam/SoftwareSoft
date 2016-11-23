<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveDevice.aspx.cs" Inherits="DeviceManagement.device.MyApprove.ApproveDevice" %>


<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">

    var ApproveDevice = {
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
            }
        },
        Approve: function () {
            AJAXFunction.CallAjax("POST", "/device/MyApprove/ApproveDevice.aspx", "Approve", {
                IDApprove: ApproveDevice.approve.IDApprove,
                IDDevice: ApproveDevice.approve.IDDevice,
                NewIDDevice: $("#<%=chSelectTag.ClientID%>").val()
            }, function (response) {
                if (response.Status) {
                    alertSmallBox("Approve successful", "1 second ago!!", "success");
                    ApproveGroupByDevicePage.LoadData(ApproveGroupByDevicePage.currentpage);
                    $("#remoteModal2").modal("hide");
                }
                else {
                    alertSmallBox("Approve failed", "1 second ago!!", "error");
                }
            });
        }

    }






    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(670);
        ApproveDevice.approve = ApproveGroupByDevicePage.FindApprove(ApproveGroupByDevicePage.IDApprove);
        ApproveDevice.loadApprove(ApproveDevice.approve);
        $("#<%=chSelectTag.ClientID%>").select2();
    });


</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 700px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">APPROVE INFORMATION
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row">
                <div class="row smart-form " style="padding-bottom: 10px; padding-left: 10px; padding-right: 10px;">
                    <header style="font-weight: bold; margin-bottom: 20px; margin-top: -10px;">
                        Device Detail
                    </header>
                    <table style="margin-left: 40px; line-height: 30px;">
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
                                <label class="labelform">Tag </label>
                            </td>
                            <td>
                                <select class="select2" id="chSelectTag" runat="server" style="width: 535px;"></select>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbTag"></label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        <div class="modal-body no-padding" style="margin: 0px auto; background: white; padding: 30px; margin-top: 10px;">
            <section>
                <div class="btn btn-sm btn btn-default" style="float: right; margin: 2px; width: 95px;" data-dismiss="modal" aria-hidden="true">Close</div>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="ApproveDevice.Approve(); ">Approve</div>
                <div class="btn btn-sm btn btn-danger" style="float: right; margin: 2px; width: 95px;" onclick="ApproveDevice.SaveNote(); ">Reject</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
