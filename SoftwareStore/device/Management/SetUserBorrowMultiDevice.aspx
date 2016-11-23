<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetUserBorrowMultiDevice.aspx.cs" Inherits="SoftwareStore.device.Management.SetUserBorrowMultiDevice" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">
    pageSetUp();

    var SetUserBorrowMultipleDevice = {
        listSelected: [],
        loadDevice: function (listid) {

            $("#lbNumberDevice").text("(" + listid.length + " device" + (listid.length > 1 ? "s" : "") + ")");
            var table = $("#tablelistdevicetransfer > tbody").empty();
            for (var i = 0; i < listid.length; i++) {
                var device = SetUserBorrowMultipleDevice.findDevice(listid[i]);
                if (device != null) {
                    var tr = $("<tr>");
                    var td = createCell(i + 1);
                    tr.append(td);
                    var td = createCell(device.Type);
                    tr.append(td);

                    var td = createCell(device.Tag);
                    tr.append(td);

                    var td = createCell(device.Model);
                    tr.append(td);

                    table.append(tr);
                }
            }

            if (device != null) {
                $("#lbModel").text(device.Model);
                $("#lbType").text(device.Type);
                $("#lbTag").text(device.Tag);
                $("#lbIMEI").text(device.IMEI);
                $("#lbSerialNumber").text(device.Serial);
            }
        },
        findDevice: function (id) {

            var i = 0;
            for (i = 0; i < listdevices.length; i++) {
                if (listdevices[i].IDDevice == id)
                    return listdevices[i];

            }
            return null;
        },
        SetUserBorrow: function () {

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
            confirm("Confirmation", "Do you want to mark <b>" + username + "</b> is borrowing these devices have selected", "OK", "Cancel", function () {
                AJAXFunction.CallAjax("POST", "/device/management/SetUserBorrowMultiDevice.aspx", "Update", { ListIDDevice: SetUserBorrowMultipleDevice.listSelected, username: username, date: borrowdate }, function (response) {
                    if (response.Status) {
                        alertSmallBox("Save data success", "1 second ago...", "success");
                        $("#remoteModal").modal("hide");
                        LoadData(ListDeviceAvailable.currentpage);

                    }
                    else {
                        alertSmallBox("Save data failed", "1 second ago...", "error");
                    }
                });

            });
        }


    }


    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(670);
        SetUserBorrowMultipleDevice.listSelected = ListDeviceAvailable.GetListSelected();
        SetUserBorrowMultipleDevice.loadDevice(SetUserBorrowMultipleDevice.listSelected);
        $('.select2-chosen').text("");
        $('#txtBorrower').val("");
    });
</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">SET USER BORROW MULTIPLE DEVICE
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
                        <label id="lbNumberDevice"></label>
                    </header>
                    <div style="margin-left: 10px; margin-right: 10px; max-height: 200px; overflow: auto;">
                        <table id="tablelistdevicetransfer" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 20px;">No
                                    </th>
                                    <th style="width: 60px;">Type
                                    </th>
                                    <th style="width: 30px;">Tag
                                    </th>
                                    <th style="width: 130px;">Model
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <header style="font-weight: bold; margin-bottom: 20px;">
                        Information 
                    </header>
                </div>
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
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="SetUserBorrowMultipleDevice.SetUserBorrow(); ">Save</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
