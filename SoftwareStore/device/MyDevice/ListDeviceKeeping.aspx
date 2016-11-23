<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListDeviceKeeping.aspx.cs" Inherits="DeviceManagement.device.MyDevice.ListDeviceKeeping" %>

<link href="/css/tablecss.css" rel="stylesheet" />
<script src="/js/plugin/morris/morris.min1.js"></script>
<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script type="text/javascript">


    var currentpage = 1;
    var DeviceID = null;
    var listHasSelect = [];
    var listdevices = [];
    var numberdeviceinpage = 13;
    var listtype = JSON.parse('<%=DeviceManagement.device.DeviceManagement.ListCategoryDevice()%>');
    LoadData(1);

    function LoadListCategory() {
        var ul = $('#ulddltype').empty();
        var a = $('<a href="javascript:void(0)">').text("All");
        a.attr('dataid', 0);
        a.click(function () {
            $('#ddlType').text($(this).text());
            $('#ddlType').attr("dataid", $(this).attr("dataid"));
            LoadData(1);
        });
        ul.append($('<li>').append(a));
        for (var i = 0; i < listtype.length; i++) {
            var a = $('<a href="javascript:void(0)">').text(listtype[i].Name);
            a.attr('dataid', listtype[i].ID);
            a.click(function () {
                $('#ddlType').text($(this).text());
                $('#ddlType').attr("dataid", $(this).attr("dataid"));
                LoadData(1);
            });
            ul.append($('<li>').append(a));

        }
    }
    LoadListCategory();

    var liststatus = JSON.parse('<%=DeviceManagement.device.DeviceManagement.ListStatusDevice()%>');
    function LoadListStatus() {
        var ul = $('#ulddlstatus').empty();
        var a = $('<a href="javascript:void(0)">').text("All");
        a.attr('dataid', 0);
        a.click(function () {
            $('#ddlStatus').text($(this).text());
            $('#ddlStatus').attr("dataid", $(this).attr("dataid"));
            LoadData(1);
        });
        ul.append($('<li>').append(a));
        for (var i = 0; i < liststatus.length; i++) {
            var a = $('<a href="javascript:void(0)">').text(liststatus[i].Name);
            a.attr('dataid', liststatus[i].ID);
            a.click(function () {
                $('#ddlStatus').text($(this).text());
                $('#ddlStatus').attr("dataid", $(this).attr("dataid"));
                LoadData(1);
            });
            ul.append($('<li>').append(a));
        }
    }
    LoadListStatus();

    function Export() {
        window.open('/device/AjaxProcess/Export.aspx?type=listdevicekeeping');
    }

    function LoadTableOnStatus(filter) {
        ddlStatus.innerHTML = filter;
        LoadData(1);
    }

    function LoadHeader() {
        var table = $('#tablelistdevice > thead').empty();
        var tr = $('<tr>');
        var td = $('<th style="width: 20px; text-align: center;">').append($(' <label class="checkbox">').append($('<input type="checkbox" id="btncheck">').click(function () {
            input = $('#tablelistdevice > tbody').find('input[typecheckbox="itemdevice"][disabled!="disabled"]');
            if (this.checked) {
                for (var i = 0; i < input.length; i++) {
                    input[i].checked = true;
                    if (listHasSelect.indexOf($(input[i]).attr('dataid')) == -1)
                        listHasSelect.push($(input[i]).attr('dataid'));
                }
            }
            else {
                for (var i = 0; i < input.length; i++) {
                    input[i].checked = false;
                    var index = listHasSelect.indexOf($(input[i]).attr('dataid'));
                    if (index != -1)
                        listHasSelect.splice(index, 1);
                }
            }
            UpdateButton();
        })).append($('<i>')));

        tr.append(td);
        tr.append('<th class="theadtable" style="width: 50px;">Transfer</th>');
        tr.append('<th class="theadtable" style="width: 170px;">Transfer To</th>');
        tr.append('<th class="theadtable" style="width: 100px;">Transfer Date</th>');
        tr.append('<th class="theadtable" style="width: 100px;">Transfer Status</th>');
        tr.append('<th class="theadtable" style="width: 60px;">Type</th>');
        tr.append('<th class="theadtable" style="width: 30px;">#Tag</th>');
        tr.append('<th class="theadtable" style="width: 130px;">Model</th>');
        tr.append('<th class="theadtable" style="width: 20px;">Version</th>');
        tr.append('<th class="theadtable" style="width: 170px;">Manager</th>');
        tr.append('<th class="theadtable" style="width: 90px;">Borrowed date</th>');
        tr.append('<th class="theadtable" style="width: 90px;">Return date</th>');
        tr.append('<th class="theadtable" style="width: 170px;">Borrower</th>');
        tr.append('<th class="theadtable" style="width: 170px;">Keep Date</th>');
        tr.append('  <th class="theadtable" style="width: 50px;">Status</th>');
        tr.append(' <th class="theadtable" style="width: 150px;">IMEI</th>');
        tr.append('  <th class="theadtable" style="width: 150px;">S/N</th>');
        tr.append('<th style="text-align: center;">Note</th>');
        table.append(tr);

    }

    function UpdateButton() {
        input = $('#tablelistdevice > tbody').find('input[typecheckbox="itemdevice"][disabled!="disabled"]:checked');
        document.getElementById("btnTransfer").disabled = !(input.length > 0);
    }

    function createCheckBox(id, allowborrow, check) {
        var td = $('<td>');
        var label = $('<label class="checkbox">');
        var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemdevice">');
        if (check) {
            checkbox.attr("checked", "checked");
        }
        checkbox.attr('dataid', id);
        label.append(checkbox);
        label.append($('<i>'));
        checkbox.click(function () {
            UpdateButton();
        });
        if (!allowborrow) {
            label.addClass('state-disabled');
            checkbox.attr('disabled', 'disabled');
        }
        td.append(label);
        return td;
    }

    function LoadTable(list, index) {
        LoadHeader();
        var table = $('#tablelistdevice > tbody');
        table.empty();
        if (list.length == 0) {
            EmptyTable(table, 18);
        }

        for (i = 0; i < list.length; i++) {

            var tr = $('<tr>');


            var td = createCheckBox(list[i].IDDevice, true, false);
            tr.append(td);

            if (list[i].NewKeeper != "") {
                var btn = $("<label class='btn btn-xs btn-default' data-target='remoteModal' title='Click to cancel transfer'>").append($("<i type=button class='fa fa-times'>")).attr("dataid", list[i].IDDevice);
                btn.click(function () {
                    DeviceID = $(this).attr("dataid");
                    confirm("Confirmation!", "Do you want to cancel transfer this device?", "OK", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/device/MyDevice/TransferDevice.aspx", "CancelTransfer", { DeviceID: DeviceID }, function (response) {
                            if (response.Status) {
                                alertSmallBox("Cancel transfer device successful", "1 second ago!!", "success");
                                LoadData(currentpage);
                                listHasSelect = [];
                                $("#remoteModal").modal("hide");
                            }
                            else {
                                Common.Erroroccur();
                            }
                        });

                    });
                });
            }
            else {
                var btn = $("<label class='btn btn-xs btn-default' data-target='remoteModal' title='Click to transfer device'>").append($("<i type=button class='fa fa-paper-plane'>")).attr("dataid", list[i].IDDevice);
                btn.click(function () {
                    var target = "/device/MyDevice/TransferDevice.aspx";
                    $("#remoteModal").removeData();
                    $('#remoteModal').modal({ backdrop: 'static' });
                    $("#remoteModal").load(target, function () {
                        $("#remoteModal").modal("show");
                    });
                    DeviceID = $(this).attr("dataid");
                });
            }
            var td = $("<td style ='text-align: center'>")
            td.append(btn);
            tr.append(td);

            var td = createCellName(list[i].NewKeeper);
            tr.append(td);

            var td = createCell(list[i].TransferDate);
            tr.append(td);

            var td = createCell(list[i].NewKeeper != "" ? "Pending" : "");
            tr.append(td);


            var td = createCell(list[i].Type);
            tr.append(td);


            var td = createCell(list[i].Tag);
            tr.append(td);

            var td = createCell(list[i].Model);
            tr.append(td);

            var td = createCell(list[i].Version);
            tr.append(td);

            var td = createCellName(list[i].Manager);
            tr.append(td);

            if (list[i].Borrower != null && list[i].Borrower != "") {
                var td = createCell(list[i].BorrowDate);
                tr.append(td);

                var td = createCell(list[i].ReturnDate);
                tr.append(td);
            }
            else {
                var td = createCell("");
                tr.append(td);

                var td = createCell("");
                tr.append(td);
            }

            var td = createCellName(list[i].Borrower);
            tr.append(td);


            if (list[i].KeepDate != null && list[i].KeepDate != "") {
                var td = createCell(list[i].KeepDate);
                tr.append(td);
            }
            else {
                var td = createCell("");
                tr.append(td);
            }



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

            var td = createCell(list[i].Note);
            tr.append(td);

            table.append(tr);
        }
    }

    //// Search and load data on table
    $('#inputSearch').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            LoadData(1);
        }
    });

    function findDevice(id) {

        var i = 0;
        for (i = 0; i < listdevices.length; i++) {
            if (listdevices[i].IDDevice == id)
                return listdevices[i];
        }
        return null;
    }
    function LoadData(page) {
        currentpage = page;
        var type = $("#ddlType").attr("dataid");
        var status = $("#ddlStatus").attr("dataid");
        var keyword = $('#inputSearch').val();
        var numberinpage = numberdeviceinpage;
        AJAXFunction.CallAjax("POST", "/device/MyDevice/ListDeviceKeeping.aspx", "LoadData", {
            type: type,
            status: status,
            keyword: keyword,
            currentpage: page,
            numberinpage: numberinpage
        }, function (obj) {
            if (obj.Status) {
                var divtotalitem = $('#divtotalitem').empty();
                divtotalitem.append('Total Device: ' + obj.TotalItem)
                var _totalpage = Math.round(obj.TotalItem / numberinpage);
                var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                listdevices = obj.Data;
                listHasSelect = [];
                LoadTable(obj.Data, (numberinpage * (page - 1)));
                AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                UpdateButton();
            }
        });
    }

    function TransferMultipleDevice() {
        listHasSelect = [];
        input = $('#tablelistdevice > tbody').find('input[typecheckbox="itemdevice"][disabled!="disabled"]:checked');
        if (input.length == 0) {
            alertbox("Select device before transfer");
            return;
        }

        for (var i = 0; i < input.length; i++)
            listHasSelect.push($(input[i]).attr("dataid"));


        var target = "/device/MyDevice/TransferMultipleDevice.aspx";
        $("#remoteModal").removeData();
        $('#remoteModal').modal({ backdrop: 'static' });
        $("#remoteModal").load(target, function () {
            $("#remoteModal").modal("show");
        });

    }

    function ShowNumberDevice(numberdevice) {
        $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
        numberdeviceinpage = numberdevice;
        LoadData(1);
    }



</script>


<section id="widget-grid" class="">

    <div class="row" style="margin-bottom: 5px;">
        <div class="alert alert-info alert-block" style="margin-left: 10px;">
            <h4 class="alert-heading">List device keeping</h4>
        </div>

        <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable">
            <label class="label" style="float: left;">Type</label>
            <div class="btn-group">
                <div class="btn-group">
                    <a class="btn btn-primary" id="ddlType" style="width: 90px;" dataid="0">All</a>
                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                    <ul class="dropdown-menu" id="ulddltype">
                        <li>
                            <a href="javascript:LoadTableOnType('All');">All</a>
                        </li>
                        <li>
                            <a href="javascript:LoadTableOnType('Phone');">Phone</a>
                        </li>
                        <li>
                            <a href="javascript:LoadTableOnType('Camera');">Camera</a>
                        </li>
                        <li>
                            <a href="javascript:LoadTableOnType('Equipment');">Equipment</a>
                        </li>
                    </ul>
                </div>
                <label class="label" style="float: left;">Status</label>
                <div class="btn-group">
                    <a class="btn btn-primary" id="ddlStatus" style="width: 70px" dataid="0">All</a>
                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
                    <ul class="dropdown-menu" id="ulddlstatus">
                    </ul>
                </div>
            </div>
        </article>
        <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable">
            <div class="col-md-12" style="padding: 0px;">
                <div class="icon-addon addon-md">
                    <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                    <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                </div>
            </div>
        </article>
    </div>


    <div class="row">

        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget jarviswidget-color-teal" id="mydevice" style="margin-bottom: 0px;" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <span class="widget-icon"><i class="fa fa-table"></i></span>
                    <h2>List of devices</h2>
                    <div class="widget-toolbar" role="menu">
                        <!-- add: non-hidden - to disable auto hide -->
                        <div class="btn-group">
                            <input type="button" class="btn dropdown-toggle btn-xs btn-success btnwidth" value="Export" onclick="Export();" />
                        </div>
                        <div class="btn-group">
                            <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px;">Show: 13<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                            <ul class="dropdown-menu pull-right js-status-update">
                                <li>
                                    <a href="javascript:void(0);" onclick="ShowNumberDevice(5);">5</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ShowNumberDevice(10);">10</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ShowNumberDevice(15);">15</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ShowNumberDevice(20);">20</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ShowNumberDevice(50);">50</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ShowNumberDevice(100);">100</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </header>
                <!-- widget div-->

                <div>

                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->

                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body">

                        <div class="table-responsive smart-form">
                            <div style="min-height: 550px; overflow: auto;">
                                <div style="overflow: auto;">
                                    <table id="tablelistdevice" class="table table-striped table-bordered table-hover" style="min-width: 2300px;">
                                        <thead>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div>
                                <div id="divtotalitem" style="float: left; margin-top: 10px; font-weight: bold;">
                                </div>

                                <div id="divpaging" style="float: right; margin-top: 10px;">
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->
            </div>

        </article>

        <div class=" pull-right" style="margin-top: 10px;">
            <input type="button" id="btnTransfer" class="btn btn-primary" style="float: right; width: 95px;" value="Transfer" onclick="TransferMultipleDevice();" />
        </div>

        <!-- WIDGET END -->

    </div>



</section>

<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
<script>
    pageSetUp();
</script>
