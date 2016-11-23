<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveGroupByModel.aspx.cs" Inherits="DeviceManagement.device.MyApprove.ApproveGroupByModel" %>

<link href="device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />

<script type="text/javascript">
    var ApproveGroupByModelPage = {
        listtype: JSON.parse('<%=DeviceManagement.device.DeviceManagement.ListCategoryDevice()%>'),
        currentpage: 1,
        numberdeviceinpage: 14,
        IDApprove: null,
        ListApprove: [],
        FindApprove: function (IDApprove) {
            for (var i = 0; i < ApproveGroupByModelPage.ListApprove.length; i++) {
                if (ApproveGroupByModelPage.ListApprove[i].ID == IDApprove)
                    return ApproveGroupByModelPage.ListApprove[i];
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
                ApproveGroupByModelPage.LoadData(1);
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < ApproveGroupByModelPage.listtype.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(ApproveGroupByModelPage.listtype[i].Name);
                a.attr('dataid', ApproveGroupByModelPage.listtype[i].ID);
                a.click(function () {
                    $('#ddlType').text($(this).text());
                    $('#ddlType').attr("dataid", $(this).attr("dataid"));
                    ApproveGroupByModelPage.LoadData(1);
                });
                ul.append($('<li>').append(a));

            }
        },
        ShowNumberDevice: function (numberdevice) {
            $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            ApproveGroupByModelPage.numberdeviceinpage = numberdevice;
            ApproveGroupByModelPage.LoadData(1);
        },
        LoadData: function (page) {
            ApproveGroupByModelPage.currentpage = page;

            var status = $("#ddlStatus").text();
            var keyword = $('#inputSearch').val();
            var numberinpage = ApproveGroupByModelPage.numberdeviceinpage;
            var type = $("#ddlType").attr("dataid");
            AJAXFunction.CallAjax(
                "POST", "/device/MyApprove/ApproveGroupByModel.aspx", "GetAllApproval",
                {
                    keyword: keyword,
                    type: type,
                    currentpage: page,
                    numberinpage: numberinpage,
                    status: status,
                    //typeapprove: GetQueryStringHash("typeapprove")
                    typeapprove: 1
                },
                function (obj) {
                    if (obj.Status) {
                        var divtotalitem = $('#divtotalitem').empty();
                        divtotalitem.append('Total Item: ' + obj.TotalItem)
                        var _totalpage = Math.round(obj.TotalItem / numberinpage);
                        var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                        ApproveGroupByModelPage.ListApprove = obj.Data;
                        ApproveGroupByModelPage.LoadTable(obj.Data, ((page - 1) * numberinpage));
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, ApproveGroupByModelPage.LoadData);
                    }
                }
                );
        },
        LoadTable: function (list, no) {
            var table = $('#datatable_tabletools > tbody');
            table.empty();
            if (list.length == 0) {
                EmptyTable(table, 12);
            }
            for (i = 0; i < list.length; i++) {
                var tr = $('<tr>');
                var td = createCell(++no);
                tr.append(td);

                var td = $("<td>").append($("<label class='btn btn-success' style='padding-left:3px; padding-right:3px;'>").attr("dataid", list[i].ID).attr("datamodelid", list[i].Model).text("Approve").click(function () {
                    var dataid = $(this).attr("dataid");
                    ApproveGroupByModelPage.IDApprove = dataid;
                    var target = "/device/MyApprove/ApproveMultiDevice.aspx?ModelID=" + $(this).attr("datamodelid").replace(/ /g, '%20');
                    $('#remoteModal2').removeData();
                    $('#remoteModal2').modal({ backdrop: 'static' });
                    $('#remoteModal2').load(target, function () {
                        $('#remoteModal2').modal("show");
                    });

                }));
                tr.append(td);
                var td = $("<td>").append(Common.ShowSingleStatus(list[i].UserName, list[i].FullName));
                tr.append(td);

                var td = createCell(list[i].Type);
                tr.append(td);
                var td = createCell(list[i].Model);
                tr.append(td);

                var td = createCell(list[i].Count);
                tr.append(td);
                table.append(tr);
            }
            set_statuses();
        },
        LoadTableOnType: function (status) {
            ddlStatus.innerHTML = status;
            ApproveGroupByModelPage.LoadData(1);
        },
        Approve: function () {
            if (ApproveGroupByModelPage.listHasSelect.length == 0) {
                alertbox("Please choose item!!");
                return;
            }
            var callback = function () {
                AJAXFunction.CallAjax("POST",
                    "device/MyApprove/Approve.aspx", "Approval", {
                        arrid: ApproveGroupByModelPage.listHasSelect,
                    }, function (response) {
                        if (response.Status) {
                            ApproveGroupByModelPage.listHasSelect = [];
                            ApproveGroupByModelPage.LoadData(ApproveGroupByModelPage.currentpage);

                            alertSmallBox("Approval request success success", "1 second ago!!", "success");
                        }
                        else {
                            confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
                        }
                    });
            };
            confirm("Confirm", "Do you want to approval <b style='color:red'>" + ApproveGroupByModelPage.listHasSelect.length + "</b> items selected!!", "OK", "Cancel", callback);
        }
    }

    ApproveGroupByModelPage.LoadListCategory();
    ApproveGroupByModelPage.LoadData(1);


    $('#inputSearch').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            ApproveGroupByModelPage.LoadData(1);
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
                            <a href="javascript:ApproveGroupByModelPage.LoadTableOnType('All');">All</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByModelPage.LoadTableOnType('Borrowing');">Borrowing</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByModelPage.LoadTableOnType('Pending');">Pending</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByModelPage.LoadTableOnType('Returned');">Returned</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByModelPage.LoadTableOnType('Reject');">Reject</a>
                        </li>
                        <li>
                            <a href="javascript:ApproveGroupByModelPage.LoadTableOnType('Cancel');">Cancel</a>
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
                                    <a href="javascript:void(0);" onclick="ApproveGroupByModelPage.ShowNumberDevice(5);">5</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByModelPage.ShowNumberDevice(10);">10</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByModelPage.ShowNumberDevice(15);">15</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByModelPage.ShowNumberDevice(20);">20</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByModelPage.ShowNumberDevice(50);">50</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="ApproveGroupByModelPage.ShowNumberDevice(100);">100</a>
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
                                            <th class="theadtable" style="width: 30px">No</th>
                                            <th class="theadtable" style="width: 50px">Action</th>
                                            <th class="theadtable" style="width: 230px">Borrrower</th>
                                            <th class="theadtable" style="width: 80px">Type</th>
                                            <th class="theadtable" style="width: 250px">Model </th>
                                            <th style="text-align: left">Number Device</th>

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
</section>
