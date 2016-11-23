<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogTransferDevice.aspx.cs" Inherits="SoftwareStore.Admin.Log.LogTransferDevice" %>

<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script>
    pageSetUp();
    $('#<%=inputSearch.ClientID%>').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            LoginSystem.LoadData(1);
        }
    });
    var LoginSystem = {
        ListData: [],
        currentpage: 1,
        numberinpage: 10,
        ShowData: function (list, index) {
            var divitem = $('#tbLog > tbody').empty();
            for (var i = 0; i < list.length; i++) {
                var tr = $("<tr>");
                var td = createCellCheckBox(list[i].ID, false, false, "checkboxitem");
                tr.append(td);
                var td = createCell(++index);
                tr.append(td);
                var td = createCell(list[i].Model);
                tr.append(td);
                var td = createCell(list[i].Tag);
                tr.append(td);
                var td = createCell(list[i].IMEI);
                tr.append(td);
                var td = createCell(list[i].Serial);
                tr.append(td);
                var td = createCell(list[i].Manager);
                tr.append(td);
                var td = createCell(list[i].Borrower);
                tr.append(td);
                var td = createCell(list[i].Keeper);
                tr.append(td);
                var td = createCell(list[i].StatusDevice);
                tr.append(td);
                var td = createCell(list[i].Type);
                tr.append(td);
                var td = createCell(list[i].Time);
                tr.append(td);

                var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">').attr("dataid", list[i].Id);
                btndel.append($('<i class="fa  fa-times "/>'))
                btndel.click(function () {
                    var listdel = [];
                    listdel.push($(this).attr("dataid"));
                    confirm("Confirmation!", "Do you want to remove this log", "Remove", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/Admin/Log/LogTransferDevice.aspx", "Delete", { ListID: listdel }, function (response) {
                            if (response.Status) {
                                alertSmallBox("Delete success", "", "success");
                                LoginSystem.LoadData(LoginSystem.currentpage);
                            }
                            else {
                                alertSmallBox("Delete failed", "", "error");
                            }

                        });
                    });
                });
                var td = $("<td>").append(btndel);
                tr.append(td);

                divitem.append(tr);
            }
        },
        LoadData: function (page) {
            LoginSystem.currentpage = page;
            AJAXFunction.CallAjax("POST", "/Admin/Log/LogTransferDevice.aspx", "LoadData", {
                keyword: $('#<%=inputSearch.ClientID%>').val(),
                page: LoginSystem.currentpage,
                numberinpage: LoginSystem.numberinpage
            }, function (obj) {
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitem').empty();
                    LoginSystem.ListData = obj.Data;
                    divtotalitem.append('Total Item: ' + obj.TotalItem)
                    LoginSystem.ShowData(LoginSystem.ListData, (LoginSystem.currentpage - 1) * LoginSystem.numberinpage);
                    var _totalpage = Math.round(obj.TotalItem / LoginSystem.numberinpage);
                    var totalpage = ((obj.TotalItem / LoginSystem.numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    AJAXFunction.CreatePaging($("#divpaging"), LoginSystem.currentpage, totalpage, LoginSystem.LoadData);

                }
                else {
                    alertbox("Can't load data in this time");
                }
            });
        },


        ShowNumberItem: function (numberitem) {
            $("#btnSelectnumberitem").empty().append("Show: " + numberitem).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            LoginSystem.numberinpage = numberitem;
            LoginSystem.LoadData(1);
        },
        Delete: function () {
            input = $('#tbLog > tbody').find('input[typecheckbox="checkboxitem"]:checked');
            if (input.length == 0) {
                alertbox("Please choose item want to remove");
                return;
            }

            confirm("Confirmation!", "Do you want to remove " + input.length + " item", "Yes, I want", "No", function () {
                var listid = [];
                for (var i = 0; i < input.length; i++) {
                    listid.push($(input[i]).attr("dataid"));
                }
                AJAXFunction.CallAjax("POST", "/Admin/Log/LogTransferDevice.aspx", "Delete", { ListID: listid }, function (response) {
                    if (response.Status) {
                        alertSmallBox("Delete success", "", "success");
                        LoginSystem.LoadData(LoginSystem.currentpage);
                    }
                    else {
                        alertSmallBox("Delete failed", "", "error");
                    }
                });
            });
        }

    }

        $(document).ready(function () {
            LoginSystem.LoadData(1);
        });

        $('#btncheck').click(function () {

            input = $('#tbLog > tbody').find('input[typecheckbox="checkboxitem"][disabled!="disabled"]');
            if (this.checked) {
                for (var i = 0; i < input.length; i++)
                    input[i].checked = true;
            }
            else {
                for (var i = 0; i < input.length; i++)
                    input[i].checked = false;
            }
        });
</script>
<div class="row">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark"><i class="fa fa-fw fa-clock-o"></i>Log Transfer Device</h1>
    </div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 pull-right" style="margin-bottom: 5px;">
            <div class="col-md-12" style="padding: 0px;">
                <div class="icon-addon addon-md">
                    <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" data-html="true" rel="popover-hover" data-placement="top" data-original-title="Help" data-content="you can use the following format to search: <br>keyword1 | keyword2 | keywork3 ... <br> and <b> input 'model:model name' to search by model" />
                    <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                </div>
            </div>
        </article>

    </div>
    <div class="row">
        <article class="col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-pink" id="task_content" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">
                <header>
                    <span class="widget-icon"><i class="fa fa-clock-o"></i></span>
                    <h2>Log Transfer Device</h2>
                    <div class="widget-toolbar" role="menu">
                        <div class="btn-group">
                            <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectnumberitem" style="width: 100px;">Show: 10<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                            <ul class="dropdown-menu pull-right js-status-update">
                                <li>
                                    <a href="javascript:void(0);" onclick="LoginSystem.ShowNumberItem(5);">5</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="LoginSystem.ShowNumberItem(10);">10</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="LoginSystem.ShowNumberItem(15);">15</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="LoginSystem.ShowNumberItem(20);">20</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="LoginSystem.ShowNumberItem(50);">50</a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" onclick="LoginSystem.ShowNumberItem(100);">100</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </header>

                <div>

                    <div class="jarviswidget-editbox">
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body padding smart-form">
                        <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="LoginSystem.Delete(); ">Delete</div>

                        <div style="overflow: auto; width: 100%;">
                            <table id="tbLog" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0" style="min-width: 1900px;">
                                <thead>
                                    <tr>
                                        <th class="theadtable" style="width: 20px">
                                            <label class="checkbox">
                                                <input type="checkbox" id="btncheck" /><i style="margin-top: -3px;"></i>
                                            </label>
                                        </th>
                                        <th style="width: 30px;">No</th>
                                        <th style="width: 150px">Model</th>
                                        <th style="width: 50px">Tag</th>
                                        <th style="width: 180px">IMEI</th>
                                        <th style="width: 180px">Serial</th>
                                        <th style="width: 100px">Manager</th>
                                        <th style="width: 100px">Borrower</th>
                                        <th style="width: 100px">Keeper</th>
                                        <th style="width: 100px">Status Device</th>
                                        <th style="width: 150px">Type Transfer</th>
                                        <th style="width: 150px">Transfer Date</th>
                                        <th style="text-align: left !important">Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
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
            </div>

        </article>

    </div>



</section>
