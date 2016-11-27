<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPage.Master" AutoEventWireup="true" CodeBehind="TatCaGiaoDich.aspx.cs" Inherits="SoftwareStore.Admin.GiaoDich.TatCaGiaoDich" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HolderScript" runat="server">
    <script src="/js/selportalscript.js"></script>
    <script type="text/javascript">
        var GiaoDichScript = {
            CurrentPage: 0,
            NumberInpage: 10,
            Data: [],
            LoadData: function (page) {
                currentpage = page;
                var keyword = $('#<%=inputSearch.ClientID%>').val();
                var numberinpage = GiaoDichScript.NumberInpage;
                AJAXFunction.CallAjax("POST", "/admin/giaodich/tatcagiaodich.aspx", "GetListTransaction", {
                    keyword: keyword,
                    currentpage: page,
                    numberinpage: numberinpage,
                },
                function (obj) {
                    if (obj.Status) {
                        var divtotalitem = $('#divtotalitem').empty();
                        divtotalitem.append('Tổng số: ' + obj.TotalItem)
                        var _totalpage = Math.round(obj.TotalItem / numberinpage);
                        var totalpage = Common.GetTotalPage(GiaoDichScript.NumberInpage, obj.TotalItem);
                        GiaoDichScript.Data = obj.Data;
                        GiaoDichScript.LoadTable(obj.Data, ((parseInt(page) - 1) * numberinpage));
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, GiaoDichScript.LoadData);
                    }
                });

            },
            CreateAction: function (category) {
                var btnedit = $('<label class="btn btn-xs btn-default">');
                btnedit.append($('<i class="fa fa-edit"/>'))
                btnedit.attr('dataid', category.Id);
                btnedit.click(function () {
                    GiaoDichScript.IdEdit = $(this).attr('dataid');
                    AJAXFunction.ShowModal("remoteModal", "/admin/GiaoDich/dialog/AddGiaoDich.aspx?id=" + GiaoDichScript.IdEdit);
                });

                var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
                btndel.attr('dataid', category.Id);
                btndel.append($('<i class="fa fa-times"/>'))

                btndel.click(function () {
                    var id = $(this).attr('dataid');
                    var callback = function () {
                        AJAXFunction.CallAjax("POST", "/admin/GiaoDich/GiaoDichmgr.aspx", "DeleteCategory", {
                            arrid: [id]
                        },
                        function (response) {
                            var status = response.Status;
                            if (status) {
                                alertSmallBox("Xóa thành công!", "1 giây trước!!", "Success");
                                GiaoDichScript.LoadData(GiaoDichScript.CurrentPage);
                            }
                            else
                                alertSmallBox("Xóa thất bại \n " + response.Data, "1 giây trước!!", "Error");
                        });
                    }
                    confirm("Xác nhận", "Bạn có muốn xóa chuyên mục này!!", "OK Xóa", "Hủy", callback);
                });
                var td = $('<td>');
                td.append(btnedit);
                td.append(btndel);
                return td;
            },
            LoadTable: function (list, startindex) {
                var table = $('#datatable_tabletools > tbody');
                table.empty();
                if (list.length == 0) {
                    EmptyTable(table, "7")
                }
                for (i = 0; i < list.length; i++) {
                    var tr = $('<tr>');

                    var td = createCell(list[i].Type);
                    tr.append(td);
                    var td = createCell(list[i].CreatedDate);
                    tr.append(td);
                    var td = createCell(list[i].SourceName);
                    tr.append(td);
                    var td = createCell(list[i].DesName);
                    tr.append(td);
                    var td = createCell(list[i].Value);
                    tr.append(td);
                    var td = createCell(list[i].InvokeId);
                    tr.append(td);
                    var td = createCell(list[i].Description);
                    tr.append(td);
                    table.append(tr);

                }
            },
            ShowNumber: function (number)
            {
                GiaoDichScript.NumberInpage = number;
                $("#btnSelectNumberItem").text("Hiện: " + number);
                GiaoDichScript.LoadData(1);
            }



        }
        $('#<%=inputSearch.ClientID%>').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                GiaoDichScript.LoadData(1);
            }
        });

        GiaoDichScript.LoadData(1);



    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HolderContent" runat="server">
    <section id="widget-grid" class="">
        <div>
            <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
                <div class="alert alert-info alert-block" style="">
                    <h4 class="alert-heading">Tất cả giao dịch</h4>
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
                <div class="jarviswidget  jarviswidget-color-teal" id="listmytransaction" style="margin-bottom: 0px;" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>Danh sách các giao dịch</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->

                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberItem" style="width: 100px;">Hiện: 10<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                                <ul class="dropdown-menu pull-right js-status-update">
                                    <li>
                                        <a href="javascript:void(0);" onclick="GiaoDichScript.ShowNumber(5);">5</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="GiaoDichScript.ShowNumber(10);">10</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="GiaoDichScript.ShowNumber(15);">15</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="GiaoDichScript.ShowNumber(20);">20</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="GiaoDichScript.ShowNumber(50);">50</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="GiaoDichScript.ShowNumber(100);">100</a>
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
                                                <th class="theadtable" style="width: 100px">Loại</th>
                                                <th class="theadtable" style="width: 100px">Ngày tạo</th>
                                                <th class="theadtable" style="width: 150px">Người Mua</th>
                                                <th class="theadtable" style="width: 150px">Người Bán</th>
                                                <th class="theadtable" style="width: 100px">Số tiền</th>
                                                <th class="theadtable" style="width: 50px">Hóa đơn</th>
                                                <th class="theadtable">Mô tả</th>
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
 
        </div>

    </section>

</asp:Content>
