<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveGroupByDevice.aspx.cs" Inherits="DeviceManagement.device.MyApprove.ApproveGroupByDevice" %>

<link href="device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />

<script type="text/javascript">
    var ApproveGroupByDevicePage = {
        listtype: JSON.parse('<%=DeviceManagement.device.DeviceManagement.ListCategoryDevice()%>'),
        currentpage: 1,
        numberdeviceinpage: 14,
        listHasSelect: [],
        IDApprove: null,
        ListApprove: [],
        listAllowRemove: [],
        listAllowApproval: [],
        FindApprove: function (IDApprove) {
            for (var i = 0; i < ApproveGroupByDevicePage.ListApprove.length; i++) {
                if (ApproveGroupByDevicePage.ListApprove[i].IDApprove == IDApprove)
                    return ApproveGroupByDevicePage.ListApprove[i];
            }
            return null;
        },
        LoadListCategory: function () {
            var ul = $('#ulddltype').empty();
            var a = $('<a href="javascript:void(0)">').text("All");
            a.attr('dataid', 0);
            a.click(function () {
                $('#ddlType').text($(this).text());
                $('#ddlType').attr("dataid", $(this).attr("dataid"));
                ApproveGroupByDevicePage.LoadData(1);
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < ApproveGroupByDevicePage.listtype.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(ApproveGroupByDevicePage.listtype[i].Name);
                a.attr('dataid', ApproveGroupByDevicePage.listtype[i].ID);
                a.click(function () {
                    $('#ddlType').text($(this).text());
                    $('#ddlType').attr("dataid", $(this).attr("dataid"));
                    ApproveGroupByDevicePage.LoadData(1);
                });
                ul.append($('<li>').append(a));

            }
        },
        ShowNumberDevice: function (numberdevice) {
            $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            ApproveGroupByDevicePage.numberdeviceinpage = numberdevice;
            ApproveGroupByDevicePage.LoadData(1);
        },
        LoadData: function (page) {
            ApproveGroupByDevicePage.currentpage = page;

            var status = $("#ddlStatus").text();
            var keyword = $('#inputSearch').val();
            var numberinpage = ApproveGroupByDevicePage.numberdeviceinpage;
            var type = $("#ddlType").attr("dataid");
            AJAXFunction.CallAjax(
                 "POST", "/device/MyApprove/ApproveGroupByDevice.aspx", "GetAllApproval",
             {
                 keyword: keyword,
                 type: type,
                 currentpage: page,
                 numberinpage: numberinpage,
                 status: status,
                 //typeapprove: GetQueryStringHash("typeapprove")
                 typeapprove: 1
             }, function (obj) {
                 if (obj.Status) {
                     var divtotalitem = $('#divtotalitem').empty();
                     divtotalitem.append('Total Item: ' + obj.TotalItem)
                     var _totalpage = Math.round(obj.TotalItem / numberinpage);
                     var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                     ApproveGroupByDevicePage.ListApprove = obj.Data;
                     ApproveGroupByDevicePage.listHasSelect = [];
                     ApproveGroupByDevicePage.listAllowApproval = obj.AllowApproval;
                     ApproveGroupByDevicePage.listAllowRemove = obj.AllowRemove;
                     ApproveGroupByDevicePage.updateButton();
                     $('#btncheck').get(0).checked = false;
                     ApproveGroupByDevicePage.LoadTable(obj.Data, ((page - 1) * numberinpage));
                     AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, ApproveGroupByDevicePage.LoadData);
                 }
             });
        },
        LoadTable: function (list, no) {
            var table = $('#datatable_tabletools > tbody');
            table.empty();
            if (list.length == 0) {
                EmptyTable(table, 12);
            }
            for (i = 0; i < list.length; i++) {
                var tr = $('<tr>');

                var td = createCheckBox(list[i].IDApprove, list[i].StatusBorrow != "Borrowing", ApproveGroupByDevicePage.listHasSelect.indexOf(list[i].IDApprove) != -1);
                tr.append(td);

                if (list[i].StatusBorrow == "Pending") {
                    var td = $("<td>").append($("<label class='btn btn-success' style='padding-left:3px; padding-right:3px;'>").attr("dataid", list[i].IDApprove).attr("datadeviceid", list[i].IDDevice).attr("datamodelid", list[i].Model).text("Approve").click(function () {
                        var dataid = $(this).attr("dataid");
                        ApproveGroupByDevicePage.IDApprove = dataid;
                        var target = "/device/MyApprove/ApproveDevice.aspx?DeviceID=" + $(this).attr("datadeviceid") + "&ModelID=" + $(this).attr("datamodelid").replace(/ /g, '%20');
                        $('#remoteModal2').removeData();
                        $('#remoteModal2').modal({ backdrop: 'static' });
                        $('#remoteModal2').load(target, function () {
                            $('#remoteModal2').modal("show");
                        });

                    }));
                    tr.append(td);
                }
                else {
                    var td = $("<td>");
                    tr.append(td);

                }
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

                var td = createCell(list[i].StatusDevice);
                tr.append(td);

                //var td = createCellName(list[i].Manager, list[i].StatusManager);
                //tr.append(td);

                //var td = createCellName(list[i].Borrower, list[i].StatusKeeper);
                //tr.append(td);

                var td = createCell(list[i].StatusBorrow);
                tr.append(td);



                table.append(tr);
            }
            set_statuses();
        },
        LoadTableOnType: function (status) {
            ddlStatus.innerHTML = status;
            ApproveGroupByDevicePage.LoadData(1);
        },
        Approve: function () {
            if (ApproveGroupByDevicePage.listHasSelect.length == 0) {
                alertbox("Please choose item!!");
                return;
            }
            var callback = function () {
                AJAXFunction.CallAjax("POST",
                    "device/MyApprove/ApproveGroupByDevice.aspx", "Approval", {
                        arrid: ApproveGroupByDevicePage.listHasSelect,
                    }, function (response) {
                        if (response.Status) {

                            ApproveGroupByDevicePage.listHasSelect = [];
                            $('#btncheck')[0].checked = false;
                            ApproveGroupByDevicePage.LoadData(ApproveGroupByDevicePage.currentpage);
                            ApproveGroupByDevicePage.updateButton();

                            alertSmallBox("Approval request success success", "1 second ago!!", "success");
                        }
                        else {
                            confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
                        }
                    });
            };
            confirm("Confirm", "Do you want to approval <b style='color:red'>" + ApproveGroupByDevicePage.listHasSelect.length + "</b> items selected!!", "OK", "Cancel", callback);
        },
        Reject: function () {
            if (ApproveGroupByDevicePage.listHasSelect.length == 0) {
                alertbox("Please choose item!!");
                return;
            }
            var callback = function () {
                AJAXFunction.CallAjax("POST",
                    "device/MyApprove/ApproveGroupByDevice.aspx", "Reject", {
                        arrid: ApproveGroupByDevicePage.listHasSelect,
                    }, function (response) {
                        if (response.Status) {

                            ApproveGroupByDevicePage.listHasSelect = [];
                            $('#btncheck')[0].checked = false;
                            ApproveGroupByDevicePage.LoadData(ApproveGroupByDevicePage.currentpage);
                            ApproveGroupByDevicePage.updateButton();

                            alertSmallBox("Reject request success success", "1 second ago!!", "success");
                        }
                        else {
                            confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
                        }
                    });
            };
            confirm("Confirm", "Do you want to reject <b style='color:red'>" + ApproveGroupByDevicePage.listHasSelect.length + "</b> items selected!!", "OK", "Cancel", callback);
        },
        updateButton: function () {
            var allowremove = ApproveGroupByDevicePage.listAllowRemove.length != 0;
            var allowapproval = ApproveGroupByDevicePage.listAllowApproval.length != 0;

            if (ApproveGroupByDevicePage.listHasSelect.length == 0) {
                allowapproval = false;
                allowremove = false;
            }
            ApproveGroupByDevicePage.listHasSelect.forEach(function (item) {
                if (!ApproveGroupByDevicePage.listAllowApproval.contains(item)) {
                    allowapproval = false;
                }
                if (!ApproveGroupByDevicePage.listAllowRemove.contains(item)) {
                    allowremove = false;
                }
                if (allowapproval == false && allowremove == false)
                    return;
            });
            document.getElementById("btnDelete").disabled = !allowremove;
            document.getElementById("btnApprove").disabled = !allowapproval;
            document.getElementById("btnReject").disabled = !allowapproval;
        },
        Delete: function () {
            if (ApproveGroupByDevicePage.listHasSelect.length == 0) {
                alertbox("Please choose item!!");
                return;
            }
            var callback = function () {
                AJAXFunction.CallAjax("POST",
                    "device/MyApprove/ApproveGroupByDevice.aspx", "Delete", {
                        arrid: ApproveGroupByDevicePage.listHasSelect,
                    }, function (response) {
                        if (response.Status) {

                            ApproveGroupByDevicePage.listHasSelect = [];
                            $('#btncheck')[0].checked = false;
                            ApproveGroupByDevicePage.LoadData(1);
                            ApproveGroupByDevicePage.updateButton();

                            alertSmallBox("Delete request success", "1 second ago!!", "success");
                        }
                        else {
                            confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
                        }

                    });
            };
            confirm("Confirm", "Do you want to remove <b style='color:red'>" + ApproveGroupByDevicePage.listHasSelect.length + "</b> items selected!!", "OK", "Cancel", callback);
        }
    }

    ApproveGroupByDevicePage.LoadListCategory();
    ApproveGroupByDevicePage.LoadData(1);


    $('#btncheck').click(function () {
        input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"][disabled!="disabled"]');
        if (this.checked) {
            for (var i = 0; i < input.length; i++)
                input[i].checked = true;
            ApproveGroupByDevicePage.listHasSelect = ApproveGroupByDevicePage.listAllowApproval.concat(ApproveGroupByDevicePage.listAllowRemove);
        }
        else {
            for (var i = 0; i < input.length; i++)
                input[i].checked = false;
            ApproveGroupByDevicePage.listHasSelect = [];
        }
        ApproveGroupByDevicePage.updateButton();
    });


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
                ApproveGroupByDevicePage.listHasSelect.push(parseInt($(this).attr('dataid')));
            }
            else {
                $('#btncheck')[0].checked = false;
                var index = ApproveGroupByDevicePage.listHasSelect.indexOf(parseInt($(this).attr('dataid')));
                if (index != -1)
                    ApproveGroupByDevicePage.listHasSelect.splice(index, 1);
            }
            ApproveGroupByDevicePage.updateButton();
        });
        if (!allowborrow) {
            label.addClass('state-disabled');
            checkbox.attr('disabled', 'disabled');
        }
        td.append(label);
        return td;
    }







    // Click select all

    $('#inputSearch').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            ApproveGroupByDevicePage.LoadData(1);
        }
    });

    pageSetUp();

</script>

<section id="widget-grid" class="">
    <div class="row" style="margin-left: 0px; margin-right: 0px; margin-bottom: 5px;">
        <div class="alert alert-info alert-block">
            <h4 class="alert-heading">Approve</h4>
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
                <div class="btn-group">
                    <label class="label" style="float: left;">Status</label>

                    <a class="btn btn-success" id="ddlStatus" style="background-color: #3276b1; width: 95px">Pending</a>
                    <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" style="background-color: #3276b1; margin-right: 10px;">
                        <span class="caret"></span></a>

                    <ul class="dropdown-menu">
                        <li>
                            <a href="javascript:ApproveGroupByDevicePage.LoadTableOnType('All');">All</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByDevicePage.LoadTableOnType('Borrowing');">Borrowing</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByDevicePage.LoadTableOnType('Pending');">Pending</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByDevicePage.LoadTableOnType('Returned');">Returned</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByDevicePage.LoadTableOnType('Reject');">Reject</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByDevicePage.LoadTableOnType('Cancel');">Cancel</a>
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
    </div>

    <div class="row">

        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget  jarviswidget-color-teal" id="listapprove" style="margin-bottom: 0px;" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <span class="widget-icon"><i class="fa fa-table"></i></span>
                    <h2>List of request</h2>
                    <div class="widget-toolbar" role="menu">
                        <!-- add: non-hidden - to disable auto hide -->

                        <div class="btn-group">
                            <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px;">Show: 14<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                            <ul class="dropdown-menu pull-right js-status-update">
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByDevicePage.ShowNumberDevice(5);">5</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByDevicePage.ShowNumberDevice(10);">10</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByDevicePage.ShowNumberDevice(15);">15</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByDevicePage.ShowNumberDevice(20);">20</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByDevicePage.ShowNumberDevice(50);">50</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByDevicePage.ShowNumberDevice(100);">100</a>
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
                            <div style="min-height: 540px; overflow: auto;">

                                <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1600px;">
                                    <thead>
                                        <tr>
                                            <th class="theadtable" style="width: 20px">
                                                <label class="checkbox">
                                                    <input type="checkbox" id="btncheck" /><i></i>
                                                </label>
                                            </th>
                                            <th class="theadtable" style="width: 50px">Approve</th>
                                            <th class="theadtable" style="width: 230px">Originator</th>
                                            <th class="theadtable" style="width: 300px">Reason</th>
                                            <th class="theadtable" style="width: 80px">Submit date</th>
                                            <th class="theadtable" style="width: 70px">Start date</th>
                                            <th class="theadtable" style="width: 70px">End date</th>
                                            <th class="theadtable" style="width: 130px;">Model</th>
                                            <th class="theadtable" style="width: 50px;">#Tag</th>
                                            <th class="theadtable" style="width: 100px;">Status Device</th>
                                            <%--                                                <th class="theadtable" style="width: 190px;">Manager</th>
                                                <th class="theadtable" style="width: 220px;">Borrower</th>--%>
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
        <div style="padding-top: 20px; clear: both">
            <input type="button" id="btnDelete" class="btn btn-primary" style="float: right; width: 95px;" value="Delete" onclick="ApproveGroupByDevicePage.Delete();" disabled="disabled" />
            <input type="button" id="btnReject" class="btn btn-primary" style="margin-right: 10px; float: right; width: 95px;" value="Reject" onclick="ApproveGroupByDevicePage.Reject();" disabled="disabled" />
            <input type="button" id="btnApprove" class="btn btn-primary" style="margin-right: 10px; float: right; width: 95px;" value="Approve" onclick="ApproveGroupByDevicePage.Approve();" disabled="disabled" />
        </div>
        <!-- WIDGET END -->

    </div>
</section>
