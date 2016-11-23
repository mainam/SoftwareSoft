<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryResolve.aspx.cs" Inherits="DeviceManagement.device.InventoryResolve" %>

<link href="/css/tablecss.css" rel="stylesheet" />
<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var currentpage = 1;
        Array.prototype.contains = function (k) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] === k) {
                    return true;
                }
            }
            return false;
        }
        pageSetUp();
        var idinventoryselect;
        function LoadTable(list) {

            var table = $('#datatable_tabletools > tbody');
            table.empty();
            if (list.length == 0) {
                EmptyTable(table, 7);
            }

            for (i = 0; i < list.length; i++) {
                var tr = $('<tr>');

                var td = createCell(i + 1);
                tr.append(td);

                var td = createCell(list[i].Name);
                tr.append(td);

                var td = createCellName(list[i].RequestBy);
                tr.append(td);

                var td = createCell(list[i].RequestDate);
                tr.append(td);

                var td = createCell(list[i].TotalDevice);
                tr.append(td);

                var td = createCell(list[i].Status ? "Confirmed" : "Not Confirm");
                tr.append(td);

                var td = createCellAction(list[i].ID, list[i].Status ? "View Confirm" : "Confirm", list[i].Status);
                tr.append(td);

                table.append(tr);

            }
        }
        function createCellAction(idinventory, text, hasconfirm) {
            var td = $('<td style="vertical-align: middle;">');
            var a = $('<a class="btn btn-xs" href="/device/DialogConfirmDevices.aspx" data-toggle="modal" data-target="#remoteModal" style="width:100%">').text(text);
            a.attr('dataid', idinventory);
            if (hasconfirm)
                a.addClass("btn-success");
            else
                a.addClass("btn-info");
            a.click(function () {
                idinventoryselect = $(this).attr("dataid");
                var target = $(this).attr("href");
                $($(this).attr("data-target")).removeData();
                // load the url and show modal on success
                $('#remoteModal').modal({ backdrop: 'static' });
                IDDeviceEdit = $(this).attr('dataid');
                $($(this).attr("data-target")).load(target, function () {
                    $($(this).attr("data-target")).dialog("open");
                    return false;
                });
            });

            td.append(a);
            return td;
        }

        // Search and load data on table
        $('#inputSearch').keyup(function () {
            var input = document.getElementById("inputSearch").value.toLowerCase();
            var temp = search(listDisplay, input);
            LoadTable(temp);
        });


        function LoadData(page) {
            currentpage = page;
            var _status = $("#ddlStatus").text();
            var keyword = $('#inputSearch').val();
            var numberinpage = 13;
            var status = (_status == "All") ? 0 : (_status == "Not Confirm") ? 1 : 2;
            $.ajax({
                type: "POST",
                url: "device/InventoryResolve.aspx/GetListRequest",
                data: JSON.stringify({
                    status: status,
                    keyword: keyword,
                    currentpage: page,
                    numberinpage: numberinpage
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = JSON.parse(response.d);
                    if (obj.Status) {
                        var _totalpage = Math.round(obj.TotalItem / numberinpage);
                        var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                        listdevices = obj.Data;
                        LoadTable(obj.Data);
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                    }
                },
                failure: function (response) {
                }
            });
        }

        function LoadTableOnStatus(filter) {
            ddlStatus.innerHTML = filter;
            LoadData(1);
        }

        LoadData(1);
        $('#inputSearch').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                LoadData(1);
            }
        });

    </script>
</head>
<body>
    <section id="widget-grid" class="">


        <div class="row">
            <div class="alert alert-info alert-block" style="margin-left: 10px;">
                <h4 class="alert-heading">Confirm borrow device</h4>
            </div>

            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable">
                <div class="btn-group">
                    <label class="label" style="float: left;">Status</label>
                    <div class="btn-group">
                        <a class="btn btn-primary" id="ddlStatus" style="width: 100px">All</a>
                        <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="javascript:LoadTableOnStatus('All');">All</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Confirmed');">Confirmed</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnStatus('Not Confirm');">Not Confirm</a>
                            </li>
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


            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top:5px;">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget jarviswidget-color-teal" id="inventoryresolve" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>Confirm devices</h2>
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
                            <div class="table-responsive" style="min-height: 560px; width: 100%; overflow: hidden; overflow-y: auto;">

                                <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="margin-bottom: 0px;">
                                    <thead>
                                        <tr>
                                            <th style="width: 20px" class="theadtable">No</th>
                                            <th class="theadtable">Inventory Name</th>
                                            <th class="theadtable">Request By</th>
                                            <th class="theadtable">Request Date</th>
                                            <th class="theadtable">Tottal Device</th>
                                            <th class="theadtable">Status</th>
                                            <th class="theadtable" style="width: 100px; text-align: center;">Confirm</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>

                            </div>
                            <div id="divpaging" style="float: right;">
                                <ul class="pagination">
                                </ul>
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
</body>
</html>
