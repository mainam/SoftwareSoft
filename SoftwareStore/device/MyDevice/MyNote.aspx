<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyNote.aspx.cs" Inherits="SoftwareStore.device.MyDevice.MyNote" %>


<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">

    var MyNote = {
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
                    }
                    else {
                        alertSmallBox("Save data failed", "1 second ago!!", "error");
                    }
                });
            });
        },

        findDevice: function (id) {

            var i = 0;
            for (i = 0; i < listdevices.length; i++) {
                if (listdevices[i].IDDevice == id)
                    return listdevices[i];

            }
            return null;
        },
        loadDevice: function (device) {
            if (device != null) {
                $("#lbModel").text(device.Model);
                $("#lbType").text(device.Type);
                $("#lbTag").text(device.Tag);
                $("#lbIMEI").text(device.IMEI);
                $("#lbSerialNumber").text(device.Serial);
                $("#NoteContent").val(device.BorrowerNote);
            }
        }
    }






    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(670);
        var device = MyNote.findDevice(DeviceID);
        MyNote.loadDevice(device);
    });


</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 700px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">MY NOTE
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
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbTag"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="labelform">Serial Number </label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbSerialNumber"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="labelform">IMEI </label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbIMEI"></label>
                            </td>
                        </tr>
                    </table>
                    <header style="font-weight: bold; margin-bottom: 20px;">
                        Note
                    </header>
                </div>
                <div style="margin-top: -15px; margin-left: 10px; margin-right: 10px;" class="smart-form">
                    <section>
                        <label class="textarea">
                            <textarea rows="250" style="height: 200px;" id="NoteContent"></textarea>
                        </label>
                    </section>
                </div>
            </div>

        </div>
        <div class="modal-body no-padding" style="margin: 0px auto; background: white; padding: 30px; margin-top: 10px;">
            <section>
                <div class="btn btn-sm btn btn-default" style="float: right; margin: 2px; width: 95px;" data-dismiss="modal" aria-hidden="true">Close</div>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="MyNote.SaveNote(); ">Save</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
