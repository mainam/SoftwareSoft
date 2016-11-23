<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConfirmDevice.aspx.cs" Inherits="SoftwareStore.device.ConfirmDevice" %>

<%@ Register Src="~/device/Controls/ctMyConfirm.ascx" TagPrefix="uc1" TagName="ctMyConfirm" %>
<%@ Register Src="~/device/Controls/ctTeamConfirm.ascx" TagPrefix="uc1" TagName="ctTeamConfirm" %>



<script>
    var typeinventory = "user";
    var inventoryid = 0;
</script>
<div id="pageconfirmdevice">

    <link href="/css/common.css" rel="stylesheet" />
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <style>
        .tabs-left > .tab-content {
            margin-left: 210px;
        }

        .smart-form header {
            font-weight: bold;
            margin-top: 0px;
        }

        .jarviswidget {
            display: block !important;
        }
    </style>
    <!-- widget grid -->
    <section id="widget-grid" class="">
        <div class="row" style="margin-bottom: 5px;">
            <div class="alert alert-info alert-block" style="margin-left: 10px;">
                <h4 class="alert-heading">Request inventory!</h4>
            </div>
            <article class="col-sm-12 col-md-12 col-lg-12">
                <div class="jarviswidget jarviswidget-color-pink" id="confirmation" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-fullscreenbutton="false" data-widget-attstyle="jarviswidget-color-pink">
                    <header>
                        <h2>Request inventory </h2>
                    </header>

                    <!-- widget div-->
                    <div>
                        <div class="widget-body">
                            <div class="tabs-left">
                                <ul class="nav nav-tabs tabs-left" id="demo-pill-nav" style="min-height: 600px; margin-right: 0px;">
                                    <li class="active">
                                        <a href="#tabMyRequest" data-toggle="tab" style="color: #555 !important"><i class="fa fa-tags"></i>&nbsp My Request</a>
                                    </li>
                                    <li style="width: 200px;">
                                        <a href="#tabTeamRequest" data-toggle="tab" style="color: #555 !important"><i class="fa fa-list"></i>&nbsp Team Request</a>
                                    </li>
                                </ul>
                                <div class="tab-content" id="divtabcontent">
                                    <div class="tab-pane" id="tabTeamRequest" style="float: left; width: 100%;">
                                        <uc1:ctTeamConfirm runat="server" ID="ctTeamConfirm" />
                                    </div>
                                    <div class="tab-pane active" id="tabMyRequest" style="float: left">
                                        <uc1:ctMyConfirm runat="server" ID="ctMyConfirm" />
                                    </div>
                                    <div style="clear: both"></div>
                                </div>
                            </div>

                        </div>
                        <!-- end widget content -->

                    </div>
                    <!-- end widget div -->

                </div>
                <!-- end widget -->

            </article>
        </div>

    </section>
    <div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
    <script type="text/javascript">

        var ConfirmDevicePage = {
            LoadData: function () {
                AJAXFunction.CallAjax("POST", "/device/confirmdevice.aspx", "LoadData", {
                    numberinpage: 8
                }, function (obj) {
                    

                    if (obj.Status) {
                        var divtotalitem = $('#divtotalitemMyRequest').empty();
                        divtotalitem.append('Total Request: ' + obj.Data.UserInventory.TotalItem);
                        var _totalpage = Math.round(obj.Data.UserInventory.TotalItem / 8);
                        var totalpage = ((obj.Data.UserInventory.TotalItem / 8) > _totalpage) ? _totalpage + 1 : _totalpage;
                        MyRequest.LoadTable(obj.Data.UserInventory.Data);
                        AJAXFunction.CreatePaging($('#divpagingMyRequest'), 1, totalpage, MyRequest.LoadData);

                        var divtotalitem = $('#divtotalitemTeamRequest').empty();
                        divtotalitem.append('Total Request: ' + obj.Data.LeaderInventory.TotalItem);
                        var _totalpage = Math.round(obj.Data.LeaderInventory.TotalItem / 8);
                        var totalpage = ((obj.Data.LeaderInventory.TotalItem / 8) > _totalpage) ? _totalpage + 1 : _totalpage;
                        TeamRequest.LoadTable(obj.Data.LeaderInventory.Data);
                        AJAXFunction.CreatePaging($('#divpagingTeamRequest'), 1, totalpage, TeamRequest.LoadData);
                    }


                  
                });

            }
        }



        $(document).ready(function () {
            ConfirmDevicePage.LoadData();
        });

        $("#demo-pill-nav > li").click(function () {
            $("#demo-pill-nav").css("min-height", $($(this).find("a").attr("href")).height());
        });
        $("#divtabcontent > div").resize(function () {
            $("#demo-pill-nav").css("min-height", $($("#demo-pill-nav > li.active").find("a").attr("href")).height());
        });
        pageSetUp();


    </script>
</div>
