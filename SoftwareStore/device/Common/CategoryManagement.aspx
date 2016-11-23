<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryManagement.aspx.cs" Inherits="DeviceManagement.device.Common.CategoryManagement" %>

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
    <header style="padding-bottom: 15px;">
        Category Management
                <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 pull-right">
                    <div class="col-md-12" style="padding: 0px;">
                        <div class="icon-addon addon-md">
                            <input id="inputSearchCategory" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                            <label for="inputSearchCategory" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                        </div>
                    </div>
                </div>

        <input type="button" value="Add Category" class="btn btn-success pull-right" style="padding: 5px; width: 100px; margin-right: 20px;" onclick="Category.Add();" />
    </header>
    <div style="margin: 10px 14px 0;">
        <div style="min-height: 500px; overflow: auto;">
            <table class="table table-bordered" id="tableCategory" style="min-width: 950px;">
                <thead>
                    <tr>
                        <th rowspan="2">Name</th>
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
            <div id="divtotalitemcategory" style="float: left; margin-top: 10px; font-weight: bold;">
            </div>

            <div id="divpagingcategory" style="float: right; margin-top: 10px;">
            </div>
        </div>
        <div id="dialog-category" title="Dialog Add Category">
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
                                    <input type="text" id="txtNameCategory" value="1" />
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
    var Category = {
        currentcategory: null,
        currentpage: 1,
        data: [],

        findCategory: function (id) {
            for (var i = 0; i < Category.data.length; i++) {
                if (Category.data[i].ID == id)
                    return Category.data[i];
            }
            return null;
        },
        LoadTable: function (listdata) {
            Category.currentcategory = null;
            Category.data = listdata;
            var target = $('#tableCategory > tbody').empty();
            if (listdata.length == 0) {
                EmptyTable(target, 7);
            }
            else {
                for (var i = 0; i < listdata.length; i++) {
                    var tr = $('<tr>');
                    var td = createCell(listdata[i].Name);
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
                    btnedit.attr('dataid', listdata[i].ID);
                    btnedit.append($('<i class="fa fa-edit"/>'))
                    btnedit.click(function () {

                        var target = $(this).attr("href");
                        idcategory = $(this).attr('dataid');
                        var category = Category.findCategory(idcategory);
                        if (category != null) {
                            Category.currentcategory = category;

                            var title = $("div[aria-describedby='dialog-category'] > div > span.ui-dialog-title");
                            if (title.length)
                                title.text("Edit Category " + category.Name);
                            $('#txtNameCategory').val(category.Name);
                            $("#dialog-category").dialog("open");
                        }
                    });

                    var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
                    btndel.attr('dataid', listdata[i].ID);
                    btndel.append($('<i class="fa fa-times"/>'))
                    btndel.click(function () {
                        Category.currentcategory = null;
                        var idcategory = $(this).attr('dataid');
                        var category = Category.findCategory(idcategory);
                        if (category != null) {
                            var callback = function () {
                                AJAXFunction.CallAjax("POST", "/device/common/categorymanagement.aspx", "Delete", {
                                    id: idcategory
                                },
                                function (response) {
                                    if (response.Status) {
                                        alertSmallBox("Delete  <b>" + category.Name + "</b> seccessful!", "1 second ago!!", "success");
                                        Category.LoadData(Category.currentpage);
                                    }
                                    else {
                                        alertSmallBox("Delete category <b>" + category.Name + "</b> failed", "1 second ago!!", "Error");
                                    }
                                });
                            }
                            confirm("Confirm", "Do you want to delete category <b>" + category.Name + "</b>!!", "OK", "Cancel", callback);
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
            Category.currentpage = page;
            var numberinpage = 10;
            
            AJAXFunction.CallAjax("POST", "/device/common/categorymanagement.aspx", "LoadData", {
                keyword: $('#inputSearchCategory').val(),
                currentpage: page,
                numberinpage: numberinpage
            }, function (obj) {

                if (obj.Status) {
                    var divtotalitem = $('#divtotalitemcategory').empty();
                    divtotalitem.append('Total category: ' + obj.TotalItem)
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    Category.LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($('#divpagingcategory'), page, totalpage, Category.LoadData);
                }
            });
        },
        Save: function () {
            if ($('#txtNameCategory').val().trim() == "") {
                $('#dialog-category').dialog('close');
                alertbox("Please input name for category", function () {
                    $('#dialog-category').dialog('open');
                });
                return;
            }
            AJAXFunction.CallAjax("POST", "/device/common/categorymanagement.aspx", "Save", {
                id: Category.currentcategory == null ? 0 : Category.currentcategory.ID,
                name: $('#txtNameCategory').val()
            }, function (obj) {

                if (obj.Status) {
                    Category.currentcategory = null;
                    alertSmallBox("Save data seccessful!", "1 second ago!!", "success");
                    Category.LoadData(Category.currentpage);
                    $('#dialog-category').dialog("close");
                }
                else {
                    alertSmallBox("Save data failed", "1 second ago!!", "Error");
                }
            });
        },
        Add: function () {
            Category.currentcategory = null;
            $('#txtNameCategory').val("");
            $('#dialog-category').dialog("open");
        }

    }

    $(document).ready(function () {
        Category.LoadData(1);
    });

    $('#inputSearchCategory').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            Category.LoadData(1);
        }
    });

    $("#dialog-category").dialog({
        autoOpen: false,
        resizable: false,
        width: 600,
        modal: true,
        title: "Add Category",
        buttons: [
            {
                html: "OK",
                width: 80,
                "class": "btn btn-primary",
                click: function () {
                    Category.Save();
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
