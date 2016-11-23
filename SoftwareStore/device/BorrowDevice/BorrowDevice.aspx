<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BorrowDevice.aspx.cs" Inherits="DeviceManagement.device.BorrowDevice.BorrowDevice" %>

<link href="/device/style/styleText.css" rel="stylesheet" />
<style>
    .show {
        visibility: visible;
    }

    .hide {
        visibility: hidden;
    }
</style>
<script type="text/javascript">
    $("#inputSearchExtra").val(document.getElementById("inputSearch").value);
    var temp = '<%=GetAllDevices()%>';
    var devices = JSON.parse(temp);
    var temp = search(devices, $("#inputSearchExtra").val())
    function LoadTableSearch(list) {
        var table = $('#tablesearch > tbody');
        table.empty();
        var j = 1;
        if (list.length == 0) {
            EmptyTable(table, 13);
        }
        else {

            for (i = 0; i < list.length; i++) {
                if (list[i].AllowBorrow) {

                    var tr = $('<tr>');

                    var td = createCheckBox(list[i].IDDevice);
                    tr.append(td);

                    var td = createCell(j++);
                    tr.append(td);

                    var td = createCell(list[i].Type);
                    tr.append(td);

                    var td = createCell(list[i].Tag);
                    tr.append(td);

                    var td = createCell(list[i].Model);
                    tr.append(td);

                    var td = createCell(list[i].Project);
                    tr.append(td);

                    var td = createCell(list[i].Version);
                    tr.append(td);

                    var td = createCellName(list[i].Manager);
                    tr.append(td);

                    var td = createCellName(list[i].Borrower);
                    tr.append(td);

                    //var td = createCellName(list[i].Keeper);
                    //tr.append(td);

                    var td = $("<td style='vertical-align: middle;'>");//createCell(list[i].Status);
                    switch (list[i].Status) {
                        case "Good":
                            td.append(Common.CreateLabelStylePrimary(list[i].Status));
                            break;
                        case "Broken":
                            td.append(Common.CreateLabelStyleWarning(list[i].Status));
                            break;
                        case "Loss":
                            td.append(Common.CreateLabelStyleDanger(list[i].Status));
                            break;
                    }
                    tr.append(td);

                    var td = createCell(list[i].IMEI);
                    tr.append(td);

                    var td = createCell(list[i].Serial);
                    tr.append(td);

                    //var td = createCell(list[i].Region);
                    //tr.append(td);

                    //var td = createCell(list[i].ReceiveDate);
                    //tr.append(td);

                    //var td = createCellName(list[i].Receiver);
                    //tr.append(td);

                    //var td = createCell(list[i].From);
                    //tr.append(td);

                    var td = createCell(list[i].Note);
                    tr.append(td);
                    table.append(tr);
                }
            }
        }
    }

    function search(list, key) {

        key = key.toLowerCase();
        var temp = list, i = 0;
        temp = [];
        for (i = 0; i < list.length; i++) {
            if (list[i].Note == null) list[i].Note = "";
            if (
                    list[i].Model.toLowerCase().indexOf(key) > -1 ||
                    list[i].Type.toLowerCase().indexOf(key) > -1 ||
                    list[i].Tag.toLowerCase().indexOf(key) > -1 ||
                    list[i].Project.toLowerCase().indexOf(key) > -1 ||
                    list[i].Manager.toLowerCase().indexOf(key) > -1 ||
                    list[i].Borrower.toLowerCase().indexOf(key) > -1 ||
                    list[i].Keeper.toLowerCase().indexOf(key) > -1 ||
                    list[i].BorrowDate.indexOf(key) > -1 ||
                    list[i].ReturnDate.indexOf(key) > -1 ||
                    list[i].Status.toLowerCase().indexOf(key) > -1 ||
                    list[i].IMEI.toLowerCase().indexOf(key) > -1 ||
                    list[i].Serial.toLowerCase().indexOf(key) > -1 ||
                    list[i].Region.toLowerCase().indexOf(key) > -1 ||
                    list[i].Version.toLowerCase().indexOf(key) > -1 ||
                    list[i].Receiver.toLowerCase().indexOf(key) > -1 ||
                    list[i].From.toLowerCase().indexOf(key) > -1 ||
                    list[i].ReceiveDate.indexOf(key) > -1 ||
                    list[i].Note.toLowerCase().indexOf(key) > -1) {
                if (!temp.contains(list[i]))
                    temp.push(list[i]);
            }
        }
        return temp;
    }


    $('#btnchecksearch').click(function (event) {  //on click 
        input = $('#tablesearch > tbody').find('input[typecheckbox="itemdevice"]');
        if (this.checked) {
            for (var i = 0; i < input.length; i++) {
                input[i].checked = true;
            }
        }
        else {
            for (var i = 0; i < input.length; i++) {
                input[i].checked = false;
            }

        }
    });
    // Search and load data on table
    $('#inputSearchExtra').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            var input = document.getElementById("inputSearchExtra").value.toLowerCase();
            var temp = search(devices, input);
            LoadTableSearch(temp);
        }
    });

    function btnOK() {
        var arr = [];
        input = $('#tablesearch > tbody').find('input[typecheckbox="itemdevice"]');
        for (var i = 0; i < input.length; i++) {
            if (input[i].checked)
                arr.push($(input[i]).attr('dataid'));
        }

        AJAXFunction.CallAjax("POST", "/device/BorrowDevice/BorrowDevice.aspx", "PostId",
            {
                arrid: arr,
            },
            function (response) {
                $("#remoteModal").modal("hide");
                LoadListBorrow();
            }
            );
    }

    $(document).ready(function () {
        LoadTableSearch(temp);
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(570);

    });
</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1300px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <div class="smart-form">
        <div class="modal-header" style="height: 30px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">BORROW DEVICES
            </span>

            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
                ×
            </button>
        </div>


        <div class="row" style="margin-top: 27px">
            <div id="dt_basic_filter" class="dataTables_filter" style="width: 250px;">
                <label>
                    <span class="input-group-addon" style="width: 11px; height: 16px;"><i class="glyphicon glyphicon-search"></i></span>
                    <input id="inputSearchExtra" type="search" class="form-control" aria-controls="dt_basic" style="padding-left: 4px"></label>
            </div>


            <div style="margin-top: 40px; height: 450px; overflow: auto">
                <div id="SearchResult">
                    <table id="tablesearch" class="table table-striped table-bordered table-hover" style="min-width: 1600px">
                        <thead>
                            <tr>
                                <th class="theadtable" style="width: 20px;">
                                    <label class="checkbox">
                                        <input type="checkbox" id="btnchecksearch" /><i></i></label>
                                </th>
                                <th class="theadtable" style="width: 30px;">No</th>
                                <th class="theadtable" style="width: 60px;">Type</th>
                                <th class="theadtable" style="width: 30px;">#Tag</th>
                                <th class="theadtable" style="width: 130px;">Model</th>
                                <th class="theadtable" style="width: 80px;">Project</th>
                                <th class="theadtable" style="width: 20px;">Version</th>
                                <th class="theadtable" style="width: 170px;">Manager</th>
                                <th class="theadtable" style="width: 180px;">Borrower</th>
                                <th class="theadtable" style="width: 50px;">Status</th>
                                <th class="theadtable" style="width: 120px;">IMEI</th>
                                <th class="theadtable" style="width: 120px;">S/N</th>
                                <th class="theadtable" style="width: 120px;">Note</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>

                    </table>
                </div>

            </div>
            <div class="pull-right">
                <input type="button" class="btn btn-primary" style="margin-left: 20px; margin-top: 10px; width: 82px; height: 32px; float: left" value="OK" onclick="btnOK();">
            </div>
            <!-- WIDGET END -->

        </div>


    </div>
</div>
