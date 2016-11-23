<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctTeamConfirm.ascx.cs" Inherits="SoftwareStore.device.Controls.ctTeamConfirm" %>
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
            List request inventory device of members in team
        </header>
    </div>

    <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable pull-right">
        <div class="col-md-12" style="padding: 0px;">
            <div class="icon-addon addon-md">
                <input id="inputSearchTeamRequest" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                <label for="inputSearchTeamRequest" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
            </div>
        </div>
    </div>


    <!-- NEW WIDGET START -->
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 5px;">

        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget jarviswidget-color-teal" id="inventoryteamconfirm" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
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
                    <div class="table-responsive" style="min-height: 400px; width: 100%; overflow-y: auto;">

                        <table id="tableTeamRequest" class="table table-striped table-bordered table-hover" style="margin-bottom: 0px; min-width: 1100px;">
                            <thead>
                                <tr>
                                    <th class="theadtable" rowspan="2">Inventory Name</th>
                                    <th class="theadtable" rowspan="2">Request By</th>
                                    <th class="theadtable" rowspan="2">Request Date</th>
                                    <th class="theadtable" colspan="5">Sumary</th>
                                    <th class="theadtable" rowspan="2" style="width: 100px; text-align: center;">Finished</th>
                                    <th class="theadtable" rowspan="2" style="width: 100px; text-align: center;">Confirm</th>
                                </tr>
                                <tr>
                                    <th class="theadtable">Total Device</th>
                                    <th class="theadtable">Not Confirm</th>
                                    <th class="theadtable">Pending</th>
                                    <th class="theadtable">Accepted</th>
                                    <th class="theadtable">Rejected</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                    </div>
                    <div>
                        <div id="divtotalitemTeamRequest" style="float: left; margin-top: 10px; font-weight: bold; margin: 18px 0;">
                        </div>

                        <div id="divpagingTeamRequest" style="float: right; margin-top: 0px;">
                        </div>
                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->
            </div>
        </div>
    </div>
</div>

<script>
    var TeamRequest = {
        currentTeamRequest: null,
        currentpage: 1,
        data: [],

        findTeamRequest: function (id) {
            for (var i = 0; i < TeamRequest.data.length; i++) {
                if (TeamRequest.data[i].ID == id)
                    return TeamRequest.data[i];
            }
            return null;
        },
        LoadTable: function (list) {
            TeamRequest.currentTeamRequest = null;
            TeamRequest.data = list;
            var target = $('#tableTeamRequest > tbody').empty();
            if (list.length == 0) {
                EmptyTable(target, 10);
            }
            else {
                for (var i = 0; i < list.length; i++) {
                    var tr = $('<tr class="clickable">').attr('dataid', list[i].ID);
                    tr.click(function () {
                        inventoryid = $(this).attr("dataid");
                        typeinventory = "leader";
                        loadURL("/device/Confirmation/InventoryConfirm.aspx", $("#pageconfirmdevice"));
                    });
                    var td = createCell(list[i].Name);
                    tr.append(td);

                    var td = createCellName(list[i].RequestBy);
                    tr.append(td);

                    var td = createCell(list[i].RequestDate);
                    tr.append(td);

                    var td = createCell(list[i].DataInventory.TotalDevice).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(list[i].DataInventory.NumberNotConfirm).css("text-align", "center");
                    tr.append(td);

                    var td = createCell(list[i].DataInventory.NumberPending).css("text-align", "center");
                    tr.append(td);

                    var td = createCell(list[i].DataInventory.NumberAccept).css("text-align", "center");
                    tr.append(td);

                    var td = createCell(list[i].DataInventory.NumberReject).css("text-align", "center");
                    tr.append(td);


                    var td = createCellTick(list[i].DataInventory.NumberAccept == list[i].DataInventory.TotalDevice);
                    tr.append(td);

                    var td = $('<td style="vertical-align: middle;">');
                    var a = $('<label class="btn btn-xs" style="width:100%">').text(list[i].Status ? "View Confirm" : "Confirm");
                    a.attr('dataid', list[i].ID);
                    if (list[i].Status)
                        a.addClass("btn-success");
                    else
                        a.addClass("btn-info");
                    a.click(function () {
                        inventoryid = $(this).attr("dataid");
                        typeinventory = "leader";
                        loadURL("/device/Confirmation/InventoryConfirm.aspx", $("#pageconfirmdevice"));

                    });

                    td.append(a);

                    tr.append(td);

                    target.append(tr);


                }
            }
        },
        LoadData: function (page) {
            TeamRequest.currentpage = page;
            var numberinpage = 8;
            var _status = $("#ddlStatusTeamRequest").text();
            var keyword = $('#<%=inputSearchTeamRequest.ClientID%>').val();
            var status = 0;// (_status == "All") ? 0 : (_status == "Not Confirm") ? 1 : 2;
            AJAXFunction.CallAjax("POST", "/device/confirmation/TeamConfirm.aspx", "GetListRequest", {
                keyword: keyword,
                status: status,
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitemTeamRequest').empty();
                    divtotalitem.append('Total Request: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    TeamRequest.LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($('#divpagingTeamRequest'), page, totalpage, TeamRequest.LoadData);
                }
            });
        }
    }
    $('#<%=inputSearchTeamRequest.ClientID%>').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            TeamRequest.LoadData(1);
        }
    });

    function LoadTableOnStatusTeamRequest(filter) {
        ddlStatusTeamRequest.innerHTML = filter;
        TeamRequest.LoadData(1);
    }
    //TeamRequest.LoadData(1);
</script>
