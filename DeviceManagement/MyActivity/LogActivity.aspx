<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogActivity.aspx.cs" Inherits="DeviceManagement.MyActivity.LogActivity" %>

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
                var td = createCell(++index);
                tr.append(td);
                var td = createCell(list[i].IP);
                tr.append(td);
                var td = createCell(list[i].UserName);
                tr.append(td);
                var td = createCell(list[i].Time);
                tr.append(td);
                var td = createCell(list[i].Status);
                tr.append(td);
                divitem.append(tr);
            }
        },
        LoadData: function (page) {
            LoginSystem.currentpage = page;
            AJAXFunction.CallAjax("POST", "/MyActivity/LogActivity.aspx", "LoadData", {
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
        <h1 class="page-title txt-color-blueDark"><i class="fa fa-fw fa-clock-o"></i>Log Access System</h1>
    </div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 pull-right" style="margin-bottom: 5px;">
            <div class="col-md-12" style="padding: 0px;">
                <div class="icon-addon addon-md">
                    <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
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
                    <h2>Log Access System </h2>
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

                        <div>
                            <table id="tbLog" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">No</th>
                                        <th style="width: 100px">IP</th>
                                        <th style="width: 100px">UserName</th>
                                        <th style="width: 180px">Date</th>
                                        <th style="text-align: left !important">Status</th>
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
