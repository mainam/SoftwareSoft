<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetUserBorrowDevice.aspx.cs" Inherits="SoftwareStore.device.Management.SetUserBorrowDevice" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">
    pageSetUp();


    function findDevice(id) {

        var i = 0;
        for (i = 0; i < listdevices.length; i++) {
            if (listdevices[i].IDDevice == id)
                return listdevices[i];

        }
        return null;
    }

    function updateDevice() {

        var username = $('#txtBorrower').val();
        var borrowdate = $('#txtBorrowDate').val();
        if (username == "" || username == null) {
            alertbox("Please select user borrow");
            return;
        }
        if (borrowdate == "") {
            alertbox("Please select date");
            return;
        }
        AJAXFunction.CallAjax("POST", "/device/Management/SetUserBorrowDevice.aspx", "Update", { IDDevice: IDDeviceEdit, username: username, date: borrowdate }, function (response) {
            if (response.Status) {
                alertSmallBox("Save data success", "1 second ago...", "success");
                $("#remoteModal").modal("hide");
                LoadData(currentpage);
            }
            else {
                alertSmallBox("Save data failed", "1 second ago...", "error");
            }
        });
    }

    function loadDevice(device) {

        $("#txtType").val(device.Type);

        $("#txtStatus").val(device.Status);

        $("#txtVersion").val(device.Version);

        $("#txtModel").val(device.Model);

        $("#txtTag").val(device.Tag);

        $("#txtNote").val(device.Note);

        $("#txtIMEI").val(device.IMEI);

        $("#txtSerial").val(device.Serial);
    }


    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(670);
        var device = findDevice(IDDeviceEdit);
        loadDevice(device);
        $('.select2-chosen').text("")
        $('#txtBorrower').val("")
    });
</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">SET USER BORROW DEVICE
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Category</label>
                    <label class="input">
                        <input type="text" id="txtType" runat="server" style="font-size: 15px;" disabled="disabled" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label  labelform">Model</label>
                    <label class="input">
                        <input type="text" id="txtModel" runat="server" style="font-size: 15px;" disabled="disabled" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Status</label>
                    <label class="input">
                        <input type="text" id="txtStatus" runat="server" style="font-size: 15px;" disabled="disabled" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Tag</label>
                    <label class="input">
                        <input type="text" id="txtTag" runat="server" style="font-size: 15px;" disabled="disabled" />
                    </label>
                </section>
            </div>

            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Version</label>
                    <label class="input">
                        <input type="text" id="txtVersion" runat="server" style="font-size: 15px;" disabled="disabled" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Note</label>
                    <label class="input">
                        <input type="text" id="txtNote" value="Normal" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">IMEI</label>
                    <label class="input">
                        <input type="text" id="txtIMEI" value="N/A" disabled="disabled" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Serial</label>
                    <label class="input">
                        <input type="text" id="txtSerial" value="N/A" disabled="disabled" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Borrower</label>
                    <label class="input">
                        <select id="txtBorrower" runat="server" class="select2">
                        </select>
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Borrow Date</label>
                    <label class="input">
                        <input type="text" name="request" id="txtBorrowDate" runat="server" class="datepicker" data-dateformat='mm/dd/yy' value="01/01/2014" />
                    </label>
                </section>
            </div>

        </div>
        <div class="modal-body no-padding" style="margin: 20px auto; background: white; padding: 30px; margin-top: 10px;">
            <section>
                <div class="btn btn-sm btn btn-default" style="float: right; margin: 2px; width: 95px;" data-dismiss="modal" aria-hidden="true">Cancel</div>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="updateDevice(); ">Save</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
