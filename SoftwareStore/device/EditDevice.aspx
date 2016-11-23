<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditDevice.aspx.cs" Inherits="SoftwareStore.device.EditDevice" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>

<link href="/device/style/styleText.css" rel="stylesheet" />
<script type="text/javascript">
    pageSetUp();

    var users = JSON.parse('<%=GetAllUsers()%>');

    var device = findDevice(IDDeviceEdit);
    $("#formEditDevice").delay(500).fadeIn(500).verticalAlign(750);
    loadComboBox();

    function SaveMultipleDevice() {
        if ($('#txtModel2').val() == "") {
            alert("Please select model");
            return;
        }

        if ($('#txtStatus2').val() == "") {
            alert("Please select status");
            return;
        }

        if ($('#txtManager2').val() == "") {
            alert("Please input manager id");
            return;
        }

        if ($('#txtReceiver').val() == "") {
            alert("Please input receiver id");
            return;
        }

        if ($('#txtNumberDevice').val() == "") {
            alert("Please input number device");
            return;
        }

        if ($('#txtNumberDevice').val() <= 0) {
            alert("Please input number device to greater than 1");
            return;
        }

        $.ajax({
            type: "POST",
            url: "device/EditDevice.aspx/AddMultipleDevice",
            data: JSON.stringify({
                model: $('#txtModel2').val(),
                status: $('#txtStatus2').val(),
                manager: $('#txtManager2').val(),
                receiver: $('#txtReceiver2').val(),
                receiverdate: $('#txtReceiveDate2').val(),
                numberdevice: $('#txtNumberDevice').val(),
                from: $('#txtFrom2').val(),
                region: $('#txtRegion2').val()
            }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                var status = JSON.parse(JSON.parse(response.d).Status);
                if (status) {
                    alertSmallBox("Add device success!!", "2 second ago", "success");
                    $("#remoteModal").modal("hide");
                    LoadData(1);
                }
                else {
                    alertbox("Add device error!!");
                }
            },
            failure: function (response) {
            }
        });
    }

    function updateDevice() {
        if (isAddOneDevice) {
            if ($('#txtCabinet').val() == "") {
                alert("Please select cabinet");
                return;
            }
            if ($('#txtModel').val() == "") {
                alert("Please select model");
                return;
            }

            var temp = {
                "IDDevice": device != null ? device.IDDevice : 0,
                "Model": document.getElementById("txtModel").value,
                "CabinetID": document.getElementById("txtCabinet").value,
                "Tag": document.getElementById("txtTag").value,
                "Type": 0,
                "Project": document.getElementById("txtProject").value,
                "Manager": document.getElementById("txtManager").value,
                "Borrower": null,
                "Keeper": null,
                "BorrowDate": null,
                "ReturnDate": null,
                "Status": document.getElementById("txtStatus").value,
                "IMEI": document.getElementById("txtIMEI").value,
                "Serial": document.getElementById("txtSerial").value,
                "Region": document.getElementById("txtRegion").value,
                "Version": document.getElementById("txtVersion").value,
                "Receiver": document.getElementById("txtReceiver").value,
                "From": document.getElementById("txtFrom").value,
                "ReceiveDate": document.getElementById("txtReceiveDate").value,
                "Note": document.getElementById("txtNote").value,
                "AllowBorrow": true
            };
            $.ajax({
                type: "POST",
                url: "device/EditDevice.aspx/editDevice",
                data: JSON.stringify({
                    deviceInfo: temp
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var status = JSON.parse(JSON.parse(response.d).status);
                    if (status) {
                        if (device == null) {
                            alertSmallBox("Add device success!!", "2 second ago", "success");
                            $("#remoteModal").modal("hide");
                            LoadData(1);
                        } else {
                            alertSmallBox("Edit device success!!", "2 second ago", "success");
                            $("#remoteModal").modal("hide");
                            LoadData(currentpage);
                        }
                    }
                    else {
                        if (device == null)
                            alertbox("Add device error!!");
                        else
                            alertbox("Edit device error!!");
                    }
                },
                failure: function (response) {
                }
            });
        }
        else {
            SaveMultipleDevice();
        }
    }

    function loadDevice(device) {
        $("#<%=txtModel.ClientID%>").select2("val", device.Model.trim());

        $("#<%=txtCabinet.ClientID%>").select2("val", device.CabinetID);

        $("#<%=txtStatus.ClientID%>").select2("val", device.Status);

        $("#txtVersion").val(device.Version);

        $("#txtRegion").val(device.Region);

        $("#<%=txtManager.ClientID%>").select2("val", device.Manager.substring(0, device.Manager.indexOf('/')));


        $("#txtReceiver").select2("val", device.Receiver.substring(0, device.Receiver.indexOf('/')));

        $("#txtIMEI").val(device.IMEI);

        $("#txtReceiveDate").val(device.ReceiveDate);

        $("#txtTag").val(device.Tag);

        $("#txtProject").val(device.Project);

        $("#txtNote").val(device.Note);

        $("#txtSerial").val(device.Serial);

        $("#txtFrom").val(device.From);

    }
    function loadComboBox() {
        var i;
        for (i = 0; i <= users.length - 1; i++) {
            var com = "<option value=" + "'" + users[i].substring(0, users[i].indexOf('/')) + "'>" + users[i] + "</option>";
            $('#txtReceiver').append(com);
            $('#txtReceiver2').append(com);
        }
    }

    var isAddOneDevice = true;
    function AddMultipeDevice(u) {

        isAddOneDevice = !isAddOneDevice;
        if (isAddOneDevice) {
            $("#addonedevice").show();
            $("#addmultipledevice").hide();
            $(u).text("Add multiple device")
        }
        else {
            $("#addmultipledevice").show();
            $("#addonedevice").hide();
            $(u).text("Add one device")
        }
    }


    $(document).ready(function () {
        if (device != null) {
            loadDevice(device);
            $('#spanTitle').text("EDIT DEVICE");
            $("#btnAddMultipleDevice").hide();
        }
        else {
            $('#spanTitle').text("ADD DEVICE");
        }
    });
</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="formEditDevice">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">EDIT DEVICE
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;" id="addonedevice">
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Model</label>
                    <label class="input">
                        <select id="txtModel" runat="server" style="font-size: 15px; width: 100px" class="select2 select2-offscreen" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Cabinet</label>
                    <label class="input">
                        <select id="txtCabinet" runat="server" style="font-size: 15px; width: 100px" class="select2 select2-offscreen">
                        </select>
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Status</label>
                    <label class="input">
                        <select id="txtStatus" style="font-size: 15px; width: 100px" class="select2 select2-offscreen" runat="server">
                        </select>
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Tag</label>
                    <label class="input">
                        <input type="text" id="txtTag" value="#" />
                    </label>
                </section>
            </div>

            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Version</label>
                    <label class="input">
                        <input type="text" id="txtVersion" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Project Name</label>
                    <label class="input">
                        <input type="text" id="txtProject" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Manager</label>
                    <label class="input">
                        <input type="text" id="txtManager" value="" runat="server" runat="server" />
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
                        <input type="text" id="txtIMEI" value="N/A" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Serial</label>
                    <label class="input">
                        <input type="text" id="txtSerial" value="N/A" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Region</label>
                    <label class="input">
                        <select id="txtRegion" class="select2">
                            <option value="SEA">SEA</option>
                            <option value="Common">Common</option>
                            <option value="Korea">Korea</option>
                            <option value="USA">USA</option>
                            <option value="EUR">EUR</option>
                        </select>

                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">From</label>
                    <label class="input">
                        <input type="text" id="txtFrom" value="N/A" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Receive date</label>
                    <label class="input">
                        <input type="text" name="request" id="txtReceiveDate" runat="server" class="datepicker" data-dateformat='mm/dd/yy' value="01/01/2014" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Receiver</label>
                    <label class="input">
                        <select id="txtReceiver" class="select2">
                        </select>
                    </label>
                </section>
            </div>

        </div>

        <div style="margin-top: 30px; display: none;" id="addmultipledevice">
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Model</label>
                    <label class="input">
                        <select id="txtModel2" runat="server" style="font-size: 15px; width: 100px" class="select2 select2-offscreen" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Status</label>
                    <label class="input">
                        <select id="txtStatus2" style="font-size: 15px; width: 100px" class="select2 select2-offscreen" runat="server">
                        </select>
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Manager</label>
                    <label class="input">
                        <input type="text" id="txtManager2" value="" runat="server" runat="server" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Region</label>
                    <label class="input">
                        <select id="txtRegion2" class="select2">
                            <option value="SEA">SEA</option>
                            <option value="Common">Common</option>
                            <option value="Korea">Korea</option>
                            <option value="USA">USA</option>
                            <option value="EUR">EUR</option>
                        </select>

                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">From</label>
                    <label class="input">
                        <input type="text" id="txtFrom2" value="N/A" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Receive date</label>
                    <label class="input">
                        <input type="text" name="request" id="txtReceiveDate2" runat="server" class="datepicker" data-dateformat='mm/dd/yy' value="01/01/2014" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-6">
                    <label class="label labelform">Receiver</label>
                    <label class="input">
                        <select id="txtReceiver2" class="select2">
                        </select>
                    </label>
                </section>
                <section class="col col-6">
                    <label class="label labelform">Number of Device</label>
                    <label class="input">
                        <input id="txtNumberDevice" type="number" min="1" max="100" value="1">
                    </label>
                </section>
            </div>

        </div>

        <div class="modal-body no-padding" style="margin: 20px auto; background: white; padding: 30px; margin-top: 10px;">
            <section>
                <div class="btn btn-sm btn btn-success pull-left" style="float: right; margin: 2px;" onclick="AddMultipeDevice(this); " id="btnAddMultipleDevice">Add multiple device</div>
                <div class="btn btn-sm btn btn-default " style="float: right; margin: 2px; width: 95px;" data-dismiss="modal" aria-hidden="true">Cancel</div>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="updateDevice(); ">Save</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
