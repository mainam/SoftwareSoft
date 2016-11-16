<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CabinetManagement.aspx.cs" Inherits="DeviceManagement.device.Common.CabinetManagement" %>

<style>
    #dialog-cabinet {
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
    <header style="padding-bottom: 15px;">
        Cabinet Management
                <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 pull-right">
                    <div class="col-md-12" style="padding: 0px;">
                        <div class="icon-addon addon-md">
                            <input id="inputSearchCabinet" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                            <label for="inputSearchCabinet" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                        </div>
                    </div>
                </div>
        <input type="button" value="Add Cabinet" class="btn btn-success pull-right" style="padding: 5px; width: 100px; margin-right: 20px;" onclick="Cabinet.Add();" />
    </header>
    <div style="margin: 10px 14px 0;">
        <div style="min-height: 500px; overflow: auto;">
            <table class="table table-bordered" id="tableCabinet" style="min-width: 1000px;">
                <thead>
                    <tr>
                        <th rowspan="2" style="width: 150px;">Name</th>
                        <th rowspan="2">Location</th>
                        <th rowspan="2" style="width: 100px">Status</th>
                        <th colspan="4">Total Device</th>
                        <th rowspan="2" style="width: 80px;">Action</th>
                    </tr>
                    <tr>
                        <th style="width: 90px">Loss
                        </th>
                        <th style="width: 90px">Broken
                        </th>
                        <th style="width: 90px">Good
                        </th>
                        <th style="width: 90px">Total Device
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div>
            <div id="divtotalitemcabinet" style="float: left; margin-top: 10px; font-weight: bold;">
            </div>

            <div id="divpagingcabinet" style="float: right; margin-top: 10px;">
            </div>
        </div>
        <div id="dialog-cabinet" title="Dialog Add Cabinet">
            <p style="width: 500px;">
                <div class="row smart-form" style="overflow: auto">
                    <table style="margin-left: 40px; width: 480px; line-height: 40px; min-width: 1140px;">
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Name</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-tag"></i>
                                    <input type="text" id="txtName" value="1" />
                                </label>
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Location</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-map-marker"></i>
                                    <input type="text" id="txtLocation" value="1" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Status</label>
                            </td>
                            <td>
                                <%--                                <label class="toggle" style="display: inline;">
                                    <input type="checkbox" name="checkbox-toggle" checked="checked" id="chbStatus" />
                                    <i data-swchon-text="GOOD" data-swchoff-text="BROKEN"></i></label>--%>
                                <span class="onoffswitch" style="width: 70px; margin-left: 10px;">
                                    <input type="checkbox" name="chbStatus" class="onoffswitch-checkbox" id="chbStatus" />
                                    <label class="onoffswitch-label" for="chbStatus">
                                        <span class="onoffswitch-inner" data-swchon-text="GOOD" data-swchoff-text="BROKEN"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
            </p>

        </div>

    </div>
</div>
<script>
    var Cabinet = {
        currentcabinet: null,
        currentpage: 1,
        data: [],

        findCabinet: function (id) {
            for (var i = 0; i < Cabinet.data.length; i++) {
                if (Cabinet.data[i].ID == id)
                    return Cabinet.data[i];
            }
            return null;
        },
        LoadTable: function (listdata) {
            Cabinet.currentcabinet = null;
            Cabinet.data = listdata;
            var target = $('#tableCabinet > tbody').empty();
            if (listdata.length == 0) {
                EmptyTable(target, 7);
            }
            else {
                for (var i = 0; i < listdata.length; i++) {
                    var tr = $('<tr>');
                    var td = createCell(listdata[i].Name);
                    tr.append(td);
                    var td = createCell(listdata[i].Place);
                    tr.append(td);
                    var td = $('<td style="text-align:center">');
                    if (listdata[i].Status) {
                        td.append("GOOD").css("color", "green").css("font-weight", "bold");
                    }
                    else {
                        td.append("BROKEN").css("color", "RED").css("font-weight", "bold");
                    }
                    tr.append(td);
                    var td = createCell(listdata[i].Lost).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Broken).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Good).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Total).css("text-align", "center");
                    tr.append(td);
                    var td = $('<td style="text-align:center">');
                    var btnedit = $('<label class="btn btn-xs btn-default">');
                    btnedit.attr('dataid', listdata[i].ID);
                    btnedit.append($('<i class="fa fa-edit"/>'))
                    btnedit.click(function () {

                        var target = $(this).attr("href");
                        idcabinet = $(this).attr('dataid');
                        var cabinet = Cabinet.findCabinet(idcabinet);
                        if (cabinet != null) {
                            Cabinet.currentcabinet = cabinet;

                            var title = $("div[aria-describedby='dialog-cabinet'] > div > span.ui-dialog-title");
                            if (title.length)
                                title.text("Edit cabinet " + cabinet.Name);
                            $('#txtName').val(cabinet.Name);
                            $('#txtLocation').val(cabinet.Place);
                            $('#chbStatus')[0].checked = cabinet.Status;
                            $("#dialog-cabinet").dialog("open");
                        }
                    });

                    var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
                    btndel.attr('dataid', listdata[i].ID);
                    btndel.append($('<i class="fa fa-times"/>'))
                    btndel.click(function () {
                        Cabinet.currentcabinet = null;
                        var idcabinet = $(this).attr('dataid');
                        var cabinet = Cabinet.findCabinet(idcabinet);
                        if (cabinet != null) {
                            var callback = function () {
                                AJAXFunction.CallAjax("POST", "/device/common/cabinetmanagement.aspx", "Delete", {
                                    id: idcabinet
                                },
                                function (response) {
                                    if (response.Status) {
                                        alertSmallBox("Delete  <b>" + cabinet.Name + "</b> seccessful!", "1 second ago!!", "success");
                                        Cabinet.LoadData(Cabinet.currentpage);
                                    }
                                    else {
                                        alertSmallBox("Delete cabinet <b>" + cabinet.Name + "</b> failed", "1 second ago!!", "Error");
                                    }
                                });
                            }
                            confirm("Confirm", "Do you want to delete cabinet <b>" + cabinet.Name + "</b>!!", "OK", "Cancel", callback);
                        }
                    });

                    td.append(btnedit);
                    td.append(btndel);
                    tr.append(td);

                    target.append(tr);
                }
            }
        },
        LoadData: function (page) {
            Cabinet.currentpage = page;
            var numberinpage = 10;
        
            AJAXFunction.CallAjax("POST", "/device/common/cabinetmanagement.aspx", "LoadData", {
                keyword: $("#inputSearchCabinet").val(),
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {

                if (obj.Status) {
                    var divtotalitem = $('#divtotalitemcabinet').empty();
                    divtotalitem.append('Total cabinet: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    Cabinet.LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($('#divpagingcabinet'), page, totalpage, Cabinet.LoadData);
                }
            });
        },
        Save: function () {
            if ($('#txtName').val().trim() == "") {
                $('#dialog-cabinet').dialog('close');
                alertbox("Please input name for cabinet", function () {
                    $('#dialog-cabinet').dialog('open');
                });
                return;
            }

            AJAXFunction.CallAjax("POST", "/device/common/cabinetmanagement.aspx", "Save", {
                id: Cabinet.currentcabinet == null ? 0 : Cabinet.currentcabinet.ID,
                name: $('#txtName').val(),
                location: $('#txtLocation').val(),
                status: $('#chbStatus')[0].checked
            }, function (obj) {

                if (obj.Status) {
                    Cabinet.currentcabinet = null;
                    alertSmallBox("Save data seccessful!", "1 second ago!!", "success");
                    Cabinet.LoadData(Cabinet.currentpage);
                    $('#dialog-cabinet').dialog("close");
                }
                else {
                    alertSmallBox("Save data failed", "1 second ago!!", "Error");
                }
            });
        },
        Add: function () {
            Cabinet.currentcabinet = null;
            $('#txtName').val("");
            $('#txtLocation').val("");
            $('#chbStatus')[0].checked = true;
            $('#dialog-cabinet').dialog("open");
        }

    }

    $(document).ready(function () {
        Cabinet.LoadData(1);

    });

    $('#inputSearchCabinet').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            Cabinet.LoadData(1);
        }
    });
    $("#dialog-cabinet").dialog({
        autoOpen: false,
        resizable: false,
        width: 600,
        modal: true,
        title: "Add Cabinet",
        buttons: [
            {
                html: "OK",
                width: 80,
                "class": "btn btn-primary",
                click: function () {
                    Cabinet.Save();
                }
            },
            {
                html: "CANCEL",
                width: 80,
                "class": "btn btn-default",
                click: function () {
                    $(this).dialog("close");
                }
            }]

    });

</script>
