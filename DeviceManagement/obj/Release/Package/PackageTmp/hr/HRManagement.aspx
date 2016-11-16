<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRManagement.aspx.cs" Inherits="DeviceManagement.hr.HRManagement" %>


<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />

<style>
    .labelfilter {
        min-width: 80px;
    }

    .combofilter {
        min-width: 120px;
    }
</style>

<script type="text/javascript">
    pageSetUp();
    var currentpage = 1;
    var numberdeviceinpage = 10;
    var ListUser = [];
    var datateam = [];

    function FindByID(id) {
        for (var i = 0; i < ListUser.length; i++) {
            if (ListUser[i].UserName == id)
                return ListUser[i];
        }
        return null;
    }

    function LoadTable(list) {
        var table = $('#datatable_tabletools > tbody');
        table.empty();
        if (list.length == 0) {
            EmptyTable(table, 18);
        }

        for (i = 0; i < list.length; i++) {

            var tr = $('<tr class="clickable">').attr("dataid", list[i].UserName);
            tr.click(function () {

                var target = "/hr/dialoguserinformation.aspx?user=" + $(this).attr("dataid");
                $('#remoteModal2').removeData();

                $('#remoteModal2').load(target, function () {
                    $('#remoteModal2').modal("show");

                });
                return false;
            });
            var td = createCellImage(list[i].Avatar);
            tr.append(td);

            var td = createCellName(list[i].UserName + "/" + list[i].FullName);
            tr.append(td);

            var td = createCell(list[i].JobName);
            tr.append(td);

            var td = createCell(list[i].Position);
            tr.append(td);

            var td = createCell(list[i].Permission);
            tr.append(td);

            var td = $("<td style='text-align:center'>");
            var togger = Common.CreateSwitch("", list[i].UserName == list[i].Leader, "ON", "OFFF", function (checkbox) {
                ;
                var user = FindByID($(checkbox).parent().attr("dataid"));
                if (user == null)
                    checkboxchecked = false;
                else {
                    if (checkbox.checked) {
                        checkbox.checked = false;
                        confirm("Confirmation!", "Do you want to set: <b>" + user.FullName + "</b> is Leader for Team: <b>" + user.TeamName, "OK", "Cancel", function () {
                            AJAXFunction.CallAjax("POST", "/hr/HRManagement.aspx", "SetLeader", { username: user.UserName }, function (response) {
                                if (response.Status) {
                                    alertSmallBox("Assigned successful " + user.FullName + " is leader of team " + user.TeamName, "1 second ago!!", "success");
                                    LoadData(currentpage);
                                }
                                else {
                                    alertSmallBox("Save information failed", "1 second ago!!", "Error");

                                }
                            });
                        });

                    }
                    else {
                        checkbox.checked = true;
                        alertSmallBox("Information!", "Team: " + user.TeamName + " need have a leader, please select other member as leader");
                    }
                }
            }).attr("dataid", list[i].UserName);
            td.append(togger);
            tr.append(td);

            td.disableSelection();
            td.click(function (event) {
                event.stopPropagation();
            });

            var td = $("<td style='text-align:center'>")
            if (list[i].Gender == "Male")
                td.append(Common.CreateLabelBadgeInfo(list[i].Gender));
            else
                td.append(Common.CreateLabelBadgeSuccess(list[i].Gender));
            tr.append(td);

            var td = createCell(list[i].Birthday);
            tr.append(td);


            var td = createCell(list[i].GroupName);
            tr.append(td);
            var td = createCell(list[i].PartName);
            tr.append(td);
            var td = createCell(list[i].TeamName);
            tr.append(td);

            var td = createCell(list[i].PhoneNumber);
            tr.append(td);

            var td = createCell(list[i].STCScore).css("text-align", "center");
            tr.append(td);
            var td = createCell(list[i].ToeicScore).css("text-align", "center");
            tr.append(td);
            var td = createCell(list[i].JobDescription);
            tr.append(td);

            var td = createCell(list[i].DateJoiningSEL);
            tr.append(td);

            var td = $("<td style='text-align:center'>").click(function (event) {
                event.stopPropagation();
            });
            var btn = $("<label class='btn' style='width:100%'>").text(list[i].Active ? "Active" : "InActive").attr("dataactive", list[i].Active).attr("dataid", list[i].UserName);
            if (!list[i].Active)
                btn.addClass("btn-danger");
            else
                btn.addClass("btn-success");
            btn.click(function () {

                var active = $(this).attr("dataactive") == "true";
                var username = $(this).attr("dataid");
                confirm("Confirmation!", "Do you want to <b>" + (active ? " INACTIVE " : " ACTIVE ") + username + ".</b>" + (active ? ("<br> <b>" + username + "</b> will not be accept when login to system if you InActive this account") : ""), "OK", "Cancel", function () {


                    AJAXFunction.CallAjax("POST", "/hr/hrmanagement.aspx", "ActiveMember",
                        {
                            username: username,
                            active: !active
                        },
                        function (response) {
                            if (response.Status) {
                                alertSmallBox((active ? "ACTIVE" : "INACTIVE") + " Account " + username + " successful", "1 second ago", "success");
                                LoadData(currentpage);
                            }
                            else {
                                alertSmallBox((active ? "ACTIVE" : "INACTIVE") + " Account " + username + " not successful", "1 second ago", "error");

                            }
                        }
                    );

                });
            });
            td.append(btn);
            tr.append(td);


            var td = $("<td style='text-align:center'>").click(function (event) {
                event.stopPropagation();

            });
            var btnedit = $("<span class='btn btn-xs btn-info' style='margin-right:5px;'>").attr("dataid", list[i].UserName);
            var iedit = $("<i class='fa fa-edit'>");
            btnedit.append(iedit);
            td.append(btnedit);
            btnedit.click(function () {
                var target = "#/hr/userprofile.aspx?user=" + $(this).attr("dataid");
                window.open(target);
                //location.replace(target);
            });

            var btndel = $("<span class='btn btn-xs btn-info'>").attr("dataid", list[i].UserName);
            var iedit = $("<i class='fa fa-times'>");
            btndel.append(iedit);
            td.append(btndel);
            btndel.click(function () {
                var dataid = $(this).attr("dataid");
                confirm("Confirmation", "Do you want to delete user: <b>" + dataid + "</b>", "Delete", "Cancel", function () {
                    AJAXFunction.CallAjax("POST", "/hr/hrmanagement.aspx", "DeleteUser", { mySingle: dataid }, function (response) {
                        if (response.Status) {
                            alertSmallBox("Delete account " + dataid + " successful", "1 second ago", "success");
                            LoadData(currentpage);
                        }
                        else {
                            alertSmallBox("Delete account " + dataid + " not successful", "1 second ago", "error");

                        }

                    });
                });
            });

            tr.append(td);
            table.append(tr);
        }
        set_statuses();
    }

    //// Search and load data on table

    function LoadData(page) {
        currentpage = page;
        var keyword = $('#inputSearch').val();
        var numberinpage = numberdeviceinpage;
        AJAXFunction.CallAjax("POST", "/hr/HRManagement.aspx", "GetAllUser", {
            JobTitleID: $("#<%=cbSelectJobTitle.ClientID%>").val(),
            PossitionID: $("#<%=cbSelectPossition.ClientID%>").val(),
            TeamID: $("#<%=cbTeam.ClientID%>").val(),
            Gender: $("#<%=cbGender.ClientID%>").val(),
            Active: $("#<%=cbActive.ClientID%>").val(),
            STCLevel: $("#<%=cbSTCLevel.ClientID%>").val(),
            Permission: $("#<%=cbPermission.ClientID%>").val(),
            keyword: keyword,
            currentpage: page,
            numberinpage: numberinpage,
        }, function (obj) {
            if (obj.Status) {
                var divtotalitem = $('#divtotalitem').empty();
                ListUser = obj.Data;
                divtotalitem.append('Total User: ' + obj.TotalUser)
                LoadTable(ListUser);
                var _totalpage = Math.round(obj.TotalUser / numberinpage);
                var totalpage = ((obj.TotalUser / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                AJAXFunction.CreatePaging($("#divpaging"), currentpage, totalpage, LoadData);
            }
            else {
                alertbox("Can't load data in this time");
            }


        });
    }
    function ShowNumberDevice(numberdevice) {
        $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
        numberdeviceinpage = numberdevice;
        LoadData(1);
    }


    LoadData(1);

    $('#inputSearch').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            LoadData(1);
        }
    });
    function AddNewUser() {

        var target = "/hr/AddUser.aspx";
        $('#remoteModal').removeData();
        $('#remoteModal').modal({ backdrop: 'static' });
        $('#remoteModal').load(target, function () {
            $('#remoteModal').modal("show");

        });
        return false;
    }

    $(document).ready(function () {
        datateam = JSON.parse($("#dataTeam").val());

        $(".combofilter").change(function () {
            LoadData(1);
        });

        $("#<%=cbSelectPart.ClientID%>").change(function () {
            $("#<%=cbTeam.ClientID%>").empty();
            $("#<%=cbTeam.ClientID%>").append($("<option>").val($("#<%=cbSelectPart.ClientID%>").val()).text("===ALL==="));
            for (var i = 0; i < datateam.length; i++) {
                if ($("#<%=cbSelectPart.ClientID%>").val() == 0 || $("#<%=cbSelectPart.ClientID%>").val() == datateam[i].PartID) {
                    for (var j = 0; j < datateam[i].ListTeam.length; j++) {
                        $("#<%=cbTeam.ClientID%>").append($("<option>").val(datateam[i].ListTeam[j].TeamID).text(datateam[i].ListTeam[j].TeamName));
                    }
                }
            }
            $("#<%=cbTeam.ClientID%>").select2("val", $("#<%=cbSelectPart.ClientID%>").val());
            LoadData(1);
        });
    });
</script>
<div>
    <!-- widget grid -->
    <input type="hidden" runat="server" id="dataTeam" />

    <section id="widget-grid" class="">

        <div class="row">
            <div class="alert alert-info alert-block" style="margin-left: 10px;">
                <h4 class="alert-heading">List of Users</h4>
            </div>


            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                <div class="row">
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Part
                        </label>
                        <select class="select2" runat="server" id="cbSelectPart" style="width: 160px !important;"></select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Team
                        </label>
                        <select class="select2 combofilter" runat="server" id="cbTeam" style="width: 160px !important;"></select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Job Title
                        </label>
                        <select class="select2 combofilter" runat="server" id="cbSelectJobTitle" style="width: 160px !important;"></select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Status
                        </label>
                        <select class="select2 combofilter" id="cbActive" runat="server" style="width: 160px !important;">
                            <option value="0">==ALL==
                            </option>
                            <option value="1">Active
                            </option>
                            <option value="2">InActive
                            </option>
                        </select>
                    </article>
                </div>
                <div class="row">
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Possition
                        </label>
                        <select class="select2 combofilter" runat="server" id="cbSelectPossition" style="width: 160px !important;">
                            <option value="0">===ALL===
                            </option>
                            <option value="1">Group Leader
                            </option>
                            <option value="2">Part Leader
                            </option>
                            <option value="3">Team Leader
                            </option>
                            <option value="4">Member
                            </option>
                        </select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Gender
                        </label>
                        <select class="select2 combofilter" id="cbGender" runat="server" style="width: 160px !important;">
                            <option value="">==ALL==
                            </option>
                            <option value="Male">Male
                            </option>
                            <option value="Female">Female
                            </option>
                        </select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            STC Level
                        </label>
                        <select class="select2 combofilter" id="cbSTCLevel" runat="server" style="width: 160px !important;">
                            <option value="0">==ALL==
                            </option>
                            <option value="1">Level 1
                            </option>
                            <option value="2">Level 2
                            </option>
                            <option value="3">Level 3
                            </option>
                            <option value="4">Level 4
                            </option>
                            <option value="5">FAIL
                            </option>
                        </select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-3" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Permission
                        </label>
                        <select class="select2 combofilter" id="cbPermission" runat="server" style="width: 160px !important;">
                            <option value="0">==ALL==
                            </option>
                            <option value="3">Admin
                            </option>
                            <option value="1">Member
                            </option>
                        </select>
                    </article>
                </div>

            </article>
            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                <label class="labelfilter labelform" style="margin-top: 14px;">
                </label>

                <div class="col-md-12" style="padding: 0px;">
                    <div class="icon-addon addon-md">
                        <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                        <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                    </div>
                </div>
            </article>

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 10px">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget jarviswidget-color-teal" id="listdevicemanagement" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-original-title="" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>List of users</h2>
                        <div class="widget-toolbar" role="menu">
                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnAddNewUser" onclick="AddNewUser()" style="width: 100px; margin-right: 5px;">Add New User</button>
                            </div>
                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px;">Show: 10<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                                <ul class="dropdown-menu pull-right js-status-update">
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(5);">5</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(10);">10</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(15);">15</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(20);">20</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(50);">50</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(100);">100</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </header>
                    <div>
                        <div class="jarviswidget-editbox">
                        </div>
                        <div class="widget-body">

                            <div class="table-responsive smart-form">
                                <div style="overflow: auto">

                                    <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 2400px">
                                        <thead>
                                            <tr>
                                                <th style="width: 40px;">Avatar</th>
                                                <th style="width: 190px;">Full Name</th>
                                                <th style="width: 120px;">Title</th>
                                                <th style="width: 120px;">Position</th>
                                                <th style="width: 120px;">Permission</th>
                                                <th style="width: 90px;">Team Leader</th>
                                                <th style="width: 80px;">Gender</th>
                                                <th style="width: 80px;">Birthday</th>
                                                <th style="width: 150px;">Group</th>
                                                <th style="width: 150px;">Part</th>
                                                <th style="width: 150px;">Team</th>
                                                <th style="width: 120px;">Phone</th>
                                                <th style="width: 70px;">STC Score</th>
                                                <th style="width: 70px;">Toeic Score</th>
                                                <th>Job Description</th>
                                                <th style="width: 90px;">Date Join SEL</th>
                                                <th style="width: 70px;">Active</th>
                                                <th style="width: 80px;">Action</th>
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
                </div>
            </article>
        </div>
    </section>
</div>
<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
