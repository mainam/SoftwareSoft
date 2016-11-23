<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctStatisticNumberPeopleInSel.ascx.cs" Inherits="SoftwareStore.hr.Controls.ctStatisticNumberPeopleInSel" %>
<div class="jarviswidget  jarviswidget-color-teal" id="idPeople" runat="server" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal" data-widget-fullscreenbutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-group"></i></span>
        <h2>The number of people in SEL</h2>
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
                    <div id="columnchartpeople" runat="server" class="chart no-padding" style="height: 300px; "></div>
                </article>
            </div>
        </div>

    </div>

</div>
<script>

    var StcChart = {
        listdata: JSON.parse('<%=SoftwareStore.hr.HRStatistic.StatisticQuantity()%>'),

    }
    ShowChart2(StcChart.listdata, "Type", ["Quantity"], "<%=columnchartpeople.ClientID%>");
</script>
