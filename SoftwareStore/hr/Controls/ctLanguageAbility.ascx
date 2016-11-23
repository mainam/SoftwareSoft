<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctLanguageAbility.ascx.cs" Inherits="SoftwareStore.hr.Controls.ctLanguageAbility" %>

<div class="jarviswidget  jarviswidget-color-greenLight" id="wdLanguage" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-edit"></i></span>
        <h2>Language Ability</h2>
        <div class="widget-toolbar" role="menu" runat="server" id="btnAdd">
            <!-- add: non-hidden - to disable auto hide -->
            <div class="btn-group">
                <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="Language.AddLanguage();" style="width: 70px;">Add</a>
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
            <table id="tableLanguage" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0">
                <thead>
                    <tr>
                        <th style="width: 50px;">No</th>
                        <th>Language</th>
                        <th>Native</th>
                        <th>Overall</th>
                        <th>Speak</th>
                        <th>Read</th>
                        <th>Write</th>
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
    var Language = {
        ListData: [],
        FindLanguage: function (id) {
            for (var i = 0; i < Language.ListData.length; i++) {
                if (Language.ListData[i].ID == id)
                    return Language.ListData[i];
            }
            return null;
        },
        currentid: null,
        AddLanguage: function () {
            Language.currentid = null;
            var target = "/hr/dialog/AddLanguage.aspx";
            $("#remoteModal").removeData();
            $('#remoteModal').modal({ backdrop: 'static' });
            $("#remoteModal").load(target, function () {
                $("#remoteModal").modal("show");
            });
        },
        GetLevelScore: function (score) {
            switch (score) {
                case 1:
                    return "Excellent";
                case 2:
                    return "Average";
                default: return "Not Qualified";
            }
        },
        LoadData: function () {
            var username = GetQueryStringHash("user");
            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "LoadListLanguage", {
                username: username
            }, function (response) {
                if (response.Status) {                   
                    Language.ShowData(response.Data.Data);
                }
            });
            $("#remoteModal").modal("hide");
        }, ShowData: function (list) {

            Language.ListData = list;
            var table = $("#tableLanguage > tbody").empty();
            if (list.length == 0)
                EmptyTable(table, 8);
            for (var i = 0; i < list.length; i++) {
                var tr = $("<tr>").attr("dataid", list[i].ID);
                if (UserProfilePage.AllowEdit) {
                    tr.addClass("clickable");
                    tr.click(function () {
                        Language.currentid = $(this).attr("dataid");
                        var target = "/hr/dialog/AddLanguage.aspx";
                        $("#remoteModal").removeData();
                        $('#remoteModal').modal({ backdrop: 'static' });
                        $("#remoteModal").load(target, function () {
                            $("#remoteModal").modal("show");
                        });

                    });
                }

                var td = createCell(i + 1);
                tr.append(td);
                var td = createCell(list[i].Language);
                tr.append(td);
                var td = createCellTick(list[i].Native);
                tr.append(td);
                var td = createCell(list[i].ScoreOverall);
                tr.append(td);
                var td = createCell(Language.GetLevelScore(list[i].ScoreSpeak));
                tr.append(td);
                var td = createCell(Language.GetLevelScore(list[i].ScoreRead));
                tr.append(td);
                var td = createCell(Language.GetLevelScore(list[i].ScoreWrite));
                tr.append(td);
                var td = $("<td>");
                var td = $("<td style='text-align:center'>");
                if (UserProfilePage.AllowEdit) {
                    var btn = $("<label class='btn btn-default btn-xs' style='width:21px'>").append($("<i class='fa fa-times'>")).attr("dataid", list[i].ID);
                    btn.click(function (event) {
                        event.stopPropagation();
                        var dataid = $(this).attr("dataid");
                        confirm("Confirm", "Do you want to delele this item", "Delete", "Cancel", function () {
                            var username = GetQueryStringHash("user");
                            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "DelLanguage", {
                                username: username,
                                id: dataid
                            }, function (response) {
                                if (response.Status) {

                                    alertSmallBox("Delete language successful", "1 second ago!!", "success");
                                    Language.LoadData();
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
