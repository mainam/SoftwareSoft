<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommonManagement.aspx.cs" Inherits="SoftwareStore.device.CommonManagement" %>

<link href="/css/common.css" rel="stylesheet" />
<style>
    .tabs-left > .tab-content {
        margin-left: 210px;
    }

    .smart-form header {
        font-weight: bold;
        margin-top: 0px;
    }
</style>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="row" style="margin-bottom: 5px;">
        <div class="alert alert-info alert-block" style="margin-left: 10px;">
            <h4 class="alert-heading">Common Management!</h4>
            Welcome to the site common management. Here, you can manage categorys device, model device and cabinet.
        </div>
        <article class="col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-pink" id="CommonManagement" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-pink">
                <header>
                    <h2>Common Management </h2>
                </header>

                <!-- widget div-->
                <div>
                    <div class="widget-body">
                        <div class="tabs-left">
                            <ul class="nav nav-tabs tabs-left" id="demo-pill-nav" style="min-height: 600px; margin-right: 0px;">
                                <li class="active">
                                    <a href="#tabCategory" data-toggle="tab"  style="color: #555 !important"><i class="fa fa-tags" ></i>&nbsp Category Management</a>
                                </li>
                                <li style="width: 200px;">
                                    <a href="#tabModel" data-toggle="tab"  style="color: #555 !important"><i class="fa fa-list"></i>&nbsp Model Management</a>
                                </li>
                                <li style="width: 200px;">
                                    <a href="#tabCabinet" data-toggle="tab"  style="color: #555 !important"><i class="fa fa-inbox"></i>&nbsp Cabinet Management </a>
                                </li>
                            </ul>
                            <div class="tab-content smart-form">
                                <div class="tab-pane " id="tabCabinet">
                                </div>
                                <div class="tab-pane" id="tabModel">
                                </div>
                                <div class="tab-pane active" id="tabCategory">
                                </div>
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

<script type="text/javascript">

    pageSetUp();

    $(document).ready(function () {
        loadURL("/device/common/cabinetmanagement.aspx", $("#tabCabinet"));
        loadURL("/device/common/modelmanagement.aspx", $("#tabModel"));
        loadURL("/device/common/categorymanagement.aspx", $("#tabCategory"));
    });

</script>
