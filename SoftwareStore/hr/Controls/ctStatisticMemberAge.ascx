<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctStatisticMemberAge.ascx.cs" Inherits="SoftwareStore.hr.Controls.ctStatisticMemberAge" %>
<div class="jarviswidget  jarviswidget-color-teal" id="idAge" runat="server" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-bar-chart-o"></i></span>
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
                    <div id="piechartage" runat="server" class="chart no-padding" style="height: 525px; margin-top: -115px; margin-bottom: -90px;"></div>
                </article>
            </div>
        </div>

    </div>

</div>
<script>

    var AgeChart = {
        listdata: JSON.parse('<%=SoftwareStore.hr.HRStatistic.StatisticAge()%>'),
        //generateAllFlotCharts: function () {
        //    /* pie chart */


        //    if ($('#pie-chart-age').length) {

        //        var dataQuantity = [];
        //        for (var j = 0; j < AgeChart.listdata.length; j++) {
        //            var temp = { label: AgeChart.listdata[j].Type + ": " + AgeChart.listdata[j].Quantity, data: AgeChart.listdata[j].Quantity };
        //            dataQuantity.push(temp);
        //        }
        //        $.plot($('#pie-chart-age'), dataQuantity, {
        //            series: {
        //                pie: {
        //                    show: true,
        //                    innerRadius: 0.5,
        //                    radius: 1,
        //                    label: {
        //                        show: true,
        //                        radius: 2 / 3,
        //                        formatter: function (label, series) {
        //                            return '<div style="font-size:11px;text-align:center;padding:4px;color:white;">' + label + '<br/>' + Math.round(series.percent) + '%</div>';
        //                        },
        //                        threshold: 0.1
        //                    }
        //                }
        //            },
        //            legend: {
        //                show: true,
        //                noColumns: 1, // number of colums in legend table
        //                labelFormatter: null, // fn: string -> string
        //                labelBoxBorderColor: "#000", // border color for the little label boxes
        //                container: null, // container (as jQuery object) to put legend in, null means default on top of graph
        //                position: "ne", // position of default legend container within plot
        //                margin: [5, 10], // distance from grid edge to default legend container within plot
        //                backgroundColor: "#efefef", // null means auto-detect
        //                backgroundOpacity: 1 // set to 0 to avoid background
        //            },
        //            grid: {
        //                hoverable: true,
        //                clickable: true
        //            },
        //        });
        //    }
        //}
    }
    ShowChart(AgeChart.listdata, "Type", "Quantity", "<%=piechartage.ClientID%>");
</script>
