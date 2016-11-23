<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendMailNotification.aspx.cs" Inherits="DeviceManagement.Admin.Config.SendMailNotification" %>

<script>
    pageSetUp();
</script>
<div class="row">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark"><i class="fa fa-fw fa-clock-o"></i>Log Transfer Device</h1>
    </div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-sm-6 col-md-6 col-lg-6">
            <div class="jarviswidget jarviswidget-color-pink" id="task_content" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">
                <header>
                    <span class="widget-icon"><i class="fa fa-clock-o"></i></span>
                    <h2>Send Mail Task</h2>
                </header>

                <div>


                    <div class="widget-body no-padding smart-form">


                        <fieldset>
                            <div class="row" style="margin: 0">
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle" checked="" runat="server" id="Checkbox3"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;List task delay</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle" runat="server" id="Checkbox4"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;List task daily report</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;List task weekly report</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;List task deadline today</label>
                                <div class="note note-success">Thanks for your selection.</div>
                            </div>
                        </fieldset>

                        <footer>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <button type="button" class="btn btn-default" onclick="window.history.back();">Back</button>
                        </footer>
                    </div>

                </div>
            </div>

        </article>
        <article class="col-sm-6 col-md-6 col-lg-6">
            <div class="jarviswidget jarviswidget-color-pink" id="Div1" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">
                <header>
                    <span class="widget-icon"><i class="fa fa-clock-o"></i></span>
                    <h2>Send Mail Device</h2>
                </header>

                <div>


                    <div class="widget-body no-padding smart-form">


                        <fieldset>
                            <div class="row" style="margin: 0">
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle" checked="" runat="server" id="Checkbox1"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;Send mail New Approve Device</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle" runat="server" id="Checkbox2"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;Send mail confirm keeping device</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;Confirm inventory</label>
                                <div class="note note-success">Thanks for your selection.</div>
                            </div>
                        </fieldset>

                        <footer>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <button type="button" class="btn btn-default" onclick="window.history.back();">Back</button>
                        </footer>
                    </div>
                </div>
            </div>

        </article>


        <article class="col-sm-12 col-md-12 col-lg-6 sortable-grid ui-sortable">

            <!-- Widget ID (each widget will need unique ID)-->

            <!-- end widget -->

            <div class="jarviswidget jarviswidget-color-pink" id="Div2" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">

                <header role="heading">
                    <span class="widget-icon"><i class="fa fa-check txt-color-green"></i></span>
                    <h2>Config </h2>

                </header>

                <!-- widget div-->
                <div role="content">

                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->

                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body no-padding smart-form">
                        <header>
                            abc
                        </header>

                        <fieldset>
                            <div class="row" style="margin: 0">
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle" checked="" runat="server" id="deviceapprove"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;Send mail New Approve Device</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle" runat="server" id="devicekeepingdevice"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;Send mail confirm keeping device</label>
                                <label class="toggle state-success" style="border-bottom: 1px dashed rgba(0,0,0,.2); padding-bottom: 10px;">
                                    <input type="checkbox" name="checkbox-toggle"><i data-swchon-text="ON" data-swchoff-text="OFF"></i><b class="fa fa-bullhorn"></b>&nbsp;Confirm inventory</label>
                                <div class="note note-success">Thanks for your selection.</div>
                            </div>
                        </fieldset>

                        <footer>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <button type="button" class="btn btn-default" onclick="window.history.back();">Back</button>
                        </footer>
                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->

            </div>
        </article>
    </div>



</section>
