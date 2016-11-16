<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DialogConfirmDevices.aspx.cs" Inherits="DeviceManagement.device.Confirmation.DialogConfirmDevices" %>


<style>
    .show {
        visibility: visible;
    }

    .hide {
        visibility: hidden;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />
<script type="text/javascript">

    var ListDeviceConfirm;

    function LoadDataConfirm() {
        AJAXFunction.CallAjax("POST", "/device/Confirmation/DialogConfirmDevices.aspx", "LoadListDevice", {
            id: MyRequest.currentMyRequest
        }, function (obj) {

            $('#remoteModal').modal({ backdrop: 'static' });
            var info = $('#divInfo');
            if (obj.Status) {
                ListDeviceConfirm = obj.Data;
                LoadTableConfimList(ListDeviceConfirm);
                pageSetUp();
                info.append("You have borrowed <b>" + ListDeviceConfirm.length + "</b> device(s). Please confirm to us that you are holding it. (Inventory Date: <b>" + obj.Date + "</b> - Request by: <b>" + obj.RequestBy + "</b>)")
                var btnconfirm = $('#btnConfirm').empty();
                if (!obj.HasConfirm) {
                    var btn = $('<input type="button" class="btn btn-primary" style="width: 82px; height: 32px;" value="OK">');
                    btnconfirm.append(btn);
                    btn.click(function () {
                        for (var i = 0; i < ListDeviceConfirm.length; i++) {
                            var reason = $('textarea[dataid=' + ListDeviceConfirm[i].id + ']').val();
                            var confirmstatus = $('select[dataid=' + ListDeviceConfirm[i].id + ']').val();
                            if (confirmstatus == 0) {
                                alertbox("Please confirm all devices");
                                return;
                            }
                            else {
                                if (confirmstatus != 4) {
                                    alertbox("If you confirm status not good, please enter reason!");
                                    return;
                                }
                                ListDeviceConfirm[i].Reason = reason;
                                ListDeviceConfirm[i].ConfirmStaus = confirmstatus;
                            }
                        }

                        var save = function () {
                            $.ajax({
                                type: "POST",
                                url: "device/Confirmation/DialogConfirmDevices.aspx/SaveConfirm",
                                data: JSON.stringify({
                                    ListSave: ListDeviceConfirm,
                                }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    var obj = JSON.parse(response.d);
                                    if (obj.Status) {
                                        $("#remoteModal").modal("hide");
                                        alertSmallBox("Confirm successful!", "1 second ago!!", "Success");
                                        MyRequest.LoadData(MyRequest.currentpage);
                                    }
                                    else {
                                        alertSmallBox("Can't confirm in this time, please contact administrator", "1 second ago!!", "Error");
                                    }
                                },
                                failure: function (response) {
                                }
                            });
                        };
                        var r = confirm("Confirm", "Are you sure the data you enter is correct. Data will not be able to edit if you click OK!", "OK", "Cancel", save);
                    });
                }


            }
            else {
                LoadTableConfimList([]);
                info.append("You do not keep any device, press (X) to exit the window.")
            }

        });

    }

    function createCellReason(id, numrow, placeholder, value, statusconfirm) {
        var label = $('<label class="textarea">');
        var textarea = $('<textarea  name="info">');
        textarea.attr('dataid', id);
        textarea.attr('rows', numrow);
        textarea.attr('placeholder', placeholder);
        textarea.attr('texttype', "reasonconfirm");
        textarea.val(value);
        var td = $('<td>');
        if (statusconfirm != 0) {
            textarea.attr("disabled", "disabled");
        }
        label.append(textarea);
        td.append(label);
        return td;
    }

    function createCellConfirm(id, currentstatus) {
        var select = $('<select class="select2">');
        select.attr('dataid', id);
        if (currentstatus == 0) {
            select.append('<option value="0">Not Confirm</option>')
            select.append('<option value="1">Not Borrow</option>')
            select.append('<option value="2">Loss</option>')
            select.append('<option value="3">Broken</option>')
            select.append('<option value="4">Good</option>')
            select.val(4);
        }
        else {
            select.addClass("disabled");
            switch (currentstatus) {
                case 1:
                    select.append('<option value="1">Not Borrow</option>');
                    break;
                case 2:
                    select.append('<option value="2">Loss</option>');
                    break;
                case 3:
                    select.append('<option value="3">Broken</option>');
                    break;
                case 4:
                    select.append('<option value="4">Good</option>')

            }

        }
        if (currentstatus != 0) {
            select.val(currentstatus);
            select.attr("disabled", "disabled");
        }
        else
            select.val(4);

        var td = $('<td>');
        td.append(select);
        return td;
    }
    function getStatusConfirm(currentstatus) {
        switch (currentstatus) {
            case 0:
                return "Not Confirm";
            case 1:
                return "Not Borrow";
            case 2:
                return "Loss";
            case 3:
                return "Broken";
            case 4:
                return "Good";
            default:
                return "Not Confirm";
        }
    }

    function LoadTableConfimList(list) {
        var table = $('#tablelistconfirm > tbody');
        table.empty();
        var j = 1;
        if (list.length == 0) {
            $('#SearchResult').removeClass('show');
            $('#SearchResult').addClass('hide');
            $('#EmptyResult').removeClass('hide');
            $('#EmptyResult').addClass('show');
        }
        else {
            $('#SearchResult').removeClass('hide');
            $('#SearchResult').addClass('show');
            $('#EmptyResult').removeClass('show');
            $('#EmptyResult').addClass('hide');
            for (i = 0; i < list.length; i++) {

                var tr = $('<tr>');

                //var td = createCheckBox(list[i].IDDevice);
                //tr.append(td);

                var td = createCell(j++);
                tr.append(td);

                var td = createCell(list[i].DeviceName);
                tr.append(td);

                var td = createCell(list[i].Type);
                tr.append(td);

                var td = createCell(list[i].Tag);
                tr.append(td);

                var td = createCellName(list[i].Borrower);
                tr.append(td);

                var td = createCellName(list[i].Keeper);
                tr.append(td);

                var td = createCell(list[i].BorrowDate);
                tr.append(td);

                var td = createCell(list[i].IMEI);
                tr.append(td);

                var td = createCell(list[i].Serial);
                tr.append(td);
                if (list[i].ConfirmStaus == 0) {
                    var td = createCellReason(list[i].id, 2, "Add reason if device is loss, broken or not borrow", list[i].Reason, list[i].ConfirmStaus)
                    tr.append(td);
                    var td = createCellConfirm(list[i].id, list[i].ConfirmStaus)
                    tr.append(td);
                }
                else {
                    var td = createCell(list[i].Reason);
                    tr.append(td);
                    var td = createCell(getStatusConfirm(list[i].ConfirmStaus));
                    tr.append(td);
                }




                table.append(tr);

            }
        }
    }



    $(document).ready(function () {
        LoadDataConfirm();

        //Loadtablelistconfirm(temp);

        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(750);

    });



</script>
<body>

    <div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
        <div class="smart-form">
            <div class="modal-header" style="height: 30px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding: 10px;">
                <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">CONFIRMATION BORROWING DEVICE
                </span>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
                    ×
                </button>
            </div>


            <div class="row" style="margin-top: 40px">
                <%--                <div id="dt_basic_filter" class="dataTables_filter" style="width: 250px;">
                    <label>
                        <span class="input-group-addon" style="width: 11px; height: 16px;"><i class="glyphicon glyphicon-search"></i></span>
                        <input id="inputSearchExtra" type="search" class="form-control" aria-controls="dt_basic" style="padding-left: 4px"></label>
                </div>--%>


                <div class="alert alert-block alert-success">
                    <h4 class="alert-heading">Information!</h4>
                    <p style="margin-top: 10px;" id="divInfo">
                    </p>
                </div>
                <div>
                    <div id="SearchResult" class="smart-form">
                        <div style="height: 500px; overflow: hidden; overflow-y: auto">
                            <table id="tablelistconfirm" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th class="theadtable" style="width: 30px;">ID</th>
                                        <th class="theadtable" style="width: 60px;">Model</th>
                                        <th class="theadtable" style="width: 80px;">Type</th>
                                        <th class="theadtable" style="width: 50px;">#Tag</th>
                                        <th class="theadtable" style="width: 150px;">Borrower</th>
                                        <th class="theadtable" style="width: 150px;">Keeper</th>
                                        <th class="theadtable" style="width: 100px;">BorrowDate</th>
                                        <th class="theadtable">IMEI</th>
                                        <th class="theadtable">S/N</th>
                                        <th class="theadtable" style="width: 200px;">Note</th>
                                        <th class="theadtable" style="width: 150px;">Confirm</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id="btnConfirm" style="float: right; margin-top: 10px;">
                        </div>
                    </div>
                    <div class="alert alert-info fade in" id="EmptyResult">
                        <i class="fa-fw fa fa-info"></i>
                        <strong>Result!</strong> Your search returned no matches
                    </div>
                </div>

                <!-- WIDGET END -->

            </div>


        </div>
    </div>
</body>
