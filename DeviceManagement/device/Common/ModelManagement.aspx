<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModelManagement.aspx.cs" Inherits="DeviceManagement.device.Common.ModelManagement" %>

<style>
    #dialog-model {
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
        Model Management
        <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 pull-right">
            <div class="col-md-12" style="padding: 0px;">
                <div class="icon-addon addon-md">
                    <input id="inputSearchModel" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                    <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                </div>
            </div>
        </div>
        <input type="button" value="Add Model" class="btn btn-success pull-right" style="padding: 5px; width: 100px; margin-right: 20px;" onclick="Model.Add();" />

    </header>
    <div style="margin: 10px 14px 0;">
        <div style="min-height: 500px; overflow: auto">
            <table class="table table-bordered" id="tableModel" style="min-width: 1150px;">
                <thead>
                    <tr>
                        <th rowspan="2" style="width: 150px;">Name</th>
                        <th rowspan="2">Category</th>
                        <th rowspan="2" style="width: 100px">Company</th>
                        <th colspan="5">Total Device</th>
                        <th rowspan="2" style="width: 80px;">Action</th>
                    </tr>
                    <tr>
                        <th style="width: 90px">Loss
                        </th>
                        <th style="width: 90px">Broken
                        </th>
                        <th style="width: 90px">Available
                        </th>
                        <th style="width: 90px">Borrowed
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
            <div id="divtotalitemmodel" style="float: left; margin-top: 10px; font-weight: bold;">
            </div>

            <div id="divpagingmodel" style="float: right; margin-top: 10px;">
            </div>
        </div>
        <div id="dialog-model" title="Dialog Add Model">
            <p style="width: 500px;">
                <div class="row smart-form">
                    <table style="margin-left: 40px; width: 480px; line-height: 40px;">
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Name</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-tag"></i>
                                    <input type="text" id="txtModelName" value="1" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Category</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-tag"></i>
                                    <select class="select2" id="cbCategory" runat="server" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; width: 100px !important;">
                                <label class="labelform">Company</label>
                            </td>
                            <td>
                                <label class="input" style="display: inline-block; margin-left: 10px; width: 100%;">
                                    <i class="icon-append fa fa-map-marker"></i>
                                    <input type="text" id="txtCompany" value="1" />
                                </label>
                            </td>
                        </tr>

                    </table>
                </div>
            </p>

        </div>

    </div>
</div>
<script>
    pageSetUp();
    var Model = {
        currentmodel: null,
        currentpage: 1,
        data: [],

        findModel: function (id) {
            for (var i = 0; i < Model.data.length; i++) {
                if (Model.data[i].ModelName == id)
                    return Model.data[i];
            }
            return null;
        },
        LoadTable: function (listdata) {
            Model.currentmodel = null;
            Model.data = listdata;
            var target = $('#tableModel > tbody').empty();
            if (listdata.length == 0) {
                EmptyTable(target, 9);
            }
            else {
                for (var i = 0; i < listdata.length; i++) {
                    var tr = $('<tr>');
                    var td = createCell(listdata[i].ModelName);
                    tr.append(td);
                    var td = createCell(listdata[i].Name);
                    tr.append(td);
                    var td = createCell(listdata[i].Company);
                    tr.append(td);
                    var td = createCell(listdata[i].Lost).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Broken).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Available).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Borrowed).css("text-align", "center");
                    tr.append(td);
                    var td = createCell(listdata[i].Total).css("text-align", "center");
                    tr.append(td);
                    var td = $('<td style="text-align:center">');
                    var btnedit = $('<label class="btn btn-xs btn-default">');
                    btnedit.attr('dataid', listdata[i].ModelName);
                    btnedit.append($('<i class="fa fa-edit"/>'))
                    btnedit.click(function () {
                        var target = $(this).attr("href");
                        idmodel = $(this).attr('dataid');
                        var model = Model.findModel(idmodel);
                        if (model != null) {
                            Model.currentmodel = model;

                            var title = $("div[aria-describedby='dialog-model'] > div > span.ui-dialog-title");
                            if (title.length)
                                title.text("Edit model " + model.ModelName);
                            $('#txtModelName').val(model.ModelName);
                            $('#txtCompany').val(model.Company);
                            $('#cbCategory').val(model.Category);
                            $(".select2-chosen").text(model.Name);
                            $("#dialog-model").dialog("open");
                        }
                    });

                    var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
                    btndel.attr('dataid', listdata[i].ModelName);
                    btndel.append($('<i class="fa fa-times"/>'))
                    btndel.click(function () {
                        Model.currentmodel = null;
                        var idmodel = $(this).attr('dataid');
                        var model = Model.findModel(idmodel);
                        if (model != null) {
                            var callback = function () {
                                AJAXFunction.CallAjax("POST", "/device/common/modelmanagement.aspx", "Delete", {
                                    modelname: idmodel
                                },
                                function (response) {
                                    if (response.Status) {
                                        alertSmallBox("Delete  <b>" + model.Name + "</b> seccessful!", "1 second ago!!", "success");
                                        Model.LoadData(Model.currentpage);
                                    }
                                    else {
                                        alertSmallBox("Delete model <b>" + model.Name + "</b> failed", "1 second ago!!", "Error");
                                    }
                                });
                            }
                            confirm("Confirm", "Do you want to delete model <b>" + model.ModelName + "</b>!!", "OK", "Cancel", callback);
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
            Model.currentpage = page;
            var numberinpage = 10;
            
            AJAXFunction.CallAjax("POST", "/device/common/modelmanagement.aspx", "LoadData", {
                keyword: $("#inputSearchModel").val(),
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {

                if (obj.Status) {
                    var divtotalitem = $('#divtotalitemmodel').empty();
                    divtotalitem.append('Total model: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    Model.LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($('#divpagingmodel'), page, totalpage, Model.LoadData);
                }
            });
        },
        Save: function () {
            if ($('#txtModelName').val().trim() == "") {
                $('#dialog-model').dialog('close');
                alertbox("Please input model name", function () {
                    $('#dialog-model').dialog('open');
                });
                return;
            }
            if ($('#cbCategory').val().trim() == "") {
                $('#dialog-model').dialog('close');
                alertbox("Please select category", function () {
                    $('#dialog-model').dialog('open');
                });
                return;
            }
            AJAXFunction.CallAjax("POST", "/device/common/modelmanagement.aspx", "Save", {
                id: Model.currentmodel == null ? 0 : Model.currentmodel.ID,
                oldmodelname: Model.currentmodel == null ? "" : Model.currentmodel.ModelName,
                newmodelname: $('#txtModelName').val(),
                category: $('#cbCategory').val(),
                company: $('#txtCompany').val()
            }, function (obj) {

                if (obj.Status) {
                    Model.currentmodel = null;
                    alertSmallBox("Save data seccessful!", "1 second ago!!", "success");
                    Model.LoadData(Model.currentpage);
                    $('#dialog-model').dialog("close");
                }
                else {
                    alertSmallBox("Save data failed", "1 second ago!!", "Error");
                }
            });
        },
        Add: function () {
            Model.currentmodel = null;
            $('#txtModelName').val("");
            $('#txtCompany').val("");
            $('#dialog-model').dialog("open");
        }

    }

    $(document).ready(function () {
        Model.LoadData(1);
    });

    $('#inputSearchModel').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            Model.LoadData(1);
        }
    });

    $("#dialog-model").dialog({
        autoOpen: false,
        resizable: false,
        width: 600,
        modal: true,
        title: "Add Model",
        buttons: [
            {
                html: "OK",
                width: 80,
                "class": "btn btn-primary",
                click: function () {
                    Model.Save();
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
