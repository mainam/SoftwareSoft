<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SeMember.aspx.cs" Inherits="DeviceManagement.hr.SeMember" %>

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
    var datateam = [];

    function LoadTable(list) {
        var table = $('#datatable_tabletools > tbody');
        table.empty();
        if (list.length == 0) {
            EmptyTable(table, 14);
        }

        for (i = 0; i < list.length; i++) {

            var tr = $('<tr class="clickable">').attr("dataid", list[i].UserName);
            tr.click(function () {

                var target = "/hr/dialogUserInformation.aspx?user=" + $(this).attr("dataid");
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
            table.append(tr);
        }
    }

    //// Search and load data on table

    function LoadData(page) {
        currentpage = page;
        var keyword = $('#inputSearch').val();
        var numberinpage = numberdeviceinpage;
        AJAXFunction.CallAjax("POST", "/hr/SeMember.aspx", "GetAllUser", {
            JobTitleID: $("#<%=cbSelectJobTitle.ClientID%>").val(),
            PossitionID: $("#<%=cbSelectPossition.ClientID%>").val(),
            TeamID: $("#<%=cbTeam.ClientID%>").val(),
            Gender: $("#<%=cbGender.ClientID%>").val(),
            STCLevel: $("#<%=cbSTCLevel.ClientID%>").val(),
            keyword: keyword,
            currentpage: page,
            numberinpage: numberinpage
        }, function (obj) {
            if (obj.Status) {
                var divtotalitem = $('#divtotalitem').empty();
                var listdata = obj.Data;
                divtotalitem.append('Total User: ' + obj.TotalUser)
                LoadTable(listdata);
                var _totalpage = Math.round(obj.TotalUser / numberinpage);
                var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
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
    <input type="hidden" runat="server" id="dataTeam" />
    <!-- widget grid -->
    <section id="widget-grid" class="">

        <div class="row">
            <div class="alert alert-info alert-block" style="margin-left: 10px;">
                <h4 class="alert-heading">List of Users</h4>
            </div>

            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                <div class="row">
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Part
                        </label>
                        <select class="select2" runat="server" id="cbSelectPart" style="width: 160px !important;"></select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Team
                        </label>
                        <select class="select2 combofilter" runat="server" id="cbTeam" style="width: 160px !important;"></select>
                    </article>
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4" style="margin-bottom: 5px;">
                        <label class="labelfilter labelform">
                            Job Title
                        </label>
                        <select class="select2 combofilter" runat="server" id="cbSelectJobTitle" style="width: 160px !important;"></select>
                    </article>

                </div>
                <div class="row" style="margin-bottom: 5px;">
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4" style="margin-bottom: 5px;">
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
                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4" style="margin-bottom: 5px;">
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

                    <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4" style="margin-bottom: 5px;">
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

                                    <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1920px">
                                        <thead>
                                            <tr>
                                                <th style="width: 40px;">Avatar</th>
                                                <th style="width: 190px;">Full Name</th>
                                                <th style="width: 120px;">Title</th>
                                                <th style="width: 120px;">Position</th>
                                                <th style="width: 120px;">Gender</th>
                                                <th style="width: 80px;">Birthday</th>
                                                <th style="width: 80px;">Group</th>
                                                <th style="width: 150px;">Part</th>
                                                <th style="width: 150px;">Team</th>
                                                <th style="width: 120px;">Phone</th>
                                                <th style="width: 70px;">STC Score</th>
                                                <th style="width: 70px;">Toeic Score</th>
                                                <th>Job Description</th>
                                                <th style="width: 100px;">Date Join SEL</th>
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
