<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OTSurvey.aspx.cs" Inherits="SoftwareStore.hr.OTSurvey" %>

<%--<input runat="server" id="txtDataReport" type="text" />--%>
<section id="widget-grid" class="">

    <div class="row">

        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget  jarviswidget-color-teal" id="divOTSurveyData" runat="server" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <span class="widget-icon"><i class="fa fa-group"></i></span>
                    <h2>OT Survey</h2>
                </header>
                <!-- widget div-->
                <div>

                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                    </div>

                    <div class="widget-body no-padding smart-form">
                        <div style="overflow: hidden">
                            <iframe name="okhehe" src="http://107.113.53.35:8080/jasperserver/flow.html?_flowId=viewReportFlow&j_username=kim.yen&j_password=abc13579&reportUnit=%2Freports%2FSurvey%2FOT_Survey" style="width: 101%; height: 800px; margin-bottom: -30px; margin-top: -35px; margin-left: -10px;"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
</section>

<script>
    pageSetUp();
</script>