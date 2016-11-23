<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryConfirm.aspx.cs" Inherits="DeviceManagement.device.InventoryConfirm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/tablecss.css" rel="stylesheet" />
    <script src="/js/plugin/morris/morris.min1.js"></script>
    <link href="/device/style/styleText.css" rel="stylesheet" />

    <script type="text/javascript">

        pageSetUp();

        var numberdeviceinpage = 15;

        var listdevices = [];
        var inventoryid = '<%=InventoryID()%>';
        var listtype = JSON.parse('<%=DeviceManagement.device.DeviceManagement.ListCategoryDevice()%>');
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
        function ShowNumberDevice(numberdevice) {
            $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            numberdeviceinpage = numberdevice;
            LoadData(1);
        }
     
        function LoadTableOnStatus(filter) {
            ddlStatus.innerHTML = filter;
            LoadData(1);
        }


        function LoadTable(list, index) {
            var table = $('#datatable_tabletools > tbody');
            table.empty();
            listIDCheckBox = [];
            if (list.length == 0) {
                EmptyTable(table, 15);
            }

            for (i = 0; i < list.length; i++) {

                var tr = $('<tr>');
                var td = createCell(++index);
                tr.append(td);

                var td = createCell(list[i].Model);
                tr.append(td);

                var td = createCell(list[i].Type);
                tr.append(td);

                var td = createCell(list[i].Tag);
                tr.append(td);

                var td = createCell(list[i].Serial);
                tr.append(td);

                var td = createCell(list[i].IMEI);
                tr.append(td);

                var td = createCellName(list[i].Manager);
                tr.append(td);

                var td = createCellName(list[i].Borrower);
                tr.append(td);

                var td = createCell(list[i].BorrowDate);
                tr.append(td);


                var td = createCell(list[i].Reason);
                tr.append(td);
                var td = createCell(list[i].Status);
                tr.append(td);

                table.append(tr);
            }
            //disableCheckBox(DevicePending);
            //disableCheckBox(myListDevices);
            //disableCheckBox(listFail);
        }

        $('#inputSearch').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {

                LoadData(1);
            }
        });


        function LoadData(page) {

            var _type = $("#ddlType").text();
            var _status = $("#ddlStatus").text();
            var keyword = $('#inputSearch').val();
            var numberinpage = numberdeviceinpage;
            var type = $("#ddlType").attr("dataid");
            var status = (_status == "All") ? -1 : (_status == "Not Confirm") ? 0 : (_status == "Not Borrow") ? 1 : (_status == "Loss") ? 2 : (_status == "Broken") ? 3 : 4;
            AJAXFunction.CallAjax("POST", "/device/InventoryConfirm.aspx", "LoadData", {
                inventoryid: inventoryid,
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
                    LoadTable(obj.Data, (page - 1) * numberinpage);
                    AJAXFunction.CreatePaging($("#divpaging"), parseInt(page), totalpage, LoadData);
                }
            });
        }

        function Export(type) {
            var id = GetQueryStringHash("inventoryid");
            window.open('/device/AjaxProcess/Export.aspx?type=resultinventory&inventoryid=' + id + '&typeexport=' + type);
        }


    </script>

</head>
<body>
    <section id="widget-grid" class="">

        <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
            <div class="row" style="margin-bottom: 10px; height: 50px; margin-bottom: 20px; margin-left: 0px; align-content: center">
                <h3 class="alert alert-info">Result inventory</h3>
            </div>

            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable">
                <label class="label" style="float: left;">Type:</label>
                <div class="btn-group">
                    <div class="btn-group">
                        <a class="btn btn-primary" id="ddlType" style="width: 90px" dataid="0">All</a>
                        <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>

                        <ul class="dropdown-menu" id="ulddltype">
                        </ul>
                    </div>
                    <label class="label" style="float: left;">Status:</label>
                    <div class="btn-group">
                        <a class="btn btn-primary" id="ddlStatus" style="width: 100px">All</a>
                        <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="javascript:LoadTableOnStatus('All');">All</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Not Confirm');">Not Confirm</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Not Borrow');">Not Borrow</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Loss');">Loss</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Broken');">Broken</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Good');">Good</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </article>
            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable">
                <div class="col-md-12" style="padding: 0px;">
                    <div class="icon-addon addon-md">
                        <input id="inputSearch" type="search" placeholder="input keyword" class="form-control" aria-controls="dt_basic" runat="server" />
                        <label for="email" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="email"></label>
                    </div>
                </div>
            </article>
        </div>


        <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget jarviswidget-color-teal" id="listinventoryconfirm" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>List of devices</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->
                            <div class="btn-group">
                                <input type="button" class="btn dropdown-toggle btn-xs btn-success" value="Export Inventory" data-toggle="dropdown" />
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="javascript:Export('normal');">Normal</a>
                                    </li>
                                    <li>
                                        <a href="javascript:Export('exportbymodel');">Group by Model</a>
                                    </li>
                                    <li>
                                        <a href="javascript:Export('exportbyborrower');">Group by Borrower</a>
                                    </li>
                                    <li>
                                        <a href="javascript:Export('exportbycategory');">Group by Category</a>
                                    </li>
                                    <li>
                                        <a href="javascript:Export('exportbystatusconfirm');">Group by Status Confirm</a>
                                    </li>
                                </ul>
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
                                <div style="min-height: 580px; overflow: auto;">

                                    <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1600px;">
                                        <thead>
                                            <tr>

                                                <td class="theadtable" style="width: 30px;">No
                                                </td>
                                                <td class="theadtable" style="width: 130px;">Model
                                                </td>
                                                <td class="theadtable" style="width: 80px;">Type
                                                </td>
                                                <td class="theadtable" style="width: 60px;">Tag
                                                </td>
                                                <td class="theadtable" style="width: 150px;">Serial
                                                </td>
                                                <td class="theadtable" style="width: 150px;">IMEI
                                                </td>
                                                <td class="theadtable" style="width: 180px;">Manager
                                                </td>
                                                <td class="theadtable" style="width: 180px;">Borrower
                                                </td>
                                                <td class="theadtable" style="width: 100px;">Borrow Date
                                                </td>
                                                <td class="theadtable">Note
                                                </td>
                                                <td class="theadtable" style="width: 100px;">Status
                                                </td>
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


            <!-- WIDGET END -->

        </div>



    </section>


    <div class="modal fade" id="remoteModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>

</body>
</html>
