<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRStatistic.aspx.cs" Inherits="DeviceManagement.hr.HRStatistic" %>

<%@ Register Src="~/hr/Controls/ctStatisticMemberAge.ascx" TagPrefix="uc1" TagName="ctStatisticMemberAge" %>
<%@ Register Src="~/hr/Controls/ctStatisticEducation.ascx" TagPrefix="uc1" TagName="ctStatisticEducation" %>
<%@ Register Src="~/hr/Controls/ctStatisticSTCLevel.ascx" TagPrefix="uc1" TagName="ctStatisticSTCLevel" %>





<link href="/css/tablecss.css" rel="stylesheet" />
<script src="/js/plugin/morris/morris.min2.js"></script>
<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />

<script src="/js/plugin/amcharts/amcharts.js"></script>
<script src="/js/plugin/amcharts/pie.js"></script>


<style>
    .legendLabel {
        font-size: 14px;
    }

    .legendColorBox {
        vertical-align: middle;
    }

    [title="JavaScript charts"] {
        display: none !important;
    }
</style>

<script type="text/javascript">

    function ShowChart(chartData, titleField, valueField, div) {
        var chart = new AmCharts.AmPieChart();
        chart.type = "pie";
        chart.angle = 12;
        chart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";
        chart.path = "/js/plugin/amcharts/";
        chart.dataProvider = chartData;
        chart.depth3D = 2;
        chart.innerRadius = "40%";
        chart.titleField = titleField;
        chart.valueField = valueField;
        chart.allLabels = [];
        chart.balloon = {},
        chart.labelText = "";//" [[percents]]%";
        chart.colors = [
                       "#339FBB","#DF7925","#8BA7D6","#D18685","#3871B5","#B13532","#88AB40","#6C4E90", "#664988"
        ];
        legend = new AmCharts.AmLegend();
        legend.align = "center";
        legend.markerType = "circle";
        //legend.switchType = "v";
        legend.valueWidth = 30;
        legend.valueText = ": [[value]]";
        //legend.bottom = 1;
        legend.position = "right";
        chart.addLegend(legend);

        chart.titles = [];
        chart.write(div);

    }


    <%-- var SCTLevel = {
        listdata: JSON.parse('<%=DeviceManagement.hr.HRStatistic.StatisticSTCLevel()%>'),

        generateAllFlotCharts: function () {
            /* pie chart */

            if ($('#stclevelchart').length) {

                var dataQuantity = [];
                for (var j = 0; j < SCTLevel.listdata.length; j++) {
                    var temp = { label: SCTLevel.listdata[j].Type + ": " + SCTLevel.listdata[j].Quantity, data: SCTLevel.listdata[j].Quantity };
                    dataQuantity.push(temp);
                }
                $.plot($('#stclevelchart'), dataQuantity, {
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
    }--%>

    <%-- var EducationChart = {
            listdata: JSON.parse('<%=DeviceManagement.hr.HRStatistic.StatisticEducation()%>'),

            generateAllFlotCharts: function () {
                /* pie chart */


                if ($('#pie-chart-education').length) {

                    var dataQuantity = [];
                    for (var j = 0; j < EducationChart.listdata.length; j++) {
                        var temp = { label: EducationChart.listdata[j].Type + ": " + EducationChart.listdata[j].Quantity, data: EducationChart.listdata[j].Quantity };
                        dataQuantity.push(temp);
                    }
                    $.plot($('#pie-chart-education'), dataQuantity, {
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
        }--%>


<%--        var AgeChart = {
            listdata: JSON.parse('<%=DeviceManagement.hr.HRStatistic.StatisticAge()%>'),

        generateAllFlotCharts: function () {
            /* pie chart */


            if ($('#pie-chart-age').length) {

                var dataQuantity = [];
                for (var j = 0; j < AgeChart.listdata.length; j++) {
                    var temp = { label: AgeChart.listdata[j].Type + ": " + AgeChart.listdata[j].Quantity, data: AgeChart.listdata[j].Quantity };
                    dataQuantity.push(temp);
                }
                $.plot($('#pie-chart-age'), dataQuantity, {
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
    }--%>



    pageSetUp();
    var listQuantity = JSON.parse('<%=DeviceManagement.hr.HRStatistic.StatisticQuantity()%>');
    var listTOEIC = JSON.parse('<%=DeviceManagement.hr.HRStatistic.StatisticTOEIC()%>');

    // Load morris dependency 2
    loadScript("/js/plugin/morris/raphael.2.1.0.min1.js", loadMorris);
    function loadMorris() {
        loadScript("/js/plugin/morris/morris.min2.js", ShowGraph1());
    }

    function ShowGraph1() {

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
    }


    loadScript("/js/plugin/flot/jquery.flot.cust.js", loadFlotResize);

    function loadFlotResize() {
        loadScript("/js/plugin/flot/jquery.flot.resize.js", loadFlotFillbetween);
    }
    function loadFlotFillbetween() {
        loadScript("/js/plugin/flot/jquery.flot.fillbetween.js", loadFlotOrderBar);
    }
    function loadFlotOrderBar() {
        loadScript("/js/plugin/flot/jquery.flot.orderBar.js", loadFlotPie);
    }
    function loadFlotPie() {
        loadScript("/js/plugin/flot/jquery.flot.pie.js", loadFlotToolTip);
    }
    function loadFlotToolTip() {
        //loadScript("/js/plugin/flot/jquery.flot.tooltip.js", generateAllFlotCharts);
    }
    //function generateAllFlotCharts() {
    //    //SCTLevel.generateAllFlotCharts();
    //    //EducationChart.generateAllFlotCharts();
    //    //AgeChart.generateAllFlotCharts();
    //}
</script>


<div class="row">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i>Dashboard <span>> HR Statistic</span></h1>
    </div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">

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
            <uc1:ctStatisticSTCLevel runat="server" ID="ctStatisticSTCLevel" />
            <%--   <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget  jarviswidget-color-teal" id="stclevel" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
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
                                <div id="stclevelchart" class="chart no-padding" style="height: 300px;"></div>
                            </article>
                        </div>
                    </div>

                </div>

            </div>--%>
        </article>

    </div>



    <div class="row">
        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
            <!-- Widget ID (each widget will need unique ID)-->
            <%--<div class="jarviswidget  jarviswidget-color-teal" id="idEducation" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
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
                                <div id="pie-chart-education" class="chart no-padding" style="height: 250px; margin-top: 30px"></div>
                            </article>
                        </div>
                    </div>

                </div>

            </div>--%>
            <uc1:ctStatisticEducation runat="server" ID="ctStatisticEducation" />
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

                    <div class="widget-body no-padding" style="height: 300px;">
                        <div id="bar-graph-toeic" class="chart no-padding" style="height: 300px;"></div>
                    </div>

                </div>

            </div>
        </article>
        <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
            <uc1:ctStatisticMemberAge runat="server" ID="ctStatisticMemberAge" />
            <%-- <!-- Widget ID (each widget will need unique ID)-->
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
                                <div id="pie-chart-age" class="chart no-padding" style="height: 250px; margin-top: 30px"></div>
                            </article>
                        </div>
                    </div>

                </div>

            </div>--%>
        </article>
        <!-- WIDGET END -->

    </div>
</section>
