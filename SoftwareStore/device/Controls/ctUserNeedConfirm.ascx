<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctUserNeedConfirm.ascx.cs" Inherits="SoftwareStore.device.Controls.ctUserNeedConfirm" %>

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
            List devices need confirm
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
        <div class="jarviswidget jarviswidget-color-teal" id="needconfirm" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
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
                    <div class="table-responsive smart-form" id="divUserNeedConfirm" style="width: 100%;">
                        <table id="tableUserNeedConfirm" class="table table-striped table-bordered table-hover" style="margin-bottom: 0px; min-width: 1360px;">
                            <thead>
                                <tr>
                                    <th style="width: 20px;"></th>
                                    <th style="width: 130px;">Model</th>
                                    <th style="width: 90px;">Type</th>
                                    <th style="width: 60px;">Tag</th>
                                    <th style="width: 120px;">IMEI</th>
                                    <th style="width: 110px;">Serial</th>
                                    <th style="width: 90px;">Borrow Date</th>
                                    <th style="width: 120px;">Leader Reject</th>
                                    <th style="width: 110px;">Current Confirm</th>
                                    <th style="width: 120px;">Note</th>
                                    <th style="width: 130px;">Confirm</th>
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
                    <label class="btn btn-primary" style="width: 97px; margin-left: 5px;" onclick="UserNeedConfirm.Submit();">Submit</label>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var UserNeedConfirm = {
        Keyword: $("#<%=inputSearchMyRequest.ClientID%>"),
        DllType: $('#<%=ddlType.ClientID%>'),
        LoadData: function () {
            AJAXFunction.CallAjax("POST", "/device/confirmation/userinventorypage.aspx", "ListUserNeedConfirm", {
                type: UserNeedConfirm.DllType.attr("dataid"),
                keyword: UserNeedConfirm.Keyword.val(),
                inventoryid: UserPage.inventoryid
            }, function (response) {
                if (response.Status) {
                    UserNeedConfirm.ShowData(response.Data);
                    pageSetUp();
                }
            });
        },
        Submit: function () {
            var trs = $('#tableUserNeedConfirm').find("tr.trError");
            if (trs.length > 0) {
                alertbox("Please fill data to field if you choose option is not good");
                return;
            }
            var checkboxs = $('#tableUserNeedConfirm').find("input:checked[typecheckbox=itemdevice]");
            if (checkboxs.length == 0) {
                alertbox("Please select the items that you want to submit");
                return;
            }
            confirm("Confirm", "Do you want to submit " + checkboxs.length + " confirmation for your borrowing devices? <br> The information will be send to your leader to approve.", "Submit", "Cancel", function () {
                var listsend = [];
                for (var i = 0; i < checkboxs.length; i++) {
                    var tr = $(checkboxs[i]).parent().parent().parent();
                    var note = tr.find("textarea").val();
                    var confirm = tr.find("select").val();
                    var object = {
                        id: $(checkboxs[i]).attr("dataid"),
                        Reason: note,
                        ConfirmStaus: confirm
                    }
                    listsend.push(object);
                }
                AJAXFunction.CallAjax("POST", "/device/confirmation/userinventorypage.aspx", "Submit", { ListConfirm: listsend }, function (response) {
                    if (response.Status) {
                        alertSmallBox("Confirm device success", "1 second ago", "success");
                        UserPage.LoadData();
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
                UserNeedConfirm.LoadData();
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < UserNeedConfirm.ListType.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(UserNeedConfirm.ListType[i].Name);
                a.attr('dataid', UserNeedConfirm.ListType[i].ID);
                a.click(function () {
                    $('#<%=ddlType.ClientID%>').text($(this).text());
                    $('#<%=ddlType.ClientID%>').attr("dataid", $(this).attr("dataid"));
                    UserNeedConfirm.LoadData();
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
            select.append('<option value="1">Not Borrow</option>')
            select.append('<option value="2">Loss</option>')
            select.append('<option value="3">Broken</option>')
            select.append('<option value="4">Good</option>')
            select.val(4);
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
                if ($(this).val() != 4 && $(this).val() != 0) {
                    if (reason.val().trim() == "") {
                        tr.addClass("trError");
                        UserNeedConfirm.AlertInputReason();
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
                    var a = $('<a href="javascript:void(0);">');
                    a.attr("data-content", leadercomment != "" ? leadercomment : "no input content");
                    a.text(" View Comment");
                    a.click(function () {
                        dialogbox("Reason", $(this).attr("data-content"));
                    });
                    td.append(a);
                }
            }
            return td;
        },
        CurrentStatus: function (currentstatus, reason) {
            var td = $("<td style='vertical-align: middle;'>");
            var status = UserNeedConfirm.GetStatusConfirm(currentstatus);
            var a = $('<a style="text-decoration: none;">');
            //a.attr("title", "Click here to view reason");
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
                            if (dataconfirm.val() == 4)
                                tr.removeClass("trError");
                            else {
                                tr.addClass("trError");
                                UserNeedConfirm.AlertInputReason();
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
                    if (textarea.val().trim() != "" || select.val() == 4) {
                        tr.removeClass("trError");
                    }
                    else {
                        tr.addClass("trError");
                        UserNeedConfirm.AlertInputReason();
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
            var table = $("#tableUserNeedConfirm > tbody").empty();
            var divtotalitem = $('#<%=divtotalitem.ClientID%>').empty();
            divtotalitem.append('Total Request: ' + data.TotalItem)
            //var _totalpage = Math.round(data.TotalItem / numberinpage);
            //var totalpage = ((data.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
            <%--AJAXFunction.CreatePaging($('#<%=divpaging.ClientID%>'), currentpage, totalpage, function (page) {
                confirm("Save Data", "Do you want to submit device has confirmed. If you click to Cancel, data will not save", "Save", "Cancel", function () {
                    alertbox("OK");
                });
                //                MyRequest.LoadData(page);
            });--%>

            if (data.Data.length == 0) {
                EmptyTable(table, 11);
            }
            else {
                for (var i = 0; i < data.Data.length; i++) {
                    var tr = $("<tr>");
                    td = UserNeedConfirm.CreateCheckBox(data.Data[i].id, true);
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
                    var td = createCell(data.Data[i].BorrowDate);
                    tr.append(td);
                    var td = UserNeedConfirm.LeaderStatus(data.Data[i].LeaderConfirmStatus, data.Data[i].LeaderReason);
                    tr.append(td);
                    var td = UserNeedConfirm.CurrentStatus(data.Data[i].ConfirmStaus, data.Data[i].Reason);
                    tr.append(td);
                    var td = UserNeedConfirm.InputReason(data.Data[i].id, 2, "", data.Data[i].Reason);
                    tr.append(td);
                    var td = UserNeedConfirm.CreateCellConfirm(data.Data[i].id, data.Data[i].CurrentStaus);
                    tr.append(td);
                    table.append(tr);
                }
            }
        }
    }

    UserNeedConfirm.Keyword.keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            UserNeedConfirm.LoadData();
        }
    });
    <%-- var MyRequest = {
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
            var keyword = $('#<%=inputSearchMyRequest.ClientID%>').val();
            var divtotalitem = $('#divtotalitemMyRequest').empty();
            var status = (_status == "All") ? 0 : (_status == "Not Confirm") ? 1 : 2;
            AJAXFunction.CallAjax("POST", "/device/confirmation/MyConfirm.aspx", "GetListRequest", {
                keyword: keyword,
                status: status,
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {
                $('#tableUserNeedConfirm').css("min-width", $('#divUserNeedConfirm').width());

                if (obj.Status) {
                    divtotalitem.append('Total Request: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    MyRequest.LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($('#divpagingMyRequest'), page, totalpage, function (page) {
                        MyRequest.LoadData(page);
                    });
                }
            });
        }
    }
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

    MyRequest.LoadData(1);
    --%>
    UserNeedConfirm.LoadListCategory();
</script>
