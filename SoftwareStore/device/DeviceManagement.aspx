<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SoftwareStore.aspx.cs" Inherits="SoftwareStore.device.DeviceManagement" %>

<link href="/css/tablecss.css" rel="stylesheet" />
<script src="/js/plugin/morris/morris.min1.js"></script>
<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />


<script type="text/javascript">
    pageSetUp();
    var currentpage = 1;
    var numberdeviceinpage = 5;
    var IDDeviceEdit;
    var listHasSelect = [];
    var listdevices = [];
    var statisticdevice;

    LoadData(currentpage);

    function ShowNumberDevice(numberdevice) {
        $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
        numberdeviceinpage = numberdevice;
        LoadData(1);
    }


    function findDevice(id) {
        var i = 0;
        for (i = 0; i < listdevices.length; i++) {
            if (listdevices[i].IDDevice == id) {
                return listdevices[i];
            }
        }
    }

    function GetFullName(info) {
        var arr = info.split("/");
        if (arr.length > 1)
            return arr[1];
        return "";
    }

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
        window.open('/device/AjaxProcess/Export.aspx?type=SoftwareStore.');

    }

    // Load morris dependency 2
    function loadMorris() {
        loadScript("js/plugin/morris/morris.min1.js", ShowGraph());
    }

    function ShowGraph() {
        //  Devices
        if ($('#bar-graph-device').length) {

            var datastatistic = [];
            var numA = 0, numB = 0, numL = 0, numF = 0;

            for (var j = 0; j < statisticdevice.length; j++) {

                var temp = { x: statisticdevice[j].typename };
                for (var i = 0; i < statisticdevice[j].statisticstatus.length; i++) {
                    temp['h' + (i + 1)] = statisticdevice[j].statisticstatus[i].CountDevices;
                    switch (i) {
                        case 0: numA += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                        case 1: numB += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                        case 2: numL += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                        case 3: numF += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                    }
                }
                datastatistic.push(temp);
            }

            Morris.Bar({
                element: 'bar-graph-device',
                data: datastatistic,
                xkey: 'x',
                ykeys: ['h1', 'h2', 'h3', 'h4'],
                labels: ['Available', 'Borrow', 'Loss', 'Broken']
            });

            var tablestatus = $('#statusdevice > tbody').empty();
            var tr = $('<tr>').append($('<td>').text('Available')).append($('<td>').text(numA));
            tablestatus.append(tr);
            tr = $('<tr>').append($('<td>').text('Borrow')).append($('<td>').text(numB));
            tablestatus.append(tr);
            tr = $('<tr>').append($('<td>').text('Loss')).append($('<td>').text(numL));
            tablestatus.append(tr);
            tr = $('<tr>').append($('<td>').text('Broken')).append($('<td>').text(numF));
            tablestatus.append(tr);
        }
    }


    function LoadTableOnType(filter) {
        ddlType.innerHTML = filter;
        LoadData(1);
    }

    function LoadTableOnStatus(filter) {
        ddlStatus.innerHTML = filter;
        LoadData(1);
    }


    function LoadHeader() {
        var table = $('#datatable_tabletools > thead').empty();
        var tr = $('<tr>');
        tr.append('<th style="width: 20px;">No</th>');
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
    }


    function LoadTable(list, index) {
        LoadHeader();
        var table = $('#datatable_tabletools > tbody');
        table.empty();
        if (list.length == 0) {
            EmptyTable(table, 15);
        }

        for (i = 0; i < list.length; i++) {

            var tr = $('<tr>');

            var td = createCell(++index);
            tr.append(td);

            var td = createAction(list[i]);
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
    }

    function btnAddDevice() {
        IDDeviceEdit = null;
        var target = "/device/EditDevice.aspx"
        $('#remoteModal').removeData();
        $('#remoteModal').modal({ backdrop: 'static' });
        $('#remoteModal').load(target, function () {
            $('#remoteModal').modal("show");
        });
    }


    function createAction(device) {

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

        var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
        btndel.attr('dataid', device.IDDevice);
        btndel.append($('<i class="fa fa-times"/>'))

        btndel.click(function () {
            var IDDeviceDelete = $(this).attr('dataid');
            var callback = function () {
                AJAXFunction.CallAjax("POST", "/device/DeviceManagement.aspx", "deleteDevice", {
                    id: IDDeviceDelete
                },
                function (response) {
                    var status = response.Status;
                    if (status) {
                        alertSmallBox("Delete seccessful!", "1 second ago!!", "Success");
                        LoadData(currentpage);
                    }
                    else
                        alertSmallBox("Delete failed", "1 second ago!!", "Error");
                });
            }
            confirm("Confirm", "Do you want to delete device!!", "OK", "Cancel", callback);
        });

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


        var td = $('<td>');
        td.append(action);
        td.append(btndel);
        if (device.Borrower == "")
            td.append(action1);
        return td;
    }



    //// Search and load data on table
    $('#inputSearch').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            LoadData(1);
        }
    });

    function LoadStatistic() {
        $.ajax({
            type: "POST",
            url: "/device/DeviceManagement.aspx/LoadStatistic",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var obj = JSON.parse(response.d);
                if (obj.Status) {
                    statisticdevice = obj.Data;
                    loadScript("js/plugin/morris/raphael.2.1.0.min1.js", loadMorris);
                }
            }
        });
    }


    function LoadData(page) {
        currentpage = page;

        var type = $("#ddlType").attr("dataid");
        var status = $("#ddlStatus").attr("dataid");
        var keyword = $('#inputSearch').val();
        var numberinpage = numberdeviceinpage;
        AJAXFunction.CallAjax("POST", "/device/DeviceManagement.aspx", "LoadData", {
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
                LoadTable(obj.Data, (numberinpage * (page - 1)));
                AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
            }
        });
    }

    LoadStatistic();

    // Load morris dependency 2
    function loadMorris() {
        loadScript("js/plugin/morris/morris.min1.js", ShowGraph());
    }

    function ShowGraph() {
        //  Devices
        if ($('#bar-graph-device').length) {

            var datastatistic = [];
            var numA = 0, numB = 0, numL = 0, numF = 0;
            for (var j = 0; j < statisticdevice.length; j++) {

                var temp = { x: statisticdevice[j].typename };
                for (var i = 0; i < statisticdevice[j].statisticstatus.length; i++) {
                    temp['h' + (i + 1)] = statisticdevice[j].statisticstatus[i].CountDevices;
                    switch (i) {
                        case 0: numA += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                        case 1: numB += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                        case 2: numL += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                        case 3: numF += statisticdevice[j].statisticstatus[i].CountDevices;
                            break;
                    }
                }
                datastatistic.push(temp);
            }

            Morris.Bar({
                element: 'bar-graph-device',
                data: datastatistic,
                xkey: 'x',
                ykeys: ['h1', 'h2', 'h3', 'h4'],
                labels: ['Available', 'Borrow', 'Loss', 'Broken']
            });

            var tablestatus = $('#statusdevice > tbody').empty();
            var tr = $('<tr>').append($('<td>').text('Available')).append($('<td>').text(numA));
            tablestatus.append(tr);
            tr = $('<tr>').append($('<td>').text('Borrow')).append($('<td>').text(numB));
            tablestatus.append(tr);
            tr = $('<tr>').append($('<td>').text('Loss')).append($('<td>').text(numL));
            tablestatus.append(tr);
            tr = $('<tr>').append($('<td>').text('Broken')).append($('<td>').text(numF));
            tablestatus.append(tr);
        }
    }

    //function LoadStatistic() {
    //    AJAXFunction.CallAjax("POST", "/device/DeviceManagement.aspx", "LoadStatistic", function (obj) {
    //        if (obj.Status) {
    //            statisticdevice = obj.Data;
    //            loadScript("js/plugin/morris/raphael.2.1.0.min1.js", loadMorris);
    //        }
    //    });
    //}
</script>

<section id="widget-grid" class="">
    <!-- end row -->

    <div class="row" style="margin-bottom: 5px;">
        <div class="alert alert-info alert-block" style="margin-left: 10px;">
            <h4 class="alert-heading">Device Management!</h4>
            Welcome to the site management devices. Here, you can manage your devices, add new device and edit or delete the existing devices.
        </div>

        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-9 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-teal" id="idstatisticmanagement" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-original-title="">
                <header>
                    <span class="widget-icon"><i class="fa fa-bar-chart-o"></i></span>

                    <h2>Statistic</h2>

                </header>
                <!-- widget div-->
                <div>

                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                    </div>

                    <div class="widget-body no-padding">
                        <div style="right: 40px; position: absolute; background-color: rgb(239, 239, 239); z-index: 100;">
                            <table>

                                <tbody>
                                    <tr>
                                        <td class="legendColorBox">
                                            <div style="#000">
                                                <div style="border: 2px solid rgb(113, 132, 63); overflow: hidden"></div>
                                            </div>
                                        </td>
                                        <td class="legendLabel"><span>Available</span></td>
                                    </tr>
                                    <tr>
                                        <td class="legendColorBox">
                                            <div style="#000">
                                                <div style="border: 2px solid rgb(87, 136, 156); overflow: hidden"></div>
                                            </div>
                                        </td>
                                        <td class="legendLabel"><span>Borrow</span></td>
                                    </tr>
                                    <tr>
                                        <td class="legendColorBox">
                                            <div style="#000">
                                                <div style="border: 2px solid rgb(246, 153, 136); overflow: hidden"></div>
                                            </div>
                                        </td>
                                        <td class="legendLabel"><span>Loss</span></td>
                                    </tr>
                                    <tr>
                                        <td class="legendColorBox">
                                            <div style="#000">
                                                <div style="border: 2px solid rgb(146, 162, 168); overflow: hidden"></div>
                                            </div>
                                        </td>
                                        <td class="legendLabel"><span>Broken</span></td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>

                        <div id="bar-graph-device" class="chart no-padding" style="height: 250px;"></div>
                    </div>
                </div>

            </div>
        </article>


        <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
            <label class="label" style="float: left;">Type</label>
            <div class="btn-group">
                <div class="btn-group">
                    <a class="btn btn-primary" id="ddlType" style="width: 90px" dataid="0">All</a>
                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>

                    <ul class="dropdown-menu" id="ulddltype">
                    </ul>
                </div>
                <label class="label" style="float: left;">Status</label>
                <div class="btn-group">
                    <a class="btn btn-primary" id="ddlStatus" style="width: 70px"  dataid="0">All</a>
                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
                    <ul class="dropdown-menu"  id="ulddlstatus">
                       <%-- <li>
                            <a href="javascript:LoadTableOnStatus('All');">All</a>
                        </li>
                        <li>
                            <a href="javascript:LoadTableOnStatus('Good');">Good</a>
                        </li>
                        <li>
                            <a href="javascript:LoadTableOnStatus('Broken');">Broken</a>
                        </li>
                        <li>
                            <a href="javascript:LoadTableOnStatus('Loss');">Loss</a>
                        </li>--%>
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
                        <!-- add: non-hidden - to disable auto hide -->
                        <div class="btn-group">
                            <input type="button" class="btn dropdown-toggle btn-xs btn-success btnwidth" value="Export" style="margin-right: 10px;" onclick="Export();" />
                            <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="btnAddDevice();">Add Device</a>
                        </div>
                        <div class="btn-group">
                            <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px; margin-left: 5px;">Show: 5<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
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
                            <div style="min-height: 230px; overflow: auto">
                                <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1750px;">
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


        <!-- WIDGET END -->

    </div>



</section>


<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>

