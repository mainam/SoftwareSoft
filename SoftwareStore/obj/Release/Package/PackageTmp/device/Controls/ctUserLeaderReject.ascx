<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctUserLeaderReject.ascx.cs" Inherits="DeviceManagement.device.Controls.ctUserLeaderReject" %>
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

    .checkbox {
        margin-top: -5px;
    }
</style>

<div>
    <div class="smart-form" style="margin-bottom: 20px;">

        <header style="padding-bottom: 15px; margin-right: 0px;">
            List devices leader has rejected
        </header>
    </div>

    <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9 sortable-grid ui-sortable" style="margin-bottom: -2px;">
        <div class="btn-group">
            <label class="label" style="float: left;">Type</label>

            <div class="btn-group">
                <a class="btn btn-primary" id="ddlType" runat="server" style="width: 90px" dataid="0">All</a>
                <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
                <ul class="dropdown-menu" id="ulddltype" runat="server">
                </ul>
            </div>
        </div>
    </div>
    <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable">
        <div class="col-md-12" style="padding: 0px;">
            <div class="icon-addon addon-md">
                <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
            </div>
        </div>
    </div>


    <!-- NEW WIDGET START -->
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 5px;">

        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget jarviswidget-color-teal" id="leaderreject" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
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
                    <div class="table-responsive smart-form" id="divLeaderReject" style="width: 100%;">

                        <table id="tableLeaderReject" class="table table-striped table-bordered table-hover" style="margin-bottom: 0px; min-width: 1000px;">
                            <thead>
                                <tr>
                                    <th style="width: 150px;">Model</th>
                                    <th style="width: 90px;">Type</th>
                                    <th style="width: 80px;">Tag</th>
                                    <th style="width: 120px;">IMEI</th>
                                    <th style="width: 120px;">Serial</th>
                                    <th style="width: 90px;">Borrow Date</th>
                                    <th style="width: 110px;">Current Confirm</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                    </div>
                    <div>
                        <div id="divtotalitem" runat="server" style="float: left; margin-top: 10px; font-weight: bold; margin: 18px 0;">
                        </div>

                        <div id="divpaging" runat="server" style="float: right; margin-top: 0px;">
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
    var LeaderReject = {
        Keyword: $("#<%=inputSearch.ClientID%>"),
        DllType: $('#<%=ddlType.ClientID%>'),
        LoadData: function () {
            AJAXFunction.CallAjax("POST", "/device/confirmation/userinventorypage.aspx", "ListLeaderReject", {
                type: LeaderReject.DllType.attr("dataid"),
                keyword: LeaderReject.Keyword.val(),
                inventoryid: UserPage.inventoryid
            }, function (response) {
                if (response.Status) {
                    LeaderReject.ShowData(response.Data);
                    pageSetUp();
                }
            });
        },
        ListType: JSON.parse('<%=DataAccess.DeviceFolder.CategoryDeviceInfo.ListCategoryDevice()%>'),
        LoadListCategory: function () {
            var ul = $('#<%=ulddltype.ClientID%>').empty();
            var a = $('<a href="javascript:void(0)">').text("All");
            a.attr('dataid', 0);
            a.click(function () {
                $('#<%=ddlType.ClientID%>').text($(this).text());
                $('#<%=ddlType.ClientID%>').attr("dataid", $(this).attr("dataid"));
                LeaderReject.LoadData();
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < LeaderReject.ListType.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(LeaderReject.ListType[i].Name);
                a.attr('dataid', LeaderReject.ListType[i].ID);
                a.click(function () {
                    $('#<%=ddlType.ClientID%>').text($(this).text());
                    $('#<%=ddlType.ClientID%>').attr("dataid", $(this).attr("dataid"));
                    LeaderReject.LoadData();
                });
                ul.append($('<li>').append(a));
            }
        },

        CurrentStatus: function (currentstatus, reason) {
            var td = $("<td style='vertical-align: middle;'>");
            var status = LeaderReject.GetStatusConfirm(currentstatus);
            var a = $('<a style="text-decoration: none;">');
            a.text(status);
            a.attr("href", "javascript:void(0);");
            a.attr("data-content", reason != "" ? reason : "no input content");
            a.click(function () {
                dialogbox("Reason", $(this).attr("data-content"));
            });
            td.append(a);
            return td;
        },
        GetStatusConfirm: function (currentstatus) {
            switch (currentstatus) {
                case 0:
                    return "Not Confirm";
                case 1:
                    return "Not Borrow";
                case 2:
                    return "Loss";
                case 3:
                    return "Broken";
                case 4:
                    return "Good";
                default:
                    return "Not Confirm";
            }
        },


        ShowData: function (data) {

            var table = $("#tableLeaderReject > tbody").empty();
            var divtotalitem = $('#<%=divtotalitem.ClientID%>').empty();
            divtotalitem.append('Total Request: ' + data.TotalItem)

            if (data.Data.length == 0) {
                EmptyTable(table, 11);
            }
            else {
                for (var i = 0; i < data.Data.length; i++) {
                    var tr = $("<tr>");
                    var td = createCell(data.Data[i].DeviceName);
                    tr.append(td);
                    var td = createCell(data.Data[i].Type);
                    tr.append(td);
                    var td = createCell(data.Data[i].Tag);
                    tr.append(td);
                    var td = createCell(data.Data[i].IMEI);
                    tr.append(td);
                    var td = createCell(data.Data[i].Serial);
                    tr.append(td);
                    var td = createCell(data.Data[i].BorrowDate);
                    tr.append(td);
                    var td = LeaderReject.CurrentStatus(data.Data[i].ConfirmStaus, data.Data[i].Reason);
                    tr.append(td);
                    table.append(tr);
                }
            }
        }
    }

    LeaderReject.Keyword.keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);

        if (keycode == '13') {
            LeaderReject.LoadData();
        }
    });

    LeaderReject.LoadListCategory();
</script>
