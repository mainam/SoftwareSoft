<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctCertification.ascx.cs" Inherits="DeviceManagement.hr.Controls.ctCertification" %>

<div class="jarviswidget jarviswidget-color-greenLight" id="wdCertification" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-edit"></i></span>
        <h2>Certification </h2>
        <div class="widget-toolbar" role="menu" runat="server" id="btnAdd">
            <!-- add: non-hidden - to disable auto hide -->
            <div class="btn-group">
                <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="Certification.AddCertification();" style="width: 70px;">Add</a>
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
            <table id="tableCertification" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width: 50px;">No</th>
                        <th>Certification</th>
                        <th>Grade</th>
                        <th>Issue Date</th>
                        <th>Expiration Date</th>
                        <th>License No.</th>
                        <th>Issued by</th>
                        <th style="width: 50px!important">Action</th>
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
    var Certification = {
        ListData: [],
        FindCertification: function (id) {
            for (var i = 0; i < Certification.ListData.length; i++) {
                if (Certification.ListData[i].ID == id)
                    return Certification.ListData[i];
            }
            return null;
        },
        currentid: null,
        AddCertification: function () {
            if (UserProfilePage.AllowEdit) {
                Certification.currentid = null;
                var target = "/hr/dialog/AddCertification.aspx";
                $("#remoteModal").removeData();
                $('#remoteModal').modal({ backdrop: 'static' });
                $("#remoteModal").load(target, function () {
                    $("#remoteModal").modal("show");
                });
            }
        },
        GetLevelGrade: function (grade) {
            switch (grade) {
                case 1:
                    return "Top Class";
                case 2:
                    return "2nd Grade";
                case 3:
                    return "3rd Grade";
                case 4:
                    return "4th Grade";
                case 5:
                    return "5th Grade";
                case 6:
                    return "6th Grade";
                case 7:
                    return "7th Grade";
                case 8:
                    return "8th Grade";
                default: return "No Grade";
            }
        },
        LoadData: function () {
            var username = GetQueryStringHash("user");
            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "LoadListCertification", {
                username: username
            }, function (response) {
                if (response.Status) {
                    
                    Certification.ShowData(response.Data.Data);
                }
            });
            $("#remoteModal").modal("hide");
        }, ShowData: function (list) {
            
            Certification.ListData = list;
            var table = $("#tableCertification > tbody").empty();
            if (list.length == 0)
                EmptyTable(table, 8);
            for (var i = 0; i < list.length; i++) {
                var tr = $("<tr>").attr("dataid", list[i].ID);
                if (UserProfilePage.AllowEdit) {
                    tr.addClass("clickable");
                    tr.click(function () {
                        Certification.currentid = $(this).attr("dataid");
                        var target = "/hr/dialog/AddCertification.aspx";
                        $("#remoteModal").removeData();
                        $('#remoteModal').modal({ backdrop: 'static' });
                        $("#remoteModal").load(target, function () {
                            $("#remoteModal").modal("show");
                        });

                    });
                }

                var td = createCell(i + 1);
                tr.append(td);
                var td = createCell(list[i].Certification);
                tr.append(td);
                var td = createCell(Certification.GetLevelGrade(list[i].Grade));
                tr.append(td);
                var td = createCell(list[i].IssueDate);
                tr.append(td);
                var td = createCell(list[i].Expiration);
                tr.append(td);
                var td = createCell(list[i].LicenseNo);
                tr.append(td);
                var td = createCell(list[i].IssuedBy);
                tr.append(td);
                var td = $("<td style='text-align:center'>");
                if (UserProfilePage.AllowEdit) {
                    var btn = $("<label class='btn btn-default btn-xs' style='width:21px'>").append($("<i class='fa fa-times'>")).attr("dataid", list[i].ID);
                    btn.click(function () {
                        event.stopPropagation();
                        var dataid = $(this).attr("dataid");
                        confirm("Confirm", "Do you want to delele this item", "Delete", "Cancel", function () {
                            var username = GetQueryStringHash("user");
                            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "DelCertification", {
                                username: username,
                                id: dataid
                            }, function (response) {
                                if (response.Status) {
                                    
                                    alertSmallBox("Delete Certification successful", "1 second ago!!", "success");
                                    Certification.LoadData();
                                    Certification.ShowData(response.Data.Data);
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
                var td = $("<td style='text-align:center'>").append(btn);
                tr.append(td);
                table.append(tr);
            }
        }
    };

</script>
