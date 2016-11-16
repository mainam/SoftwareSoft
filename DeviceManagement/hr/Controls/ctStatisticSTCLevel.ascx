<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctStatisticSTCLevel.ascx.cs" Inherits="DeviceManagement.hr.Controls.ctStatisticSTCLevel" %>
<div class="jarviswidget  jarviswidget-color-teal" id="idStc" runat="server" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-bar-chart-o"></i></span>
        <h2>STC Level</h2>
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
                    <div id="piechartstc" runat="server" class="chart no-padding" style="height: 525px; margin-top: -115px; margin-bottom: -90px;"></div>
                </article>
            </div>
        </div>

    </div>

</div>
<script>

    var StcChart = {
        listdata: JSON.parse('<%=DeviceManagement.hr.HRStatistic.StatisticSTCLevel()%>'),

    }
    ShowChart(StcChart.listdata, "Type", "Quantity", "<%=piechartstc.ClientID%>");
</script>
