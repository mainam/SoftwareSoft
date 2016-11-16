<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctEducation.ascx.cs" Inherits="DeviceManagement.hr.Controls.ctEducation" %>
<div class="jarviswidget jarviswidget-color-greenLight" id="wdEducation" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-edit"></i></span>
        <h2>Education </h2>
        <div class="widget-toolbar" role="menu" runat="server" id="btnAdd">
            <!-- add: non-hidden - to disable auto hide -->
            <div class="btn-group">
                <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="Education.AddEducation();" style="width: 70px;">Add</a>
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
            <table id="tableEducation" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width: 50px;">No</th>
                        <th>Education Level</th>
                        <th>Entered at</th>
                        <th>Graduated at</th>
                        <th>University</th>
                        <th>Major</th>
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
    var Education = {
        ListData: [],
        FindEducation: function (id) {
            for (var i = 0; i < Education.ListData.length; i++) {
                if (Education.ListData[i].ID == id)
                    return Education.ListData[i];
            }
            return null;
        },
        currentid: null,
        AddEducation: function () {
            Education.currentid = null;
            var target = "/hr/dialog/AddEducation.aspx";
            $("#remoteModal").removeData();
            $('#remoteModal').modal({ backdrop: 'static' });
            $("#remoteModal").load(target, function () {
                $("#remoteModal").modal("show");
            });
        },

        LoadData: function () {
            var username = GetQueryStringHash("user");
            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "LoadListEducation", {
                username: username
            }, function (response) {
                if (response.Status) {
                    
                    Education.ShowData(response.Data.Data);
                }
            });
            $("#remoteModal").modal("hide");
        }, ShowData: function (list) {
            
            Education.ListData = list;
            var table = $("#tableEducation > tbody").empty();
            if (list.length == 0)
                EmptyTable(table, 7);
            for (var i = 0; i < list.length; i++) {
                var tr = $("<tr>").attr("dataid", list[i].ID);
                tr.click(function () {
                    if (UserProfilePage.AllowEdit) {
                        tr.addClass("clickable");
                        Education.currentid = $(this).attr("dataid");
                        var target = "/hr/dialog/AddEducation.aspx";
                        $("#remoteModal").removeData();
                        $('#remoteModal').modal({ backdrop: 'static' });
                        $("#remoteModal").load(target, function () {
                            $("#remoteModal").modal("show");
                        });
                    }
                });

                var td = createCell(i + 1);
                tr.append(td);
                var td = createCell(list[i].Education);
                tr.append(td);
                var td = createCell(list[i].Enteredat);
                tr.append(td);
                var td = createCell(list[i].Graduated);
                tr.append(td);
                var td = createCell(list[i].University);
                tr.append(td);
                var td = createCell(list[i].Major);
                tr.append(td);
                var td = $("<td style='text-align:center'>");
                if (UserProfilePage.AllowEdit) {
                    var btn = $("<label class='btn btn-default btn-xs' style='width:21px'>").append($("<i class='fa fa-times'>")).attr("dataid", list[i].ID);
                    btn.click(function (event) {
                        event.stopPropagation();
                        var dataid = $(this).attr("dataid");
                        confirm("Confirm", "Do you want to delele this item", "Delete", "Cancel", function () {
                            var username = GetQueryStringHash("user");
                            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "DelEducation", {
                                username: username,
                                id: dataid
                            }, function (response) {
                                if (response.Status) {                                   
                                    alertSmallBox("Delete education successful", "1 second ago!!", "success");
                                    Education.LoadData();
                                }
                                else {
                                    alertbox("You do not have permission to edit this checklist, please contact ngoc.nam@samsung.com");
                                }
                            });
                            $("#remoteModal").modal("hide");
                        });
                    });
                    td.append(btn);
                }
                tr.append(td);
                table.append(tr);
            }
        }
    };

</script>
