<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctAward.ascx.cs" Inherits="SoftwareStore.hr.Controls.ctAward" %>

<div class="jarviswidget jarviswidget-color-greenLight " id="wdAward" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-edit"></i></span>
        <h2>Award </h2>
        <div class="widget-toolbar" role="menu" runat="server" id="btnAdd">
            <!-- add: non-hidden - to disable auto hide -->
            <div class="btn-group">
                <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="Award.AddAward();" style="width: 70px;">Add</a>
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
        <div class="widget-body no-padding">
            <table id="tableAward" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width: 50px;">No</th>
                        <th>Award</th>
                        <th>Issue Date</th>
                        <th>Reward by</th>
                        <th>Content</th>
                        <th style="width: 50px">Action</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <!-- end widget content -->

    </div>
    <!-- end widget div -->

</div>
<script>
    var Award = {
        ListData: [],
        FindAward: function (id) {
            for (var i = 0; i < Award.ListData.length; i++) {
                if (Award.ListData[i].ID == id)
                    return Award.ListData[i];
            }
            return null;
        },
        currentid: null,
        AddAward: function () {
            if (UserProfilePage.AllowEdit) {
                Award.currentid = null;
                UserProfilePage.TypeAward = "award";
                var target = "/hr/dialog/AddAwardReward.aspx";
                $("#remoteModal").removeData();
                $('#remoteModal').modal({ backdrop: 'static' });
                $("#remoteModal").load(target, function () {
                    $("#remoteModal").modal("show");
                });
            }
        },

        LoadData: function () {
            var username = GetQueryStringHash("user");
            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "LoadListAward", {
                username: username
            }, function (response) {
                if (response.Status) {
                    
                    Award.ShowData(response.Data.Data);
                }
            });
            $("#remoteModal").modal("hide");
        }, ShowData: function (list) {
            
            Award.ListData = list;
            var table = $("#tableAward > tbody").empty();
            if (list.length == 0)
                EmptyTable(table, 7);
            for (var i = 0; i < list.length; i++) {
                var tr = $("<tr>").attr("dataid", list[i].ID);
                if (UserProfilePage.AllowEdit) {
                    tr.addClass("clickable");
                    tr.click(function () {
                        
                        if (UserProfilePage.AllowEdit) {
                            Award.currentid = $(this).attr("dataid");
                            UserProfilePage.TypeAward = "award";
                            var target = "/hr/dialog/AddAwardReward.aspx";
                            $("#remoteModal").removeData();
                            $('#remoteModal').modal({ backdrop: 'static' });
                            $("#remoteModal").load(target, function () {
                                $("#remoteModal").modal("show");
                            });
                        }

                    });
                }

                var td = createCell(i + 1);
                tr.append(td);
                var td = createCell(list[i].Name);
                tr.append(td);
                var td = createCell(list[i].IssueDate);
                tr.append(td);
                var td = createCell(list[i].AwardBy);
                tr.append(td);
                var td = createCell(list[i].Content);
                tr.append(td);
                var td = $("<td style='text-align:center'>");
                if (UserProfilePage.AllowEdit) {
                    var btn = $("<label class='btn btn-default btn-xs' style='width:21px'>").append($("<i class='fa fa-times'>")).attr("dataid", list[i].ID);
                    btn.click(function () {
                        event.stopPropagation();
                        if (!UserProfilePage.AllowEdit) {
                            var dataid = $(this).attr("dataid");
                            confirm("Confirm", "Do you want to delele this item", "Delete", "Cancel", function () {
                                var username = GetQueryStringHash("user");
                                AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "DelAwardReward", {
                                    username: username,
                                    id: dataid
                                }, function (response) {
                                    if (response.Status) {
                                        
                                        alertSmallBox("Delete Award successful", "1 second ago!!", "success");
                                        Award.LoadData();
                                        Award.ShowData(response.Data.Data);
                                    }
                                    else {
                                        alertbox("You do not have permission to edit this checklist, please contact ngoc.nam@samsung.com");
                                    }
                                });
                                $("#remoteModal").modal("hide");
                            });
                        }
                        else {
                            alertbox("You do not have permission to edit this checklist, please contact ngoc.nam@samsung.com");
                        }
                    });
                    td.append(btn);
                }
                tr.append(td);
                table.append(tr);
            }
        }
    };

</script>

