<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPage.Master" AutoEventWireup="true" CodeBehind="ChuyenMucMgr.aspx.cs" Inherits="SoftwareStore.Admin.ChuyenMucMgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="widget-grid" class="">
        <div>
            <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
                <div class="alert alert-info alert-block" style="">
                    <h4 class="alert-heading">Quản lý chuyên mục</h4>
                </div>

                <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable pull-right">
                    <div class="col-md-12" style="padding: 0px;">
                        <div class="icon-addon addon-md">
                            <input id="inputSearch" type="search" placeholder="Nhập từ khóa để tìm kiếm" class="form-control" aria-controls="dt_basic" runat="server" />
                            <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                        </div>
                    </div>
                </article>
            </div>
        </div>


        <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="listrequest" style="margin-bottom: 0px;" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>Danh sách các chuyên mục</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->

                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px;">Show: 14<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                                <ul class="dropdown-menu pull-right js-status-update">
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(5);">5</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(10);">10</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(15);">15</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(20);">20</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(50);">50</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(100);">100</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </header>
                    <!-- widget div-->

                    <div>

                        <!-- widget edit box -->
                        <div class="jarviswidget-editbox">
                            <!-- This area used as dropdown edit box -->

                        </div>
                        <!-- end widget edit box -->

                        <!-- widget content -->
                        <div class="widget-body">

                            <div class="table-responsive  smart-form">

                                <div style="overflow: auto;">
                                    <table id="datatable_tabletools" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="theadtable" style="width: 20px">
                                                    <label class="checkbox">
                                                        <input type="checkbox" id="btncheck" /><i></i>
                                                    </label>
                                                </th>
                                                <th class="theadtable" style="width: 200px">Tên chuyên mục</th>
                                                <th class="theadtable" style="width: 200px">Chuyên mục cha</th>
                                                <th class="theadtable" >Mô tả</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div>
                                    <div id="divtotalitem" style="float: left; margin-top: 10px; font-weight: bold;">
                                    </div>

                                    <div id="divpaging" style="float: right; margin-top: 10px;">
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- end widget content -->

                    </div>
                    <!-- end widget div -->
                </div>

            </article>
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div style="padding-top: 20px; clear: both;">
                    <input type="button" class="btn btn-primary pull-left" id="btnReborrow" style="margin-right: 5px; width: 255px;" value="Borrow these devices have returned" onclick="BorrowDeviceReturned();" />
                    <input type="button" class="btn btn-primary pull-right" id="btnDelete" disabled="disabled" style="width: 95px;" value="Delete" onclick="Delete();" />
                    <input type="button" class="btn btn-primary pull-right" id="btnCancel" disabled="disabled" style="margin-right: 5px; width: 95px;" value="Cancel" onclick="Cancel();" />
                </div>
            </article>

            <!-- WIDGET END -->

        </div>

    </section>

</asp:Content>
