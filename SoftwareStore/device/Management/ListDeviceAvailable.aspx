﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListDeviceAvailable.aspx.cs" Inherits="DeviceManagement.device.Management.ListDeviceAvailable" %>

<link href="/css/tablecss.css" rel="stylesheet" />
<script src="/js/plugin/morris/morris.min1.js"></script>
<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />


<script type="text/javascript">
    pageSetUp();
    listdevices = [];
    var ListDeviceAvailable = {
        listtype: JSON.parse('<%=DeviceManagement.device.DeviceManagement.ListCategoryDevice()%>'),
        currentpage: 1,
        numberdeviceinpage: 10,
        LoadListCategory: function () {
            var ul = $('#ulddltype').empty();
            var a = $('<a href="javascript:void(0)">').text("All");
            a.attr('dataid', 0);
            a.click(function () {
                $('#ddlType').text($(this).text());
                $('#ddlType').attr("dataid", $(this).attr("dataid"));
                ListDeviceAvailable.LoadData(1);
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < ListDeviceAvailable.listtype.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(ListDeviceAvailable.listtype[i].Name);
                a.attr('dataid', ListDeviceAvailable.listtype[i].ID);
                a.click(function () {
                    $('#ddlType').text($(this).text());
                    $('#ddlType').attr("dataid", $(this).attr("dataid"));
                    ListDeviceAvailable.LoadData(1);
                });
                ul.append($('<li>').append(a));

            }
        },

        GetListSelected: function () {
            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]:checked');
            var listreturn = [];
            for (var i = 0; i < input.length; i++) {
                listreturn.push($(input[i]).attr("dataid"));
            }
            return listreturn;
        },
        SetBorrow: function () {

            var target = "/device/management/SetUserBorrowMultiDevice.aspx";
            $('#remoteModal').removeData();
            $('#remoteModal').modal({ backdrop: 'static' });
            $('#remoteModal').load(target, function () {
                $('#remoteModal').modal("show");

            });
            return false;
        },
        createCheckBox: function (id) {
            var td = $('<td>');
            var label = $('<label class="checkbox">');
            var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemdevice">');
            checkbox.attr('dataid', id);
            label.append(checkbox);
            label.append($('<i>'));
            checkbox.click(function () {
                ListDeviceAvailable.updateButton();
            });
            td.append(label);
            return td;
        },
        updateButton: function () {
            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]:checked');
            if (input.length > 0) {
                $("#btnSetBorrow").removeAttr("disabled");
            }
            else {
                $("#btnSetBorrow").attr("disabled", "disabled");
            }
        },
        LoadData: function (page) {
            ListDeviceAvailable.currentpage = page;

            var type = $("#ddlType").attr("dataid");
            var status = "Good";
            var keyword = $('#inputSearch').val();
            var numberinpage = ListDeviceAvailable.numberdeviceinpage;


            AJAXFunction.CallAjax("POST", "/device/management/ListDeviceAvailable.aspx", "LoadData",
                {
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
                        ListDeviceAvailable.LoadTable(obj.Data);
                        ListDeviceAvailable.updateButton();
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, ListDeviceAvailable.LoadData);
                    }
                });
        },
        ShowNumberDevice: function (numberdevice) {
            $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            ListDeviceAvailable.numberdeviceinpage = numberdevice;
            ListDeviceAvailable.LoadData(1);
        },

        LoadHeader: function () {
            var table = $('#datatable_tabletools > thead').empty();
            var tr = $('<tr>');

            tr.append($('<th class="theadtable" style="width: 20px">').append($('<label class="checkbox">').append($('<input type="checkbox" id="btncheck" />').click(function () {
                input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]');
                if (this.checked) {
                    for (var i = 0; i < input.length; i++)
                        input[i].checked = true;
                }
                else {
                    for (var i = 0; i < input.length; i++)
                        input[i].checked = false;
                }
                ListDeviceAvailable.updateButton();
            })).append($('<i>'))));
            tr.append('<th style="width: 75px;">Actions</th>');
            tr.append('<th style="width: 60px;">Type</th>');
            tr.append('<th style="width: 30px;">#Tag</th>');
            tr.append('<th style="width: 130px;">Model</th>');
            tr.append('<th style="width: 20px;">Version</th>');
            tr.append('<th style="width: 170px;">Manager</th>');
            tr.append('<th style="width: 80px;">Cabinet</th>');
            tr.append('<th style="width: 180px;">Borrower</th>');
            tr.append('<th style="width: 90px;">Borrowed date</th>');
            tr.append('<th style="width: 90px;">Return date</th>');
            tr.append('<th style="width: 70px;">Status</th>');
            tr.append('<th style="width: 120px;">IMEI</th>');
            tr.append('<th style="width: 120px;">S/N</th>');
            tr.append('<th style="text-align: center;">Note</th>');
            table.append(tr);

        },


        LoadTable: function (list) {
            ListDeviceAvailable.LoadHeader();
            var table = $('#datatable_tabletools > tbody');
            table.empty();
            if (list.length == 0) {
                EmptyTable(table, 15);
            }

            for (i = 0; i < list.length; i++) {

                var tr = $('<tr>');

                var td = $("<td>").append(ListDeviceAvailable.createCheckBox(list[i].IDDevice));
                tr.append(td);

                var td = ListDeviceAvailable.createAction(list[i]);
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
                var td = createCell(list[i].CabinetName);
                tr.append(td);

                var td = createCellName(list[i].Borrower);
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
        },

        createAction: function (device) {

            var action = $('<a href="/device/EditDevice.aspx" data-toggle="modal" data-target="#remoteModal">');
            action.attr('dataid', device.IDDevice);
            action.click(function () {
                var target = $(this).attr("href");
                IDDeviceEdit = $(this).attr('dataid');
                $($(this).attr("data-target")).removeData();
                // load the url and show modal on success
                IDDeviceEdit = $(this).attr('dataid');
                $('#remoteModal').modal({ backdrop: 'static' });
                $($(this).attr("data-target")).load(target, function () {
                    $($(this).attr("data-target")).modal("show");
                });
            });

            var btnedit = $('<label class="btn btn-xs btn-default">');
            btnedit.append($('<i class="fa fa-edit"/>'))
            action.append(btnedit);


            var action1 = $('<a href="/device/Management/SetUserBorrowDevice.aspx" data-toggle="modal" data-target="#remoteModal">');
            action1.attr('dataid', device.IDDevice);
            action1.click(function () {
                var target = $(this).attr("href");
                IDDeviceEdit = $(this).attr('dataid');
                $($(this).attr("data-target")).removeData();
                // load the url and show modal on success
                $('#remoteModal').modal({ backdrop: 'static' });
                IDDeviceEdit = $(this).attr('dataid');
                $($(this).attr("data-target")).load(target, function () {
                    $($(this).attr("data-target")).modal("show");
                });
            });


            var btnset = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
            btnset.append($('<i class="fa  fa-gears "/>'))
            action1.append(btnset);


            var td = $('<td style="text-align: center">');
            td.append(action);
            if (device.Borrower == "")
                td.append(action1);
            return td;
        },
        LoadTableOnType: function (filter) {
            ddlType.innerHTML = filter;
            ListDeviceAvailable.LoadData(1);
        }
    }

    var IDDeviceEdit;


    ListDeviceAvailable.LoadData(ListDeviceAvailable.currentpage);
    currentpage = 1;
    function LoadData(page) {
        ListDeviceAvailable.LoadData(ListDeviceAvailable.currentpage);
    }

    function findDevice(id) {
        var i = 0;
        for (i = 0; i < listdevices.length; i++) {
            if (listdevices[i].IDDevice == id) {
                return listdevices[i];
            }
        }
    }


    ListDeviceAvailable.LoadListCategory();

    //// Search and load data on table
    $('#inputSearch').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            ListDeviceAvailable.LoadData(1);
        }
    });

</script>

<section id="widget-grid" class="">
    <!-- end row -->

    <div class="row" style="margin-bottom: 5px;">
        <div class="alert alert-info alert-block" style="margin-left: 10px;">
            <h4 class="alert-heading">Device Management!</h4>
            Welcome to the site management devices. Here, you can manage your devices, add new device and edit or delete the existing devices.
        </div>

        <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
            <label class="label" style="float: left;">Type</label>
            <div class="btn-group">
                <div class="btn-group">
                    <a class="btn btn-primary" id="ddlType" style="width: 90px" dataid="0">All</a>
                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>

                    <ul class="dropdown-menu" id="ulddltype">
                    </ul>
                </div>

            </div>
        </article>
        <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
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
            <div class="jarviswidget jarviswidget-color-teal" id="listdevicemanagement" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-original-title="" data-widget-fullscreenbutton="false">
                <header>
                    <span class="widget-icon"><i class="fa fa-table"></i></span>
                    <h2>List of devices</h2>
                    <div class="widget-toolbar" role="menu">
                        <div class="btn-group">
                            <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px; margin-left: 5px;">Show: 10<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                            <ul class="dropdown-menu pull-right js-status-update">
                                <li>
                                    <a href="javascript:void(0);" onclick="ListDeviceAvailable.ShowNumberDevice(5);">5</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ListDeviceAvailable.ShowNumberDevice(10);">10</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ListDeviceAvailable.ShowNumberDevice(15);">15</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ListDeviceAvailable.ShowNumberDevice(20);">20</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ListDeviceAvailable.ShowNumberDevice(50);">50</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ListDeviceAvailable.ShowNumberDevice(100);">100</a>
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
                            <div style="min-height: 230px; overflow: auto">
                                <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 2200px;">
                                    <thead>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
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
            <input type="button" id="btnSetBorrow" class="btn btn-primary" disabled="disabled" style="float: right; width: 95px;" value="Set Borrow" onclick="ListDeviceAvailable.SetBorrow();" />
        </div>


        <!-- WIDGET END -->

    </div>



</section>


<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
