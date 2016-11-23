
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BorrowByModel.aspx.cs" Inherits="SoftwareStore.device.BorrowDevice.BorrowByModel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/tablecss.css" rel="stylesheet" />
    <script src="/js/plugin/morris/morris.min1.js"></script>
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <style>
        #dialog-message {
            margin-bottom: -30px;
        }

        .ui-dialog-buttonset {
            margin-right: 32px !important;
        }
    </style>
    <script type="text/javascript">

        pageSetUp();
        var currentpage = 1;
        var numbermodelinpage = 14;
        $('#txtStartDate').datepicker({
            dateFormat: 'mm/dd/yy',
            prevText: '<i class="fa fa-chevron-left"></i>',
            nextText: '<i class="fa fa-chevron-right"></i>',
            onSelect: function (selectedDate) {

                $('#txtEndDate').datepicker('option', 'minDate', selectedDate);
            }
        });

        $('#txtEndDate').datepicker({
            dateFormat: 'mm/dd/yy',
            prevText: '<i class="fa fa-chevron-left"></i>',
            nextText: '<i class="fa fa-chevron-right"></i>',
            onSelect: function (selectedDate) {

                $('#txtStartDate').datepicker('option', 'maxDate', selectedDate);
            }
        });

        var listModel = [];
        var Model = null;
        var ModelID = null;
        function FindModel(modelid) {
            for (var i = 0; i < listModel.length; i++) {
                if (listModel[i].ID == modelid) {
                    return listModel[i];
                }
            }
            return null;
        }

        var listtype = JSON.parse('<%=SoftwareStore.device.DeviceManagement.ListCategoryDevice()%>');
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
        LoadData(1);
        var IDDeviceEdit;

        function LoadTableOnStatus(filter) {
            ddlStatus.innerHTML = filter;
            LoadData(1);
        }

        $("#dialog-message").dialog({
            autoOpen: false,
            resizable: false,
            width: 600,
            modal: true,
            title: "Borrow Device",
            buttons: [
                {
                    html: "OK",
                    width: 80,
                    "class": "btn btn-primary",
                    click: function () {
                        Borrow();
                    }
                },
                {
                    html: "CANCEL",
                    width: 80,
                    "class": "btn btn-default",
                    click: function () {
                        $(this).dialog("close");
                    }
                }]

        });


        function LoadTable(list) {
            var table = $('#datatable_tabletools > tbody');
            table.empty();

            if (list.length == 0) {
                EmptyTable(table, 15);
            }

            for (i = 0; i < list.length; i++) {
                var tr = $('<tr>');
                var td = createCell(list[i].ModelName);
                tr.append(td);
                var td = createCell(list[i].Type);
                tr.append(td);
                var td = createCell(list[i].Company);
                tr.append(td);
                var td = createCellName(list[i].Manager);
                tr.append(td);
                var td = createCell("Available: <b>" + list[i].Available + "</b>");
                if (list[i].Available == 0) {
                    td.css("color", "red");
                }
                tr.append(td);
                var td = createCell("Borrowed: <b>" + list[i].Borrowed + "</b>");
                tr.append(td);
                var td = createCell("Pending: <b>" + list[i].PendingApproval + "</b>");
                tr.append(td);
                var td = $("<td style='vertical-align: middle;'>");
                var btnborrow = $("<label class='btn btn-xs btn-success' style='padding: 0 10px; width:100%;'>").attr("dataid", list[i].ID).text("Borrow");
                td.append(btnborrow);

                if (list[i].Available == 0) {
                    btnborrow.addClass("btn-info");
                    btnborrow.attr("disabled", "disabled");
                    btnborrow.css("color", "black");
                }
                else {
                    btnborrow.click(function () {
                        ModelID = $(this).attr("dataid");
                        Model = FindModel(ModelID);
                        $('#txtNumberDevice').val(1).attr('max', Model.Available);
                        if (Model != null) {
                            $('#lbModel').text(Model.ModelName);
                            $('#lbType').text(Model.Type);
                            $('#lbCompany').text(Model.Company);
                            $('#lbAvailable').text(Model.Available + " Device(s)");
                            $('#dialog-message').dialog('open');
                        }
                    });
                }
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


        function LoadData(page) {
            currentpage = page;
           
            var type = $("#ddlType").attr("dataid");
            var status = $("#ddlStatus").text();
            var keyword = $('#inputSearch').val();
            var numberinpage = numbermodelinpage;
            AJAXFunction.CallAjax("POST", "device/BorrowDevice/BorrowByModel.aspx", "GetListModelAvailable", {
                type: type,
                status: status,
                keyword: keyword,
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitem').empty();
                    divtotalitem.append('Total Model: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    listModel = obj.Data;
                    LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                }
            });
        }
        function ShowNumberModel(numberdevice) {
            $("#btnSelectNumberModel").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            numbermodelinpage = numberdevice;
            LoadData(1);
        }


        function Borrow() {
            if (Model == null) {
                alertbox("Please select model");
                return;
            }
            var starttime = $("#txtStartDate").val();
            var endtime = $("#txtEndDate").val();
            var reason = $("#txtReason").val();
            var numberDevice = $("#txtNumberDevice").val();
            if (!Common.IsNumeric(numberDevice) || numberDevice > Model.Available || numberDevice <= 0) {
                alertbox("You have to type a number less than <b>" + Model.Available + "</b> and greater than <b>0</b>");
                return;
            }
            if (!Common.IsValidDate(endtime) || !Common.IsValidDate(starttime)) {
                alertbox("Date time input invalid, please input again!!");
                return;
            }
            if (new Date(endtime) < new Date(starttime)) {
                alertbox("Start time must be prior to end time");
                return;
            }
            AJAXFunction.CallAjax("POST", "/device/BorrowDevice/BorrowByModel.aspx", "Borrow", { Manager: Model.Manager, ModelID: Model.ID, NumberDevice: numberDevice, StartDate: starttime, EndDate: endtime, Reason: reason }, function (response) {
                if (response.Status) {
                    alertSmallBox("Create request for " + numberDevice + " device", "1 second ago!!", "success");
                    LoadData(currentpage);
                    ModelID = null;
                    Model = null;
                    $('#dialog-message').dialog('close');
                }
                else {
                    Common.Erroroccur();
                }
            });
        }

    </script>

</head>
<body>
    <section id="widget-grid" class="">

        <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
            <div class="alert alert-info alert-block">
                <h4 class="alert-heading">Borrow Device</h4>
            </div>
            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable" style="padding: 0px;">


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
                <div class="jarviswidget jarviswidget-color-teal" id="listmodelDevice" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>List Model</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->
                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberModel" style="width: 100px;">Show: 14<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                                <ul class="dropdown-menu pull-right js-status-update">
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberModel(5);">5</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberModel(10);">10</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberModel(15);">15</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberModel(20);">20</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberModel(50);">50</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberModel(100);">100</a>
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
                                <div style="min-height: 590px; overflow: auto">
                                    <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1300px;">
                                        <thead>
                                            <tr>
                                                <th rowspan="2" style="width: 150px;">Model
                                                </th>
                                                <th rowspan="2" style="width: 150px;">Type
                                                </th>
                                                <th rowspan="2" style="width: 150px;">Company
                                                </th>
                                                <th rowspan="2">Manager
                                                </th>
                                                <th colspan="3">Summary
                                                </th>
                                                <th rowspan="2" style="width: 100px;">Borrow
                                                </th>
                                            </tr>
                                            <tr>
                                                <th style="width: 120px;">Available
                                                </th>
                                                <th style="width: 120px;">Borrowed
                                                </th>
                                                <th style="width: 120px;">Pending Approval
                                                </th>
                                            </tr>
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

        </div>


        <div id="dialog-message" title="Dialog Simple Title">
            <p style="width: 500px;">

                <div class="row smart-form ">
                    <header style="font-weight: bold; margin-bottom: 20px; margin-top: -10px;">
                        Detail Model
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
                                <label class="labelform">Company </label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbCompany"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="labelform">Available </label>
                            </td>
                            <td>
                                <label class="labelform" style="text-transform: uppercase; font-size: 16px; color: #ff6a00; margin-left: 10px;" id="lbAvailable"></label>
                            </td>
                        </tr>
                    </table>
                    <header style="font-weight: bold; margin-bottom: 20px;">
                        Borrowing Information 
                    </header>
                    <table style="margin-left: 40px; line-height: 40px; width: 480px;">
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Number Device</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-tag"></i>
                                    <input type="number" min="0" id="txtNumberDevice" value="1" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">From</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-calendar"></i>
                                    <input type="text" id="txtStartDate" runat="server" placeholder=" From" class="form-control" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">To</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-calendar"></i>
                                    <input type="text" id="txtEndDate" runat="server" placeholder="To" class="form-control" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Reason</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-edit"></i>
                                    <textarea rows="4" runat="server" class="form-control datepicker" id="txtReason" style="resize: none; margin-top: 3px;" />
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
            </p>

        </div>

    </section>


    <div class="modal fade" id="remoteModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>

</body>
</html>
