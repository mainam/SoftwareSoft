<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeviceDashboard.aspx.cs" Inherits="DeviceManagement.device.DeviceDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/tablecss.css" rel="stylesheet" />
    <script src="/js/plugin/morris/morris.min1.js"></script>
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />

    <script type="text/javascript">
        pageSetUp();
        LoadStatistic();
        var IDDeviceNoticeEdit = null;
        var ListNotice = [];
        var statisticdevice;
        var managers;

        function GetFullName(info) {
            var arr = info.split("/");
            if (arr.length > 1)
                return arr[1];
            return "";
        }

        // Load morris dependency 2
        function loadMorris() {
            loadScript("js/plugin/morris/morris.min1.js", ShowGraph());
        }

        function ShowGraph() {
            //  Devices
            if ($('#bar-graph-device').length) {

                var datastatistic = [];
                var numA = 0, numB = 0, numL = 0, numF = 0;
                for (var j = 0; j < statisticdevice.length; j++) {

                    var temp = { x: statisticdevice[j].typename };
                    for (var i = 0; i < statisticdevice[j].statisticstatus.length; i++) {
                        temp['h' + (i + 1)] = statisticdevice[j].statisticstatus[i].CountDevices;
                        switch (i) {
                            case 0: numA += statisticdevice[j].statisticstatus[i].CountDevices;
                                break;
                            case 1: numB += statisticdevice[j].statisticstatus[i].CountDevices;
                                break;
                            case 2: numL += statisticdevice[j].statisticstatus[i].CountDevices;
                                break;
                            case 3: numF += statisticdevice[j].statisticstatus[i].CountDevices;
                                break;
                        }
                    }
                    datastatistic.push(temp);
                }

                Morris.Bar({
                    element: 'bar-graph-device',
                    data: datastatistic,
                    xkey: 'x',
                    ykeys: ['h1', 'h2', 'h3', 'h4'],
                    labels: ['Available', 'Borrow', 'Loss', 'Broken']
                });

                var tablestatus = $('#statusdevice > tbody').empty();
                var tr = $('<tr>').append($('<td>').text('Available')).append($('<td>').text(numA));
                tablestatus.append(tr);
                tr = $('<tr>').append($('<td>').text('Borrow')).append($('<td>').text(numB));
                tablestatus.append(tr);
                tr = $('<tr>').append($('<td>').text('Loss')).append($('<td>').text(numL));
                tablestatus.append(tr);
                tr = $('<tr>').append($('<td>').text('Broken')).append($('<td>').text(numF));
                tablestatus.append(tr);
            }

        }

        function displayManager(managers) {
            var i;

            for (i = 0; i < managers.length; i++) {
                var temp = managers[i].split(';');
                var com = "<div class='body' style='margin-bottom: 10px; margin-top: 10px; text-align:left;'><a href='sip:" + temp[0] + "@samsung.com' title='Start chat' style='color: #15c23c'> <img alt='" + temp[0] + "' class='statusMySingle' src='/js/communicator/Images/unknown.png' /> " + temp[1] + " </a></div>";
                $('#manager').append(com);
            }
        }

        function LoadStatistic() {
            $.ajax({
                type: "POST",
                url: "device/DeviceDashBoard.aspx/LoadStatistic",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = JSON.parse(response.d);
                    if (obj.Status) {
                        statisticdevice = obj.Data;
                        displayManager(obj.ListManager)
                        loadScript("js/plugin/morris/raphael.2.1.0.min1.js", loadMorris);
                    }
                },
                failure: function (response) {
                }
            });
        }


        function AddNotice() {
            IDDeviceNoticeEdit = null;
            var target = "/device/AddNewNotice.aspx"
            $('#remoteModal').removeData();
            $('#remoteModal').modal({ backdrop: 'static' });
            $('#remoteModal').load(target, function () {
                $('#remoteModal').modal("show");
            });
        }

        function ShowListNotice(TotalItem, Target, ListData) {
            Target.empty();
            ListNotice = ListData;
            var ul = $('<ul style="padding:10px;">');
            for (var i = 0; i < ListData.length; i++) {
                var li = $('<li style="width: 100%;list-style: none;border-bottom: dotted 2px #eee; min-height:60px; padding-top: 4px;">');
                var _title = ListData[i].Title;
                if (_title.length > 50)
                    _title = _title.substring(0, 50) + "...";
                var title = $('<a style="font-weight: bold; font-size: 14px;"  data-toggle="modal" data-target="#remoteModal">').append("<i class='fa fa-hand-o-right' style='margin-right: 5px;'></i>").append(_title);
                title.attr('href', "/device/ViewNotice.aspx?NoticeID=" + ListData[i].ID);
                title.click(function () {
                    IDDeviceNoticeEdit = null;
                    var target = $(this).attr("href");
                    $($(this).attr("data-target")).removeData();
                    $('#remoteModal').modal({ backdrop: 'static' });
                    $($(this).attr("data-target")).load(target, function () {
                        $($(this).attr("data-target")).modal("show");
                    });
                });
                var div = $('<div style="margin-top:10px;">').append("Created by: <b style='min-width:200px; margin-right:20px;'>" + ListData[i].FullName + "</b>Created Date: <b>" + ListData[i].CreateDate + "</b>");
                li.append(title);
                if (ListData[i].AlowEdit) {
                    var btnedit = $('<lable class="btn btn-default btn-xs" style = "margin-right:5px; float:right;"  data-toggle="modal" data-target="#remoteModal">').append($("<i class='fa fa-edit'>")).attr('dataid', ListData[i].ID);
                    btnedit.click(function () {
                        IDDeviceNoticeEdit = $(this).attr('dataid');
                        var target = "/device/AddNewNotice.aspx";
                        $($(this).attr("data-target")).removeData();
                        $('#remoteModal').modal({ backdrop: 'static' });
                        $($(this).attr("data-target")).load(target, function () {
                            $($(this).attr("data-target")).modal("show");
                        });
                    });

                    li.append(btnedit);
                    var btndel = $('<lable class="btn btn-info btn-xs" style = "margin-right:5px; float:right;">').attr("dataid", ListData[i].ID).append($("<i class='fa fa-times'>"));
                    btndel.click(function () {
                        var dataid = $(this).attr("dataid");
                        confirm("Confirm", "Do you want to remove notice selected", "OK", "Cancel", function () {
                            AJAXFunction.CallAjax("POST", "/device/DeviceDashBoard.aspx", "DeleteNotice", { IDNotice: dataid }, function (response) {
                                if (response.Status) {

                                    LoadListNotice(1);
                                    alertSmallBox("Delete item success", "1 second ago!!", "Success");
                                }
                                else
                                    alertSmallBox("Delete item failed", "1 second ago!!", "Error");
                            });
                        });

                    });
                    li.append(btndel);

                }

                li.append(div);
                ul.append(li);
            }
            Target.append(ul);
        }

        function LoadListNotice(page) {
            AJAXFunction.LoadData($('#targetdata'), $('#targetpaging'), page, "POST", "/device/DeviceDashBoard.aspx/LoadDataNotice", JSON.stringify({
                currentpage: page,
                numberinpage: 5,
                keyword: ""
            }), ShowListNotice, 5, LoadListNotice);
        }
        $(document).ready(function () {
            LoadListNotice(1);
        });

    </script>

</head>
<body>

    <div class="row">
        <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
            <h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i>Dashboard <span>> Device Dashboard</span></h1>
        </div>
    </div>
    <section id="widget-grid" class="">
        <!-- end row -->

        <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idstatisticdevice" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-bar-chart-o"></i></span>
                        <h2>Statistic</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding">
                            <div style="right: 40px; position: absolute; background-color: rgb(239, 239, 239); z-index: 100;">
                                <table>

                                    <tbody>
                                        <tr>
                                            <td class="legendColorBox">
                                                <div style="#000">
                                                    <div style="border: 2px solid rgb(113, 132, 63); overflow: hidden"></div>
                                                </div>
                                            </td>
                                            <td class="legendLabel"><span>Available</span></td>
                                        </tr>
                                        <tr>
                                            <td class="legendColorBox">
                                                <div style="#000">
                                                    <div style="border: 2px solid rgb(87, 136, 156); overflow: hidden"></div>
                                                </div>
                                            </td>
                                            <td class="legendLabel"><span>Borrow</span></td>
                                        </tr>
                                        <tr>
                                            <td class="legendColorBox">
                                                <div style="#000">
                                                    <div style="border: 2px solid rgb(246, 153, 136); overflow: hidden"></div>
                                                </div>
                                            </td>
                                            <td class="legendLabel"><span>Loss</span></td>
                                        </tr>
                                        <tr>
                                            <td class="legendColorBox">
                                                <div style="#000">
                                                    <div style="border: 2px solid rgb(146, 162, 168); overflow: hidden"></div>
                                                </div>
                                            </td>
                                            <td class="legendLabel"><span>Broken</span></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                            <div id="bar-graph-device" class="chart no-padding" style="height: 280px;"></div>

                        </div>

                    </div>

                </div>
            </article>

            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget jarviswidget-color-yellow" id="idtotoaldevice" data-widget-editbutton="false" data-widget-sortable="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-attstyle="jarviswidget-color-yellow" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-bar-chart-o"></i></span>

                        <h2>Total devices</h2>

                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>
                        <div class="widget-body no-padding">
                            <table id="statusdevice" class="table " style="margin: 0 auto; width: 200px !important; margin-bottom: 10px; font-weight: bold">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="jarviswidget jarviswidget-color-redLight" id="idlistmanager" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-redLight" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-user"></i></span>
                        <h2>Manager</h2>
                    </header>
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                            <!-- This area used as dropdown edit box -->

                        </div>
                        <!-- end widget edit box -->
                        <!-- widget content -->
                        <div class="widget-body no-padding">
                            <div id="manager" style="width: 100%; height: 70px; overflow: hidden; overflow-y: auto; padding-left: 100px; margin-top: 20px; font-size: 16px;">
                            </div>
                        </div>
                    </div>
                </div>
            </article>
            <!-- WIDGET END -->

        </div>
        <div class="row" style="margin-bottom: 5px;">
            <article class="col-xs-12 col-sm-9 col-md-9 col-lg-4 sortable-grid ui-sortable">
                <div class="jarviswidget jarviswidget-color-pink" id="divnotice" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-pink" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa  fa-bullhorn"></i></span>
                        <h2>Notice</h2>
                        <% if (HttpContext.Current.User.Identity.Name == "kim.yen")
                           { %>
                        <div class="widget-toolbar" role="menu">
                            <div class="btn-group">
                                <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="AddNotice();">Add Notice</a>
                            </div>
                        </div>
                        <%} %>
                    </header>
                    <!-- widget div-->
                    <div>
                        <div class="widget-body no-padding" style="height: 350px;">
                            <div id="targetdata" style="height: 300px; overflow: hidden;">
                            </div>
                            <div id="targetpaging" style="text-align: right; margin-top: -5px; margin-right: 5px;">
                            </div>
                        </div>
                    </div>
                </div>
            </article>
            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-4 sortable-grid ui-sortable">
                <div class="jarviswidget jarviswidget-color-pink" id="divtopborrow" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-pink" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa  fa-group"></i></span>

                        <h2>Top Borrower</h2>
                    </header>
                    <div>

                        <div class="widget-body no-padding" style="height: 350px; overflow: auto">
                            <asp:Repeater runat="server" ID="repTopBorrow">
                                <HeaderTemplate>
                                    <table class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th style="font-weight: bold; text-align: center; width: 40px;">No
                                                </th>
                                                <th style="font-weight: bold; text-align: center">Full Name
                                                </th>
                                                <th style="font-weight: bold; text-align: center; width: 150px;">Number of Device
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%#Container.ItemIndex +1 %>
                                        </td>
                                        <td style="padding-left: 30px;">
                                            <a href="sip:<%# (Eval("User") as DataAccess.User).Email %>" title="Start chat" style="color: #0094ff">
                                                <img alt="<%# (Eval("User") as DataAccess.User).UserName %>" class="statusMySingle" src="/js/communicator/Images/unknown.png">
                                                <%# (Eval("User") as DataAccess.User).FullName %> </a>
                                        </td>
                                        <td style="text-align: center;">
                                            <%# Eval("Count")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                            <div class="alert alert-success fade in" runat="server" id="mesTopBorrow">
                                <button class="close" data-dismiss="alert">
                                    ×
                                </button>
                                <i class="fa-fw fa fa-check"></i>
                                Data not available
                            </div>

                        </div>
                    </div>
                </div>
            </article>
            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-4 sortable-grid ui-sortable">
                <div class="jarviswidget jarviswidget-color-pink" id="ReturninDate" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-pink" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-list-ul"></i></span>

                        <h2>List to return</h2>

                    </header>
                    <!-- widget div-->
                    <div>
                        <div class="widget-body no-padding" style="height: 350px; overflow: auto">
                            <asp:Repeater runat="server" ID="RepReturnInDate">
                                <HeaderTemplate>
                                    <table class="table table-bordered table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th style="font-weight: bold; text-align: center; width: 40px;">No
                                                </th>
                                                <th style="font-weight: bold; text-align: center">Model
                                                </th>
                                                <th style="font-weight: bold; text-align: center;">Tag
                                                </th>
                                                <th style="font-weight: bold; text-align: center;">Borrower
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%#Container.ItemIndex +1 %>
                                        </td>
                                        <td>
                                            <%# Eval("Model")  %>
                                        </td>
                                        <td>
                                            <%# Eval("Tag")  %>
                                        </td>
                                        <td>
                                            <%# (Eval("User1") as DataAccess.User).FullName  %>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                            <div class="alert alert-success fade in" runat="server" id="mesReturnToday">
                                <button class="close" data-dismiss="alert">
                                    ×
                                </button>
                                <i class="fa-fw fa fa-check"></i>
                                There isn't any device must return
                            </div>
                        </div>
                    </div>

                </div>
            </article>
        </div>
    </section>
    <div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</body>
</html>
