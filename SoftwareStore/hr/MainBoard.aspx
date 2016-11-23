<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainBoard.aspx.cs" Inherits="SELPORTAL.hr.MainBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/tablecss.css" rel="stylesheet" />
    <script src="/js/plugin/morris/morris.min2.js"></script>
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <script src="/js/selportalscript.js"></script>
    <style>
        .legendLabel
        {
            font-size:16px;
        }
        .legendColorBox
        {
            vertical-align:middle;
        }
    </style>
    <script type="text/javascript">
        debugger;
        pageSetUp();
        var listQuantity = JSON.parse('<%=SELPORTAL.hr.MainBoard.StatisticQuantity()%>');
        var listMajor = JSON.parse('<%=SELPORTAL.hr.MainBoard.StatisticMajor()%>');
        var listAge = JSON.parse('<%=SELPORTAL.hr.MainBoard.StatisticAge()%>');
        var listEducation = JSON.parse('<%=SELPORTAL.hr.MainBoard.StatisticEducation()%>');
        var listTOEIC = JSON.parse('<%=SELPORTAL.hr.MainBoard.StatisticTOEIC()%>');

        // Load morris dependency 2
        debugger;
        loadScript("js/plugin/morris/raphael.2.1.0.min1.js", loadMorris);
        function loadMorris() {
            debugger;
            loadScript("js/plugin/morris/morris.min2.js", ShowGraph1());
        }

        function ShowGraph1() {
            //  Devices
            // Use Morris.Bar
            // bar graph color
            // Use Morris.Bar experience


            debugger;
            // Graph quantity
            var dataQuantity = [];
            var number = 0;
            for (var j = 0; j < listQuantity.length; j++) {
                number = number + listQuantity[j].Quantity;
                var temp = { x: listQuantity[j].Type, y: number };
                dataQuantity.push(temp);
            }
            if ($('#bar-graph-quantity').length) {
                Morris.Bar({
                    element: 'bar-graph-quantity',
                    data: dataQuantity,
                    xkey: 'x',
                    ykeys: ['y'],
                    labels: ['Quantity'],
                    barColors: ["#496949"]
                });
            }


            //// Graph year experience
            dataQuantity = [];
            for (var j = 0; j < listQuantity.length; j++) {
                var now = new Date();
                var temp = { x: (now.getFullYear() - parseInt(listQuantity[j].Type) + 1) + " year(s)", y: listQuantity[j].Quantity };
                dataQuantity.push(temp);
            }
            if ($('#bar-graph-experience').length) {
                Morris.Bar({
                    element: 'bar-graph-experience',
                    data: dataQuantity,
                    xkey: 'x',
                    ykeys: ['y'],
                    labels: ['Quantity'],
                    barColors: ["#a65858"]
                });
            }


            // Graph Major
            dataQuantity = [];
            for (var j = 0; j < listMajor.length; j++) {
                var now = new Date();
                var temp = { x: listMajor[j].Type, y: listMajor[j].Quantity };
                dataQuantity.push(temp);
            }
            if ($('#bar-graph-major').length) {
                Morris.Bar({
                    element: 'bar-graph-major',
                    data: dataQuantity,
                    xkey: 'x',
                    ykeys: ['y'],
                    labels: ['Quantity'],
                    barColors: ["#2f7ed8"]

                });
            }

            // Graph TOEIC
            dataQuantity = [];
            for (var j = 0; j < listTOEIC.length; j++) {
                var now = new Date();
                var temp = { x: listTOEIC[j].Type, y: listTOEIC[j].Quantity };
                dataQuantity.push(temp);
            }
            if ($('#bar-graph-toeic').length) {
                Morris.Bar({
                    element: 'bar-graph-toeic',
                    data: dataQuantity,
                    xkey: 'x',
                    ykeys: ['y'],
                    labels: ['Score'],
                    barColors: ["#b09b5b"]
                });
            }


            // Graph age
            dataQuantity = [];
            for (var j = 0; j < listAge.length; j++) {
                var now = new Date();
                var temp = { label: listAge[j].Type, value: listAge[j].Quantity };
                dataQuantity.push(temp);
            }
            if ($('#bar-graph-age').length) {
                Morris.Donut({
                    element: 'bar-graph-age',
                    data: dataQuantity,
                    formatter: function (x) { return x + "%" }
                });
            }


            // Graph Education
            dataQuantity = [];
            for (var j = 0; j < listEducation.length; j++) {
                var now = new Date();
                var temp = { label: listEducation[j].Type, value: listEducation[j].Quantity };
                dataQuantity.push(temp);
            }
            if ($('#bar-graph-education').length) {
                Morris.Donut({
                    element: 'bar-graph-education',
                    data: dataQuantity,
                    formatter: function (x) { return x + "%" }
                });
            }
        }



        loadScript("js/plugin/flot/jquery.flot.cust.js", loadFlotResize);

        function loadFlotResize() {
            loadScript("js/plugin/flot/jquery.flot.resize.js", loadFlotFillbetween);
        }
        function loadFlotFillbetween() {
            loadScript("js/plugin/flot/jquery.flot.fillbetween.js", loadFlotOrderBar);
        }
        function loadFlotOrderBar() {
            loadScript("js/plugin/flot/jquery.flot.orderBar.js", loadFlotPie);
        }
        function loadFlotPie() {
            loadScript("js/plugin/flot/jquery.flot.pie.js", loadFlotToolTip);
        }
        function loadFlotToolTip() {
            loadScript("js/plugin/flot/jquery.flot.tooltip.js", generateAllFlotCharts);
        }
        function generateAllFlotCharts() {
            /* pie chart */

            if ($('#pie-chart-education').length) {

                var dataQuantity = [];
                for (var j = 0; j < listEducation.length; j++) {
                    var temp = { label: listEducation[j].Type, data: listEducation[j].Quantity };
                    dataQuantity.push(temp);
                }
                $.plot($("#pie-chart-education"), dataQuantity, {
                    series: {
                        pie: {
                            show: true,
                            innerRadius: 0.5,
                            radius: 1,
                            label: {
                                show: true,
                                radius: 2 / 3,
                                formatter: function (label, series) {
                                    return '<div style="font-size:11px;text-align:center;padding:4px;color:white;">' + label + '<br/>' + Math.round(series.percent) + '%</div>';
                                },
                                threshold: 0.1
                            }
                        }
                    },
                    legend: {
                        show: true,
                        noColumns: 1, // number of colums in legend table
                        labelFormatter: null, // fn: string -> string
                        labelBoxBorderColor: "#000", // border color for the little label boxes
                        container: null, // container (as jQuery object) to put legend in, null means default on top of graph
                        position: "ne", // position of default legend container within plot
                        margin: [5, 10], // distance from grid edge to default legend container within plot
                        backgroundColor: "#efefef", // null means auto-detect
                        backgroundOpacity: 1 // set to 0 to avoid background
                    },
                    grid: {
                        hoverable: true,
                        clickable: true
                    },
                });

            }

            /* end pie chart */


            if ($('#pie-chart-age').length) {

                var dataQuantity = [];
                for (var j = 0; j < listAge.length; j++) {
                    var temp = { label: listAge[j].Type, data: listAge[j].Quantity };
                    dataQuantity.push(temp);
                }
                $.plot($("#pie-chart-age"), dataQuantity, {
                    series: {
                        pie: {
                            show: true,
                            innerRadius: 0.5,
                            radius: 1,
                            label: {
                                show: true,
                                radius: 2 / 3,
                                formatter: function (label, series) {
                                    return '<div style="font-size:11px;text-align:center;padding:4px;color:white;">' + label + '<br/>' + Math.round(series.percent) + '%</div>';
                                },
                                threshold: 0.1
                            }
                        }
                    },
                    legend: {
                        show: true,
                        noColumns: 1, // number of colums in legend table
                        labelFormatter: null, // fn: string -> string
                        labelBoxBorderColor: "#000", // border color for the little label boxes
                        container: null, // container (as jQuery object) to put legend in, null means default on top of graph
                        position: "ne", // position of default legend container within plot
                        margin: [5, 10], // distance from grid edge to default legend container within plot
                        backgroundColor: "#efefef", // null means auto-detect
                        backgroundOpacity: 1 // set to 0 to avoid background
                    },
                    grid: {
                        hoverable: true,
                        clickable: true
                    },
                });

            }


        }
    </script>

</head>
<body>
    <section id="widget-grid" class="">
        <!-- end row -->

        <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idQuantity" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-user"></i></span>
                        <h2>The number of people in SEL</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding">

                            <div id="bar-graph-quantity" class="chart no-padding" style="height: 300px;"></div>

                        </div>

                    </div>

                </div>
            </article>
            <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idExperience" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-star"></i></span>
                        <h2>Years Working Experience</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding">

                            <div id="bar-graph-experience" class="chart no-padding" style="height: 300px;"></div>

                        </div>

                    </div>

                </div>
            </article>
            <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idMajor" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-tag"></i></span>
                        <h2>Major Distribution</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding">

                            <div id="bar-graph-major" class="chart no-padding" style="height: 300px;"></div>

                        </div>

                    </div>

                </div>
            </article>
            <!-- WIDGET END -->

        </div>


        <div class="row">
            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idEducation" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-bar-chart-o"></i></span>
                        <h2>Education Background</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding" style="height: 320px;">
                            <div class="row">
                                <article class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                                </article>
                                <article class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
                                    <div id="pie-chart-education" class="chart no-padding" style="height: 250px; margin-top:30px"></div>
                                </article>
                            </div>
                        </div>

                    </div>

                </div>
            </article>
            <!-- WIDGET END -->

            <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idToeic" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-trophy"></i></span>
                        <h2>TOEIC Score</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding" style="height:300px;">
                            <div id="bar-graph-toeic" class="chart no-padding" style="height: 300px;"></div>
                        </div>

                    </div>

                </div>
            </article>
            <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="idAge" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-calendar"></i></span>
                        <h2>Members's Age</h2>
                    </header>
                    <!-- widget div-->
                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                        </div>

                        <div class="widget-body no-padding" style="height: 320px;">
                            <div class="row">
                                <article class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                                </article>
                                <article class="col-xs-12 col-sm-10 col-md-10 col-lg-10">
                                    <div id="pie-chart-age" class="chart no-padding" style="height: 250px; margin-top:30px"></div>
                                </article>
                            </div>
                        </div>

                    </div>

                </div>
            </article>
            <!-- WIDGET END -->

        </div>

    </section>
    <div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</body>
</html>
