<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPage.Master" AutoEventWireup="true" CodeBehind="SanPhamCuaToi.aspx.cs" Inherits="SoftwareStore.Admin.SanPham.SanPhamCuaToi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HolderScript" runat="server">
    <script src="/js/selportalscript.js"></script>
    <script src="/js/validate.js"></script>
    <script type="text/javascript">
        var SanPhamScript = {
            IdEdit: 0,
            ListHasSelected: [],
            CurrentPage: 0,
            NumberInpage: 10,
            Data: [],
            Type: 0,
            ChangeType: function (number) {
                $("#changeType").text(number == 0 ? "Tất cả" : number == 1 ? "Đang bán" : "Đang đóng");
                SanPhamScript.Type = number;
                SanPhamScript.LoadData(1);
            },
            LoadData: function (page) {
                currentpage = page;
                var keyword = $('#<%=inputSearch.ClientID%>').val();
                var numberinpage = SanPhamScript.NumberInpage;
                AJAXFunction.CallAjax("POST", "/admin/sanpham/sanphamcuatoi.aspx", "GetListProduct", {
                    type: SanPhamScript.Type,
                    keyword: keyword,
                    currentpage: page,
                    numberinpage: numberinpage,
                },
                function (obj) {
                    if (obj.Status) {
                        var divtotalitem = $('#divtotalitem').empty();
                        divtotalitem.append('Tổng số: ' + obj.TotalItem)

                        var _totalpage = Math.round(obj.TotalItem / numberinpage);
                        var totalpage = Common.GetTotalPage(SanPhamScript.NumberInpage, obj.TotalItem);
                        SanPhamScript.Data = obj.Data;
                        SanPhamScript.ListHasSelected = [];
                        $('#btncheck').get(0).checked = false;
                        SanPhamScript.LoadTable(obj.Data, ((parseInt(page) - 1) * numberinpage));
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, SanPhamScript.LoadData);
                    }
                });

            },
            CreateAction: function (SanPham) {
                var btnedit = $('<label class="btn btn-xs btn-default">');
                btnedit.append($('<i class="fa fa-edit"/>'))
                btnedit.attr('dataid', SanPham.Id);
                btnedit.click(function () {
                    var id = $(this).attr("dataid");
                    location.href="/admin#sanpham/dangsanpham.aspx?id="+id;
                });

                var btndel = $('<label class="btn btn-xs btn-default" style="margin-left:1px;">');
                btndel.attr('dataid', SanPham.Id);
                btndel.append($('<i class="fa fa-times"/>'))

                btndel.click(function () {
                    var id = $(this).attr('dataid');
                    var callback = function () {
                        AJAXFunction.CallAjax("POST", "/admin/SanPham/SanPhamCuaToi.aspx", "DeleteProduct", {
                            arrid: [id]
                        },
                        function (response) {
                            var status = response.Status;
                            if (status) {
                                alertSmallBox("Xóa thành công!", "1 giây trước!!", "Success");
                                SanPhamScript.LoadData(SanPhamScript.CurrentPage);
                            }
                            else
                                alertSmallBox("Xóa thất bại \n " + response.Data, "1 giây trước!!", "Error");
                        });
                    }
                    confirm("Xác nhận", "Bạn có muốn xóa phần mềm này!!", "OK Xóa", "Hủy", callback);
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
                    EmptyTable(table, "8")
                }
                for (i = 0; i < list.length; i++) {
                    var tr = $('<tr>');
                    var td = SanPhamScript.CreateCheckBox(list[i].Id, false, false, true);
                    tr.append(td);

                    var td = createCell(list[i].Name);
                    tr.append(td);

                    var td = createCell(list[i].SellerName);
                    tr.append(td);
                    var td = createCell(list[i].Price);
                    tr.append(td);
                    var td = createCell(list[i].Discount + " %");
                    tr.append(td);
                    var td = createCell(list[i].NumberGuaranteeDate + " tháng");
                    tr.append(td);
                    var td = createCell(list[i].Category);
                    tr.append(td);
                    var td = $("<td>").append(list[i].Status == 1 ? Common.CreateLabelStyleSuccess(list[i].StatusName) : Common.CreateLabelStyleWarning(list[i].StatusName));
                    tr.append(td);
                    var td = createCell(list[i].ClosedDate);
                    tr.append(td);

                    tr.append(SanPhamScript.CreateAction(list[i]));




                    table.append(tr);

                }
            },
            CreateCheckBox: function (id, allowborrow, check) {
                var td = $('<td>');
                var label = $('<label class="checkbox">');
                var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemcheckbox">');
                if (check) {
                    checkbox.attr("checked", "checked");
                }
                checkbox.attr('dataid', id);
                label.append(checkbox);
                label.append($('<i>'));
                checkbox.click(function () {
                    if (this.checked) {
                        SanPhamScript.ListHasSelected.push($(this).attr('dataid'));
                    }
                    else {
                        $('#btncheck')[0].checked = false;
                        var index = SanPhamScript.ListHasSelected.indexOf($(this).attr('dataid'));
                        if (index != -1)
                            SanPhamScript.ListHasSelected.splice(index, 1);
                    }
                });
                td.append(label);
                return td;
            },
            Delete: function () {
                if (SanPhamScript.ListHasSelected.length == 0) {
                    alertSmallBox("Chọn phần mềm cần xóa", "", "error");
                    return;
                }
                var callback = function () {
                    AJAXFunction.CallAjax("POST",
                        "/admin/SanPham/SanPhamCuaToi.aspx", "DeleteProduct", {
                            arrid: SanPhamScript.ListHasSelected,
                        }, function (response) {
                            if (response.Status) {
                                SanPhamScript.ListHasSelected = [];
                                $('#btncheck')[0].checked = false;
                                SanPhamScript.LoadData(1);
                                alertSmallBox("Xóa thành công", "", "success");
                            }
                            else {
                                alertSmallBox("Xóa không thành công", response.Data, "error");
                            }

                        });
                };
                confirm("Xác nhận", "Bạn có muốn xóa các phần mềm đã chọn!!", "OK Xóa", "Cancel", callback);
            }, CreateNew: function () {
                SanPhamScript.IdEdit = "";
                location.href = "/admin#sanpham/dangsanpham.aspx?id=" + 0;
            }, ShowNumber: function (number) {
                SanPhamScript.NumberInpage = number;
                $("#btnSelectNumberItem").text("Hiện: " + number);
                SanPhamScript.LoadData(1);
            }



        }
        $('#<%=inputSearch.ClientID%>').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                SanPhamScript.LoadData(1);
            }
        });

        SanPhamScript.LoadData(1);
        $('#btncheck').click(function () {
            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemcheckbox"]');
            if (this.checked) {
                for (var i = 0; i < input.length; i++) {
                    input[i].checked = true;
                    var dataid = $(input[i]).attr("dataid");
                    SanPhamScript.ListHasSelected.push(dataid);
                }
            }
            else {
                for (var i = 0; i < input.length; i++) {
                    input[i].checked = false;
                }
                SanPhamScript.ListHasSelected = [];
            }
        });



    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HolderContent" runat="server">
    <section id="widget-grid" class="">
        <div>
            <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
                <div class="alert alert-info alert-block" style="">
                    <h4 class="alert-heading">Sản phẩm của tôi</h4>
                </div>

                <article class="col-xs-12 col-sm-3 col-md-3 col-lg-12 sortable-grid ui-sortable pull-right">
                    <div class="col-md-6" style="padding: 0px;">
                        <div class="col-md-6" style="padding: 0px;">
                            <div class="btn-group">
                                <button class="btn btn-primary" id="changeType">
                                    Tất cả
                                </button>
                                <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ChangeType(0)">Tất cả</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ChangeType(1)">Đang bán</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ChangeType(2)">Đang đóng</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-3 pull-right" style="padding: 0px;">
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
                <div class="jarviswidget  jarviswidget-color-teal" id="listproduct" style="margin-bottom: 0px;" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>Danh sách các sản phẩm</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->

                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberItem" style="width: 100px;">Hiện: 10<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                                <ul class="dropdown-menu pull-right js-status-update">
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ShowNumber(5);">5</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ShowNumber(10);">10</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ShowNumber(15);">15</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ShowNumber(20);">20</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ShowNumber(50);">50</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="SanPhamScript.ShowNumber(100);">100</a>
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
                                                <th class="theadtable" style="width: 150px">Tên phần mềm</th>
                                                <th class="theadtable" >Người bán</th>
                                                <th class="theadtable" style="width: 70px">Giá bán</th>
                                                <th class="theadtable" style="width: 70px">Giảm giá</th>
                                                <th class="theadtable" style="width: 70px">Bảo hành</th>
                                                <th class="theadtable" >Chuyên mục</th>
                                                <th class="theadtable" style="width: 70px">Trạng thái</th>
                                                <th class="theadtable" style="width: 70px">Ngày đóng</th>
                                                <th class="theadtable" style="width: 70px">Hành động</th>
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
                    <a href="javascript:void(0);" class="btn btn-labeled btn-primary" id="btnAdd" onclick="SanPhamScript.CreateNew();"><span class="btn-label"><i class="glyphicon glyphicon-camera"></i></span>Thêm </a>
                    <a href="javascript:void(0);" class="btn btn-labeled btn-danger" id="btnDelete" onclick="SanPhamScript.Delete();"><span class="btn-label"><i class="glyphicon glyphicon-trash"></i></span>Xóa </a>
                </div>
            </article>

            <!-- WIDGET END -->

        </div>

    </section>

</asp:Content>
