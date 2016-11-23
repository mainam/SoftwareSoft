<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetupDataConfig.aspx.cs" Inherits="SoftwareStore.Admin.Config.SetupDataConfig" %>

<section id="widget-grid" class="">

    <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
        <div class="alert alert-info alert-block">
            <h4 class="alert-heading">Config web site</h4>
        </div>
    </div>

    <div class="row" style="margin-bottom: 5px;">
        <article class="col-xs-12 col-sm-6 col-md-6 col-lg-6 sortable-grid ui-sortable">
            <div class="btn-group">
                <input class="btn btn-primary" type="button" value="Delete" style="margin-left: 10px; width: 95px" onclick="SetupDataConfig.Delete();" />
            </div>
        </article>


        <article class="col-xs-12 col-sm-6 col-md-6 col-lg-6 sortable-grid ui-sortable pull-right">
            <div class="col-md-6" style="padding: 0px;">
                <select runat="server" id="cbListTypeEnumSearch" class="select2">
                </select>
            </div>
            <div class="col-md-6" style="padding: 0px;">

                <div class="icon-addon addon-md">
                    <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                    <label for="inputSearch" class="glyphicon glyphicon-search"></label>
                </div>
            </div>
        </article>
    </div>

    <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget  jarviswidget-color-teal" id="divListUserSetupDataConfig" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <span class="widget-icon"><i class="fa fa-table"></i></span>
                    <h2>Config web site</h2>
                    <div class="widget-toolbar" role="menu">
                        <!-- add: non-hidden - to disable auto hide -->
                        <div class="btn-group">
                            <input type="button" class="btn dropdown-toggle btn-xs btn-success btnwidth" value="Add" style="margin-right: 10px;" onclick="SetupDataConfig.Add();" />
                        </div>
                    </div>
                </header>
                <!-- widget div-->

                <div>

                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->

                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body smart-form">
                        <div style="min-height: 500px; overflow: auto;">
                            <table class="table table-striped table-bordered table-hover" id="listmember">
                                <thead>
                                    <tr>
                                        <th>
                                            <label class="checkbox">
                                                <input type="checkbox" id="btncheck"><i></i></label></th>
                                        <th>Data keyword</th>
                                        <th>Data value</th>
                                        <th>Apply Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
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
<script>
    pageSetUp();
    $("#<%=cbListTypeEnumSearch.ClientID%>").change(function () {
        SetupDataConfig.LoadData(1);
    });

    $("#btncheck").change(function () {
        var listcheckbox = $('input[typecheckbox="checkboxuser"]');
        var checked = this.checked;
        if (listcheckbox.length > 0) {
            for (var i = 0; i < listcheckbox.length; i++) {
                var item = listcheckbox[i];
                item.checked = checked;
            };
        }
    });
    var SetupDataConfig = {
        currentpage: 1,
        numberinpage: 10,
        datakey: "",
        keyword: "",
        currentid: 0,
        currentkey: "",
        currentval: "",
        Delete: function () {
            var listcheckbox = $('input[typecheckbox="checkboxuser"]:checked');
            if (listcheckbox.length == 0) {
                alertSmallBox("Please select one or more items to remove", "", "error");
                return;
            }
            else {
                confirm("Confirmation!", "Do you want to remove list items has selected", "OK", "Cancel", function () {
                    var listid = [];
                    for (var i = 0; i < listcheckbox.length; i++) {
                        listid.push($(listcheckbox[i]).attr("dataid"));
                    }

                    AJAXFunction.CallAjax("POST", "/admin/config/SetupDataConfig.aspx", "DeleteMultipleID", { ListID: listid }, function (response) {
                        if (response.Status) {
                            alertSmallBox("Remove successful", "", "success");
                            SetupDataConfig.LoadData(SetupDataConfig.currentpage);
                        }
                        else {
                            alertSmallBox("Remove failed", "", "error");
                        }
                    });

                });
            }

        },
        Add: function () {
            SetupDataConfig.currentid = 0;
            AJAXFunction.ShowModal("remoteModal2", "/admin/config/dialog/AddDataConfig.aspx");
        },
        ShowData: function (list) {
            var table = $("#listmember > tbody").empty();
            list.forEach(function (item) {
                var tr = $("<tr>");

                var td = createCellCheckBox(item.UserName, false, false, "checkboxuser");
                tr.append(td);
                var td = createCell(item.DataKey).attr("dataid", item.ID);
                tr.append(td);
                var td = createCell(item.DataValue);
                tr.append(td);
                var td = createCell(item.ApplyDate);
                tr.append(td);
                var td = $("<td>");
                var label = $("<label class='btn btn-xs btn-danger fa fa-times' title='remove'>").attr("dataid", item.ID);
                label.click(function () {
                    var data = $(this).attr("dataid");
                    confirm("Confirmation!", "Do you want to remove this item", "OK", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/admin/config/SetupDataConfig.aspx", "Delete", { id: data }, function (response) {
                            if (response.Status) {
                                alertSmallBox("Remove successful", "", "success");
                                SetupDataConfig.LoadData(SetupDataConfig.currentpage);
                                SetupDataConfig.currentid = 0;
                            }
                            else {
                                alertSmallBox("Remove failed", "", "error");
                            }
                        });
                    });
                });
                td.append(label);
                var label = $("<label class='btn btn-xs btn-primary fa fa-edit' title='edit' style='margin-left: 5px;'>").attr("dataid", item.ID).attr("datavalue", item.DataValue).attr("datakey", item.DataKey);
                label.click(function () {
                    SetupDataConfig.currentid = $(this).attr("dataid");
                    SetupDataConfig.currentkey = $(this).attr("datakey");
                    SetupDataConfig.currentval = $(this).attr("datavalue");
                    AJAXFunction.ShowModal("remoteModal2", "/admin/config/dialog/AddDataConfig.aspx");
                });
                td.append(label);
                tr.append(td);
                table.append(tr);
            });
        },
        LoadData: function (page) {
            SetupDataConfig.currentpage = page;
            AJAXFunction.CallAjax("POST", "/admin/config/SetupDataConfig.aspx", "LoadData", { datakey: $("#<%=cbListTypeEnumSearch.ClientID%>").val(), keyword: SetupDataConfig.keyword, numberinpage: SetupDataConfig.numberinpage, currentpage: SetupDataConfig.currentpage }, function (response) {
                if (response.Status) {
                    SetupDataConfig.ShowData(response.Data);
                    var divtotalitem = $('#divtotalitem').empty();
                    divtotalitem.append('Total Item: ' + response.TotalItem);
                    var totalpage = Common.GetTotalPage(SetupDataConfig.numberinpage, response.TotalItem);
                    AJAXFunction.CreatePaging($("#divpaging"), SetupDataConfig.currentpage, totalpage, SetupDataConfig.LoadData);
                }
            });
        }
    }
    SetupDataConfig.LoadData(1);

    $('#inputSearch').keydown(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            setTimeout(function () {
                SetupDataConfig.keyword = $('#inputSearch').val();
                SetupDataConfig.LoadData(1);
            });
        }
    });
</script>
