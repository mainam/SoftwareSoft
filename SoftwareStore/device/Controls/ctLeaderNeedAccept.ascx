<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctLeaderNeedAccept.ascx.cs" Inherits="SoftwareStore.device.Controls.ctLeaderNeedAccept" %>

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
            List devices need to approve
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
                <input id="inputSearchMyRequest" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                <label for="inputSearchMyRequest" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
            </div>
        </div>
    </div>


    <!-- NEW WIDGET START -->
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 5px;">

        <!-- Widget ID (each widget will need unique ID)-->
        <div class="jarviswidget jarviswidget-color-teal" id="needapprove" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
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
                    <div class="table-responsive smart-form" id="divLeaderNeedApprove" style="width: 100%;">

                        <table id="tableLeaderNeedApprove" class="table table-striped table-bordered table-hover" style="margin-bottom: 0px; min-width: 1350px;">
                            <thead>
                                <tr>
                                    <th style="width: 20px;"></th>
                                    <th style="width: 150px;">Model</th>
                                    <th style="width: 90px;">Type</th>
                                    <th style="width: 80px;">Tag</th>
                                    <th style="width: 120px;">IMEI</th>
                                    <th style="width: 120px;">Serial</th>
                                    <th style="width: 120px;">Borrower</th>
                                    <th style="width: 90px;">Borrow Date</th>
                                    <th style="width: 80px;">Confirm</th>
                                    <th style="width: 110px;">Comment</th>
                                    <th style="width: 120px;">Note</th>
                                    <th style="width: 130px;">Approve</th>
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
                <div class="pull-right">
                    <label class="btn btn-primary" style="width: 97px; margin-left: 5px;" onclick="LeaderNeedApprove.Submit();">Submit</label>

                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var LeaderNeedApprove = {
        Keyword: $("#<%=inputSearchMyRequest.ClientID%>"),
        DllType: $('#<%=ddlType.ClientID%>'),
        LoadData: function () {
            AJAXFunction.CallAjax("POST", "/device/confirmation/leaderinventorypage.aspx", "ListLeaderNeedApprove", {
                type: LeaderNeedApprove.DllType.attr("dataid"),
                keyword: LeaderNeedApprove.Keyword.val(),
                inventoryid: LeaderPage.inventoryid
            }, function (response) {
                if (response.Status) {
                    LeaderNeedApprove.ShowData(response.Data);
                    pageSetUp();
                }
            });
        },
        Submit: function () {

            var trs = $('#tableLeaderNeedApprove').find("tr.trError");
            if (trs.length > 0) {
                alertbox("Please fill data to field if you choose option reject");
                return;
            }
            var checkboxs = $('#tableLeaderNeedApprove').find("input:checked[typecheckbox=itemdevice]");
            if (checkboxs.length == 0) {
                alertbox("Please select the items that you want to submit");
                return;
            }
            confirm("Confirm", "Do you want to submit " + checkboxs.length + " item selected", "Submit", "Cancel", function () {
                var listsend = [];
                for (var i = 0; i < checkboxs.length; i++) {
                    var tr = $(checkboxs[i]).parent().parent().parent();
                    var note = tr.find("textarea").val();
                    var confirm = tr.find("select").val();
                    var object = {
                        id: $(checkboxs[i]).attr("dataid"),
                        LeaderReason: note,
                        LeaderConfirmStatus: confirm
                    }
                    listsend.push(object);
                }
                AJAXFunction.CallAjax("POST", "/device/confirmation/leaderinventorypage.aspx", "Submit", { ListConfirm: listsend }, function (response) {

                    if (response.Status) {
                        alertSmallBox("Confirm device success", "1 second ago", "success");
                        LeaderPage.LoadData();
                    }
                    else
                        alertSmallBox("Confirm device failed", "1 second ago", "error");
                });
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
                LeaderNeedApprove.LoadData();
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < LeaderNeedApprove.ListType.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(LeaderNeedApprove.ListType[i].Name);
                a.attr('dataid', LeaderNeedApprove.ListType[i].ID);
                a.click(function () {
                    $('#<%=ddlType.ClientID%>').text($(this).text());
                    $('#<%=ddlType.ClientID%>').attr("dataid", $(this).attr("dataid"));
                    LeaderNeedApprove.LoadData();
                });
                ul.append($('<li>').append(a));
            }
        },

        AlertInputReason: function () {
            alertSmallBox("Error", "Please input reason if you choose option not good", "Error");
        },
        CreateCellConfirm: function (id, currentstatus) {
            var select = $('<select class="select2">');
            select.attr('dataid', id);
            select.append('<option value="0">Not Confirm</option>')
            select.append('<option value="1">Accept</option>')
            select.append('<option value="2">Reject</option>')
            select.val(1);
            select.change(function () {

                var tr = $(this).parent().parent();
                var reason = tr.find("textarea[dataid=" + $(this).attr("dataid") + "]");
                var checkbox = tr.find("input[type=checkbox][dataid=" + $(this).attr("dataid") + "]");
                if ($(this).val() != 0) {
                    checkbox[0].checked = true;
                    checkbox.removeAttr("disabled");
                }
                else {
                    checkbox[0].checked = false;
                    checkbox.attr("disabled", "disabled");
                }
                if ($(this).val() != 1 && $(this).val() != 0) {
                    if (reason.val().trim() == "") {
                        tr.addClass("trError");
                        LeaderNeedApprove.AlertInputReason();
                    }
                    else {
                        checkbox[0].checked = true;
                    }
                }
                else {
                    tr.removeClass("trError");
                }
            });
            var td = $('<td  style="vertical-align: middle;">');
            td.append(select);
            return td;
        },
        LeaderStatus: function (leaderstatus, leadercomment) {
            var td = $("<td style='color: red; vertical-align: middle;'>");
            if (leaderstatus == 2) {
                td.append("<i class='fa fa-lg fa-times-circle'></i>");
                if (leadercomment.trim() != "") {
                    //<a href='#'>View Comment</a>
                    var a = $('<a href="javascript:void(0);" rel="popover" data-placement="left">');
                    a.attr("data-original-title", "<b style='color:black'>Leader Comment</b>");
                    a.attr("data-content", leadercomment);
                    a.attr("data-html", "true");
                    a.text(" View Comment");
                    td.append(a);
                }
            }
            return td;
        },
        CurrentStatus: function (currentstatus, reason) {
            var td = $("<td style='vertical-align: middle;'>");
            var status = LeaderNeedApprove.GetStatusConfirm(currentstatus);
            var a = $('<a style="text-decoration: none;">');
            //a.attr("title", "Click here to view reason");
            a.text(status);
            a.attr("href", "javascript:void(0);");
            a.attr("data-content", reason != "" ? reason : "no input content");
            a.click(function () {
                dialogbox("Reason", $(this).attr("data-content"));
            });
            td.append(a); return td;
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
        InputReason: function (id, numrow, placeholder, value) {
            var label = $('<label class="textarea">');
            var textarea = $('<textarea  name="info"  style = "width:100%">');
            textarea.attr('dataid', id);
            textarea.attr('rows', numrow);
            textarea.attr('placeholder', placeholder);
            textarea.attr('texttype', "reasonconfirm");
            textarea.val(value);

            textarea.blur(function () {

                var tr = $(this).parent().parent().parent();
                var dataconfirm = tr.find("select[dataid=" + $(this).attr("dataid") + "]");
                var checkbox = tr.find("input[type=checkbox][dataid=" + $(this).attr("dataid") + "]");

                if ($(this).val().trim() == "") {
                    if (dataconfirm.val() == 0) {
                        tr.removeClass("trError");
                    }
                    else {
                        if (checkbox[0].checked) {
                            if (dataconfirm.val() == 1)
                                tr.removeClass("trError");
                            else {
                                tr.addClass("trError");
                                LeaderNeedApprove.AlertInputReason();
                            }
                        }
                    }
                }
                else {
                    tr.removeClass("trError");
                }
            });

            var td = $('<td>');
            label.append(textarea);
            td.append(label);
            return td;
        },
        CreateCheckBox: function (id, check) {
            var td = $('<td style="vertical-align: middle;">');
            var label = $('<label class="checkbox">');
            var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemdevice">');
            if (check) {
                checkbox.attr("checked", "checked");
            }
            checkbox.attr('dataid', id);
            label.append(checkbox);
            label.append($('<i>'));
            checkbox.click(function () {

                var tr = $(this).parent().parent().parent();
                var textarea = tr.find("textarea[dataid=" + $(this).attr("dataid") + "]");
                var select = tr.find("select[dataid=" + $(this).attr("dataid") + "]");
                if ($(this)[0].checked) {
                    if (textarea.val().trim() != "" || select.val() == 1) {
                        tr.removeClass("trError");
                    }
                    else {
                        tr.addClass("trError");
                        LeaderNeedApprove.AlertInputReason();
                    }
                }
                else {
                    tr.removeClass("trError");
                }
            });
            td.append(label);
            return td;
        },

        ShowData: function (data) {

            var table = $("#tableLeaderNeedApprove > tbody").empty();
            var divtotalitem = $('#<%=divtotalitem.ClientID%>').empty();
            divtotalitem.append('Total Request: ' + data.TotalItem)

            if (data.Data.length == 0) {
                EmptyTable(table, 12);
            }
            else {
                for (var i = 0; i < data.Data.length; i++) {
                    var tr = $("<tr>");
                    td = LeaderNeedApprove.CreateCheckBox(data.Data[i].id, true);
                    tr.append(td);
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
                    var td = createCellName(data.Data[i].Borrower);
                    tr.append(td);
                    var td = createCell(data.Data[i].BorrowDate);
                    tr.append(td);
                    var td = LeaderNeedApprove.CurrentStatus(data.Data[i].ConfirmStaus, data.Data[i].Reason);
                    tr.append(td);
                    var td = createCell(data.Data[i].LeaderReason);
                    tr.append(td);
                    var td = LeaderNeedApprove.InputReason(data.Data[i].id, 2, "", data.Data[i].LeaderReason);
                    tr.append(td);
                    var td = LeaderNeedApprove.CreateCellConfirm(data.Data[i].id, data.Data[i].CurrentStaus);
                    tr.append(td);
                    table.append(tr);
                }
            }
        }
    }

    LeaderNeedApprove.Keyword.keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);

        if (keycode == '13') {
            LeaderNeedApprove.LoadData();
        }
    });

    LeaderNeedApprove.LoadListCategory();


</script>
