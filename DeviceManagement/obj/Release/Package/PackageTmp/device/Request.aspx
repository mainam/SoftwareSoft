<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="DeviceManagement.device.Request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <link href="/css/tablecss.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <script type="text/javascript">
        var listHasSelect = [];
        var listAllowCancel = [];
        var listAllowRemove = [];
        var currentpage;
        var numberdeviceinpage = 14;
        pageSetUp();
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

        function LoadData(page) {
            currentpage = page;

            var status = $("#ddlStatus").text();
            var keyword = $('#inputSearch').val();
            var numberinpage = numberdeviceinpage;
            var type = $("#ddlType").attr("dataid");
            AJAXFunction.CallAjax("POST", "/device/Request.aspx", "GetMyRequest", {
                type: type,
                keyword: keyword,
                currentpage: page,
                numberinpage: numberinpage,
                status: status,
            },
            function (obj) {
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitem').empty();
                    divtotalitem.append('Total Item: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    listAllowCancel = obj.AllowCancel;
                    listAllowRemove = obj.AllowRemove;
                    listHasSelect = [];
                    updateButton();
                    $('#btncheck').get(0).checked = false;

                    LoadTable(obj.Data, ((parseInt(page) - 1) * numberinpage));
                    AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                }
            });
        }
        function ShowNumberDevice(numberdevice) {
            $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            numberdeviceinpage = numberdevice;
            LoadData(1);
        }


        function LoadTableOnType(status) {
            ddlStatus.innerHTML = status;
            LoadData(1);
        }
        $('#inputSearch').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                LoadData(1);
            }
        });

        $('#btncheck').click(function () {

            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"][disabled!="disabled"]');
            if (this.checked) {
                for (var i = 0; i < input.length; i++)
                    input[i].checked = true;
                listHasSelect = listAllowRemove.concat(listAllowCancel);
            }
            else {
                for (var i = 0; i < input.length; i++)
                    input[i].checked = false;
                listHasSelect = [];
            }
            updateButton();
        });

        function updateButton() {

            var allowremove = listAllowRemove.length != 0;
            var allowrcancel = listAllowCancel.length != 0;

            if (listHasSelect.length == 0) {
                allowrcancel = false;
                allowremove = false;
            }
            listHasSelect.forEach(function (item) {
                if (!listAllowRemove.contains(item)) {
                    allowremove = false;
                }
                if (!listAllowCancel.contains(item)) {
                    allowrcancel = false;
                }
                if (allowremove == false && allowrcancel == false)
                    return;
            });
            document.getElementById("btnDelete").disabled = !allowremove;
            document.getElementById("btnCancel").disabled = !allowrcancel;
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
                if (this.checked) {
                    listHasSelect.push(parseInt($(this).attr('dataid')));
                }
                else {
                    $('#btncheck')[0].checked = false;
                    var index = listHasSelect.indexOf(parseInt($(this).attr('dataid')));
                    if (index != -1)
                        listHasSelect.splice(index, 1);
                }
                updateButton();
            });
            if (!allowborrow) {
                label.addClass('state-disabled');
                checkbox.attr('disabled', 'disabled');
            }
            td.append(label);
            return td;
        }

        function LoadTable(list, startindex) {
            var table = $('#datatable_tabletools > tbody');
            table.empty();
            if (list.length == 0) {
                EmptyTable(table, "11")
            }
            for (i = 0; i < list.length; i++) {
                var tr = $('<tr>');
                var td = createCheckBox(list[i].IDApprove, list[i].StatusBorrow != 'Borrowing', listHasSelect.indexOf(list[i].IDApprove) != -1);
                tr.append(td);
                //var td = createCell(++startindex);
                //tr.append(td);

                var td = createCellNameApprove(list[i].UserBorrow, "Submitted");
                tr.append(td);

                var td = createCell(list[i].Reason);
                tr.append(td);

                var td = createCell(list[i].SubmitDate);
                tr.append(td);

                var td = createCell(list[i].StartDate);
                tr.append(td);

                var td = createCell(list[i].EndDate);
                tr.append(td);

                var td = createCell(list[i].Model);
                tr.append(td);

                var td = createCell(list[i].TagDevice);
                tr.append(td);

                var td = createCellNameApprove(list[i].Manager, list[i].StatusManager);
                tr.append(td);

                var td = createCell(list[i].StatusBorrow);
                tr.append(td);

                table.append(tr);

            }
            set_statuses();
        }


        function Cancel() {

            if (listHasSelect.length == 0) {
                alertbox("Please choose item!!");
                return;
            }
            var callback = function () {
                AJAXFunction.CallAjax("POST",
                    "device/Request.aspx", "Cancel", {
                        arrid: listHasSelect,
                    }, function (response) {
                        if (response.Status) {
                            listHasSelect = [];
                            $('#btncheck')[0].checked = false;
                            LoadData(currentpage);
                            updateButton();
                            alertSmallBox("Cancel request success", "1 second ago!!", "success");
                        } else {
                            confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
                        }

                    });
            };
            confirm("Confirm", "Do you want to cancel <b style='color:red'>" + listHasSelect.length + "</b> items selected!!", "OK", "Cancel", callback);
        }

        function Delete() {
            if (listHasSelect.length == 0) {
                alertbox("Please choose item!!");
                return;
            }
            var callback = function () {
                AJAXFunction.CallAjax("POST",
                    "device/Request.aspx", "Delete", {
                        arrid: listHasSelect,
                    }, function (response) {
                        if (response.Status) {
                            listHasSelect = [];
                            $('#btncheck')[0].checked = false;
                            LoadData(1);
                            updateButton();
                            alertSmallBox("Delete request success", "1 second ago!!", "success");
                        }
                        else {
                            confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
                        }

                    });
            };
            confirm("Confirm", "Do you want to remove <b style='color:red'>" + listHasSelect.length + "</b> items selected!!", "OK", "Cancel", callback);
        }

        function BorrowDeviceReturned() {
            location.replace("#device/BorrowDevice/BorrowDeviceHaveReturn.aspx");
        }

    </script>
</head>
<body>
    <section id="widget-grid" class="">
        <div>
            <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
                <div class="alert alert-info alert-block" style="">
                    <h4 class="alert-heading">My Request</h4>
                </div>

                <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable" style="padding-left: 0px;">
                    <div class="btn-group">
                        <label class="label" style="float: left;">Type</label>
                        <div class="btn-group">
                            <div class="btn-group">
                                <a class="btn btn-primary" id="ddlType" style="width: 90px" dataid="0">All</a>
                                <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>

                                <ul class="dropdown-menu" id="ulddltype">
                                </ul>
                            </div>
                        </div>

                        <label class="label" style="float: left;">Status</label>
                        <div class="btn-group" style="float: left;">
                            <a class="btn btn-success" id="ddlStatus" style="width: 95px; background-color: #3276b1">All</a>
                            <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" style="background-color: #3276b1"><span class="caret"></span></a>

                            <ul class="dropdown-menu" style="width: 100px;">
                                <li>
                                    <a href="javascript:LoadTableOnType('All');">All</a>
                                </li>
                                <li>
                                    <a href="javascript:LoadTableOnType('Cancel');">Cancel</a>
                                </li>
                                <li>
                                    <a href="javascript:LoadTableOnType('Reject');">Reject</a>
                                </li>
                                <li>
                                    <a href="javascript:LoadTableOnType('Pending');">Pending</a>
                                </li>
                                <li>
                                    <a href="javascript:LoadTableOnType('Borrowing');">Borrowing</a>
                                </li>
                                <li>
                                    <a href="javascript:LoadTableOnType('Returned');">Returned</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </article>
                <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable">
                    <div class="col-md-12" style="padding: 0px;">
                        <div class="icon-addon addon-md">
                            <input id="inputSearch" type="search" placeholder="Enter keyword to seach" class="form-control" aria-controls="dt_basic" runat="server" />
                            <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                        </div>
                    </div>
                </article>
            </div>
        </div>


        <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="listrequest" style="margin-bottom: 0px;" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>List of devices</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->

                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px;">Show: 14<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
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

                            <div class="table-responsive  smart-form">

                                <div style="min-height: 540px; overflow: auto;">
                                    <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1600px;">
                                        <thead>
                                            <tr>
                                                <th class="theadtable" style="width: 20px">
                                                    <label class="checkbox">
                                                        <input type="checkbox" id="btncheck" /><i></i>
                                                    </label>
                                                </th>
                                                <th class="theadtable" style="width: 230px">Originator</th>
                                                <th class="theadtable" style="width: 230px">Reason</th>
                                                <th class="theadtable" style="width: 80px">Submit date</th>
                                                <th class="theadtable" style="width: 70px">Start date</th>
                                                <th class="theadtable" style="width: 70px">End date</th>
                                                <th class="theadtable" style="width: 130px;">Model</th>
                                                <th class="theadtable" style="width: 30px;">#Tag</th>
                                                <th class="theadtable" style="width: 190px;">Keeper</th>
                                                <%--<th class="theadtable" style="width: 190px;">Manager</th>--%>
                                                <%--<th class="theadtable" style="width: 220px;">Borrower</th>--%>
                                                <th class="theadtable" style="width: 50px;">Status</th>
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
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div style="padding-top: 20px; clear: both;">
                    <input type="button" class="btn btn-primary pull-left" id="btnReborrow" style="margin-right: 5px; width: 255px;" value="Borrow these devices have returned" onclick="BorrowDeviceReturned();" />
                    <input type="button" class="btn btn-primary pull-right" id="btnDelete" disabled="disabled" style="width: 95px;" value="Delete" onclick="Delete();" />
                    <input type="button" class="btn btn-primary pull-right" id="btnCancel" disabled="disabled" style="margin-right: 5px; width: 95px;" value="Cancel" onclick="Cancel();" />
                </div>
            </article>

            <!-- WIDGET END -->

        </div>

    </section>
</body>
</html>
