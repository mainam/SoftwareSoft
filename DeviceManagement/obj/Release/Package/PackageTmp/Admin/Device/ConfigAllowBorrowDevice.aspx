<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfigAllowBorrowDevice.aspx.cs" Inherits="DeviceManagement.Admin.Device.ConfigAllowBorrowDevice" %>

<section id="widget-grid" class="">

    <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
        <div class="alert alert-info alert-block">
            <h4 class="alert-heading">Set members allow borrow device</h4>
        </div>
    </div>

    <div class="row" style="margin-bottom: 5px;">
        <article class="col-xs-12 col-sm-6 col-md-6 col-lg-6 sortable-grid ui-sortable">
            <div class="btn-group">
                <input class="btn btn-primary" type="button" value="Delete" style="margin-left: 10px; width: 95px" onclick="AllowBorrowDevice.Delete();" />
            </div>
        </article>


        <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable pull-right">
            <div class="col-md-12" style="padding: 0px;">
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
            <div class="jarviswidget  jarviswidget-color-teal" id="divAllowBorrowDevice" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <span class="widget-icon"><i class="fa fa-table"></i></span>
                    <h2>List of members allow borrow device</h2>
                    <div class="widget-toolbar" role="menu">
                        <!-- add: non-hidden - to disable auto hide -->
                        <div class="btn-group">
                            <input type="button" class="btn dropdown-toggle btn-xs btn-success btnwidth" value="Add" style="margin-right: 10px;" onclick="AllowBorrowDevice.Add();" />
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
                                        <th>SingleID</th>
                                        <th>FullName</th>
                                        <th>JobTitle</th>
                                        <th>Is Team Leader</th>
                                        <th>Group</th>
                                        <th>Part</th>
                                        <th>Apply Date</th>
                                        <th>User Status</th>
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
    var AllowBorrowDevice = {
        currentpage: 1,
        numberinpage: 10,
        keyword: "",
        Delete: function () {
            var listcheckbox = $('input[typecheckbox="checkboxuser"]:checked');
            if (listcheckbox.length == 0) {
                alertSmallBox("Please select one or more user to remove", "", "error");
                return;
            }
            else {
                confirm("Confirmation!", "Do you want to remove list users has selected", "OK", "Cancel", function () {
                    var listuser = [];
                    for (var i = 0; i < listcheckbox.length; i++) {
                        listuser.push($(listcheckbox[i]).attr("dataid"));
                    }
                    AJAXFunction.CallAjax("POST", "/admin/device/configAllowBorrowDevice.aspx", "DeleteMultipleUser", { ListUser: listuser }, function (response) {
                        if (response.Status) {
                            alertSmallBox("Remove successful", "", "success");
                            AllowBorrowDevice.LoadData(AllowBorrowDevice.currentpage);
                        }
                        else {
                            alertSmallBox("Remove failed", "", "error");
                        }
                    });
                });
            }

        },
        Add: function () {
            AJAXFunction.ShowModal("remoteModal2", "/admin/device/dialog/AllowMemberBorrowDevice.aspx")
        },
        ShowData: function (list) {
            var table = $("#listmember > tbody").empty();
            list.forEach(function (item) {
                var tr = $("<tr>");

                var td = createCellCheckBox(item.UserName, false, false, "checkboxuser");
                tr.append(td);
                var td = createCell(item.UserName).attr("dataid", item.UserName);
                td.click(function () {
                    var id = $(this).attr("dataid");
                    AJAXFunction.ShowModal("remoteModal2", "/hr/DialogUserInformation.aspx?user=" + id);
                });
                tr.append(td);
                var td = createCell("").append(Common.ShowSingleStatus(item.UserName, item.FullName));
                tr.append(td);
                var td = createCell(item.JobName);
                tr.append(td);
                var td = createCellTick(item.IsTeamLeader);
                tr.append(td);
                var td = createCell(item.Group);
                tr.append(td);
                var td = createCell(item.Part);
                tr.append(td);
                var td = createCell(item.ApplyDate);
                tr.append(td);
                var td = createCellTick(item.Active);
                tr.append(td);
                var td = $("<td>");
                var label = $("<label class='btn btn-xs btn-danger fa fa-times' title='remove'>").attr("dataid", item.UserName);
                label.click(function () {
                    var data = $(this).attr("dataid");
                    confirm("Confirmation!", "Do you want to remove this item", "OK", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/admin/device/configAllowBorrowDevice.aspx", "Delete", { username: data }, function (response) {
                            if (response.Status) {
                                alertSmallBox("Remove successful", "", "success");
                                AllowBorrowDevice.LoadData(AllowBorrowDevice.currentpage);
                            }
                            else {
                                alertSmallBox("Remove failed", "", "error");
                            }
                        });
                    });
                });
                td.append(label);
                tr.append(td);
                table.append(tr);
            });
        },
        LoadData: function (page) {
            AllowBorrowDevice.currentpage = page;
            AJAXFunction.CallAjax("POST", "/admin/device/configAllowBorrowDevice.aspx", "LoadData", { keyword: AllowBorrowDevice.keyword, numberinpage: AllowBorrowDevice.numberinpage, currentpage: AllowBorrowDevice.currentpage }, function (response) {
                if (response.Status) {
                    AllowBorrowDevice.ShowData(response.Data);
                    var divtotalitem = $('#divtotalitem').empty();
                    divtotalitem.append('Total User: ' + response.TotalItem);
                    var totalpage = Common.GetTotalPage(AllowBorrowDevice.numberinpage, response.TotalItem);
                    AJAXFunction.CreatePaging($("#divpaging"), AllowBorrowDevice.currentpage, totalpage, AllowBorrowDevice.LoadData);
                }
            });
        }
    }
    AllowBorrowDevice.LoadData(1);

    $('#inputSearch').keydown(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            setTimeout(function () {
                AllowBorrowDevice.keyword = $('#inputSearch').val();
                AllowBorrowDevice.LoadData(1);
            });
        }
    });
</script>
