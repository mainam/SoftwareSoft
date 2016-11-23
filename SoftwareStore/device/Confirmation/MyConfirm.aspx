<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyConfirm.aspx.cs" Inherits="DeviceManagement.device.Confirmation.MyConfirm" %>

<style>
    #dialog-category {
        margin-bottom: -30px;
    }

    .ui-dialog-buttonset {
        margin-right: 32px !important;
    }

    .onoffswitch-switch {
        right: 55px;
    }
</style>

<div>
    <div class="smart-form" style="margin-bottom: 20px;">

        <header style="padding-bottom: 15px; margin-right: 0px;">
            List requests inventory device
        </header>
    </div>

    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable" style="margin-bottom: -2px;">
        <div class="btn-group">
            <label class="label" style="float: left;">Status</label>
            <div class="btn-group">
                <a class="btn btn-primary" id="ddlStatusMyRequest" style="width: 100px">All</a>
                <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="javascript:LoadTableOnStatusMyRequest('All');">All</a>
                    </li>
                    <li>
                        <a href="javascript:LoadTableOnStatusMyRequest('Confirmed');">Confirmed</a>
                    </li>
                    <li>
                        <a href="javascript:LoadTableOnStatusMyRequest('Not Confirm');">Not Confirm</a>
                    </li>
                </ul>
            </div>
        </div>
    </article>
    <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable">
        <div class="col-md-12" style="padding: 0px;">
            <div class="icon-addon addon-md">
                <input id="inputSearchMyRequest" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                <label for="inputSearchMyRequest" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
            </div>
        </div>
    </article>


    <!-- NEW WIDGET START -->
    <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 5px;">

        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget jarviswidget-color-teal" id="myconfirm" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
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
                    <div class="table-responsive" style="min-height: 360px; width: 100%; overflow: hidden; overflow-y: auto;">

                        <table id="tableMyRequest" class="table table-striped table-bordered table-hover" style="margin-bottom: 0px;">
                            <thead>
                                <tr>
                                    <th style="width: 20px" class="theadtable">No</th>
                                    <th class="theadtable">Inventory Name</th>
                                    <th class="theadtable">Request By</th>
                                    <th class="theadtable">Request Date</th>
                                    <th class="theadtable">Total Device Borrowed</th>
                                    <th class="theadtable">Status</th>
                                    <th class="theadtable" style="width: 100px; text-align: center;">Confirm</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                    </div>
                    <div>
                        <div id="divtotalitemMyRequest" style="float: left; margin-top: 10px; font-weight: bold; margin: 18px 0;">
                        </div>

                        <div id="divpagingMyRequest" style="float: right; margin-top: 0px;">
                        </div>
                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->
            </div>
    </article>
</div>
<script>
    var MyRequest = {
        currentMyRequest: null,
        currentpage: 1,
        data: [],

        findMyRequest: function (id) {
            for (var i = 0; i < MyRequest.data.length; i++) {
                if (MyRequest.data[i].ID == id)
                    return MyRequest.data[i];
            }
            return null;
        },
        LoadTable: function (list) {
            MyRequest.currentMyRequest = null;
            MyRequest.data = list;
            var target = $('#tableMyRequest > tbody').empty();
            if (list.length == 0) {
                EmptyTable(target, 7);
            }
            else {
                for (var i = 0; i < list.length; i++) {
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

                    var td = $('<td style="vertical-align: middle;">');
                    var a = $('<label class="btn btn-xs" style="width:100%">').text(list[i].Status ? "View Confirm" : "Confirm");
                    a.attr('dataid', list[i].ID);
                    if (list[i].Status)
                        a.addClass("btn-success");
                    else
                        a.addClass("btn-info");
                    a.click(function () {
                        typeinventory = "user";
                        loadURL("/device/Confirmation/InventoryConfirm.aspx", $("#pageconfirmdevice"));
                    });
                    //    MyRequest.currentMyRequest = $(this).attr("dataid");
                    //    //var target = $(this).attr("href");
                    //    //$($(this).attr("data-target")).removeData();
                    //    //// load the url and show modal on success
                    //    //$('#remoteModal').modal({ backdrop: 'static' });
                    //    //IDDeviceEdit = $(this).attr('dataid');
                    //    //$($(this).attr("data-target")).load(target, function () {
                    //    //    $($(this).attr("data-target")).dialog("open");
                    //    //    return false;
                    //    //});
                    //});

                    td.append(a);

                    tr.append(td);

                    target.append(tr);


                }
            }
        },
        LoadData: function (page) {
            
            MyRequest.currentpage = page;
            var numberinpage = 8;
            var _status = $("#ddlStatusMyRequest").text();
            var keyword = $('#inputSearchMyRequest').val();
            
            var status = (_status == "All") ? 0 : (_status == "Not Confirm") ? 1 : 2;
            AJAXFunction.CallAjax("POST", "/device/confirmation/MyConfirm.aspx", "GetListRequest", {
                keyword: keyword,
                status: status,
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {
                
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitemMyRequest').empty();
                    divtotalitem.append('Total Request: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    MyRequest.LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($('#divpagingMyRequest'), page, totalpage, MyRequest.LoadData);
                }
            });
        }
    }
    pageSetUp();
    $('#inputSearchMyRequest').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            MyRequest.LoadData(1);
        }
    });

    function LoadTableOnStatusMyRequest(filter) {
        ddlStatusMyRequest.innerHTML = filter;
        MyRequest.LoadData(1);
    }

    $(document).ready(function () {
        MyRequest.LoadData(1);
    });
</script>
