<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddDeviceManager.aspx.cs" Inherits="SoftwareStore.Admin.Device.Dialog.AddDeviceManager" %>


<style>
    .tdheader {
        background: #BBDEFB;
    }
</style>

<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 900px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divAddNewDeviceManager">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">ADD NEW DEVICE MANAGER
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>

    <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 40px;">
        <select runat="server" multiple id="cbListMember" class="select2">
        </select>
        <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-top: 10px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
        <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; margin-top: 10px; width: 90px;" onclick="AddNewDeviceManager(); ">SAVE</div>
    </div>
</div>
<style>
    .select2 {
        width: 100%;
    }
</style>
<script>
    $(document).ready(function () {
        $("#divAddNewDeviceManager").delay(500).fadeIn(500).verticalAlign(400);
    });

    $("#<%=cbListMember.ClientID%>").select2();

    var AddNewDeviceManager = function () {
        if ($("#<%=cbListMember.ClientID%>").val() == null) {
            alertSmallBox("Please select one or more member", "", "error");
            return;
        }
        AJAXFunction.CallAjax("POST", "/admin/device/dialog/adddevicemanager.aspx", "AddNewDeviceManager", { listuser: $("#<%=cbListMember.ClientID%>").val() }, function (response) {
            if (response.Status) {
                alertSmallBox("Add new device manager sucessful", "", "success");
                $('#remoteModal2').modal("hide");
                ConfigDeviceManager.LoadData(1);
            }
            else {
                alertSmallBox("Add new device manager failed", "", "error");
            }
        });
    }
</script>
