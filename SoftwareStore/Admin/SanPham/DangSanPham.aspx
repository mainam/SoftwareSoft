<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminPage.Master" AutoEventWireup="true" CodeBehind="DangSanPham.aspx.cs" Inherits="SoftwareStore.Admin.SanPham.DangSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HolderScript" runat="server">


    <script>
        CKEditorSetup.InputContent("<%=txtDescription.ClientID%>");
        var DangSanPham = {
            readURL: function (input) {

                var val = $(input).val();

                switch (val.substring(val.lastIndexOf('.') + 1).toLowerCase()) {
                    case 'gif': case 'jpg': case 'png':
                        break;
                    default:
                        $(input).val('');
                        alertSmallBox("Please select image", "Only support *.png, *.jpg, *.gif", "Error");
                        return;
                }

                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#imgAvatarUpdate')
                          .attr('src', e.target.result);
                        $("#inputFileAvatar2").val(input.value);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            },
            Save: function () {
                if ($("#<%=txtTenSanPham.ClientID%>").val() == "") {
                    alertSmallBox("Vui lòng nhập tên phần mềm", "", "error");
                    return;
                }

                if ($("#<%=cbListCategory.ClientID%>").val() == null) {
                    alertSmallBox("Vui lòng chọn chuyên mục", "", "error");
                    return;
                }

                debugger;
                if (CKEditorSetup.GetData("<%=txtDescription.ClientID%>").trim() == "") {
                alertSmallBox("Vui lòng nhập mô tả cho sản phẩm", "", "error");
                return;
            }

            confirm("Xác nhận!", "Bạn có muốn lưu nội dung trong trang này", "OK Lưu", "Hủy", function () {
                AJAXFunction.CallAjax("POST", "/Admin/SanPham/DangSanPham.aspx", "Save", {
                            <%--                    subject: $("#<%=txtTenSanPham.ClientID%>").val(),
                    from: $("#<%=cbListCategory.ClientID%>").val(),
                    to: $("#<%=cbListTo.ClientID%>").val(),
                    cc: $("#<%=cbListCC.ClientID%>").val() == null ? [] : $("#<%=cbListCC.ClientID%>").val(),
                    content: CKEditorSetup.GetData("<%=txtDescription.ClientID%>").trim()--%>
                    }, function (response) {
                        if (response.Status) {
                            alertSmallBox("Send Mail successful", "1 second ago", "success");
                            SendMail.Clear();
                        }
                        else {
                            alertSmallBox("Send Mail failed", "1 second ago", "error");
                        }

                    });
                });
            }

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HolderContent" runat="server">

    <section id="widget-grid" class="">
        <div>
            <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
                <div class="alert alert-info alert-block" style="">
                    <h4 class="alert-heading">Đăng sản phẩm</h4>
                </div>

            </div>
        </div>

        <div class="row">

            <article class="col-sm-12 col-md-12 col-lg-12">
                <div class="jarviswidget jarviswidget-color-pink" id="task_content" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">
                    <header>
                        <span class="widget-icon"><i class="fa fa-edit"></i></span>
                        <h2>Nhập thông tin sản phẩm </h2>

                    </header>

                    <div>

                        <div class="jarviswidget-editbox">
                        </div>
                        <!-- end widget edit box -->

                        <!-- widget content -->
                        <div class="widget-body no-padding">
                            <div class="smart-form">
                                <fieldset>

                                    <section style="margin-bottom: 10px;">
                                        <label class="labelform labelform">Tên phần mềm</label>
                                        <label class="input">
                                            <i class="icon-append fa fa-user"></i>
                                            <input type="text" name="title" id="txtTenSanPham" placeholder="Tên phần mềm muốn bán" runat="server" />
                                        </label>
                                    </section>
                                    <section style="margin-bottom: 10px;">
                                        <label class="labelform labelform">Ảnh bìa</label>
                                        <fieldset style="padding-top: 0px; margin-top: 15px;">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="width: 100px;">
                                                        <img src="/images/no_image.jpg" id="imgAvatarUpdate" style="width: 100px; border: 1px dotted beige; background: black;" />
                                                    </td>
                                                    <td style="padding-left: 10px; vertical-align: top;">
                                                        <label for="file" class="input input-file">
                                                            <div class="button">
                                                                <input type="file" name="file-issue" id="inputFileAvatar" onchange="DangSanPham.readURL(this);" accept="image/*" />Browse
                                                            </div>
                                                            <input type="text" placeholder="Chọn ảnh bìa cho phần mềm" id="inputFileAvatar2" readonly="" class="form-input">
                                                        </label>
                                                    </td>
                                                </tr>
                                            </table>

                                        </fieldset>
                                    </section>
                                    <section style="margin-bottom: 10px;">
                                        <label class="labelform labelform">Đường dẫn</label>
                                        <label for="file" class="input input-file">
                                            <div class="button">
                                                <input type="file" name="file-software" id="inputFileSoftware" onchange="$('#inputFileSoftware2').val($(this).val())"/>Browse
                                            </div>
                                            <input type="text" placeholder="Chọn file muốn upload" id="inputFileSoftware2" readonly="" class="form-input">
                                        </label>

                                    </section>
                                    <section style="margin-bottom: 10px;">
                                        <label class="labelform labelform">Bảo hành (tháng)</label>
                                        <label class="input">
                                            <i class="icon-append fa fa-user"></i>
                                            <input type="number" name="title" id="txtBaoHanh" placeholder="Bảo hành bao nhiêu tháng" runat="server" />
                                        </label>
                                    </section>
                                    <section style="margin-bottom: 10px;">
                                        <label class="labelform labelform">Giá gốc</label>
                                        <label class="input">
                                            <i class="icon-append fa fa-user"></i>
                                            <input type="number" name="title" id="txtGiaGoc" placeholder="Giá phần mềm" runat="server" />
                                        </label>
                                    </section>
                                    <section style="margin-bottom: 10px;">
                                        <label class="labelform labelform">Giảm giá (%)</label>
                                        <label class="input">
                                            <i class="icon-append fa fa-user"></i>
                                            <input type="number" name="title" id="Text1" placeholder="Giảm giá bao nhiêu %" runat="server" />
                                        </label>
                                    </section>
                                    <section style="margin-bottom: 10px;" runat="server" id="divTaskForIdea">
                                        <label class="labelform labelform">Chuyên mục</label>
                                        <label class="input">
                                            <select class="select2" runat="server" id="cbListCategory">
                                            </select>
                                        </label>
                                    </section>
                                    <section style="margin-bottom: 10px;" runat="server" id="Section1">
                                        <label class="labelform labelform">Trạng thái</label>
                                        <label class="input">
                                            <select class="select2" runat="server" id="cbListStatus">
                                            </select>
                                        </label>
                                    </section>
                                    <section>
                                        <label class="labelform labelform">Mô tả sản phẩm</label>
                                        <label class="input">
                                            <i class="icon-append fa fa-edit"></i>
                                            <textarea name="txtDescription" id="txtDescription" runat="server"></textarea>
                                        </label>
                                    </section>
                                    <div>
                                    </div>
                                </fieldset>
                                <footer>
                                    <input type="button" class="btn btn-primary" value="Lưu" style="width: 90px;" onclick="DangSanPham.Save()" />
                                    <input type="button" class="btn btn-default" onclick="SendMail.Clear()" style="width: 90px;" value="Làm lại" />
                                    <input type="button" class="btn btn-default" onclick="SendMail.Clear()" id="btnXoa" runat="server" style="width: 90px;" value="Xóa" />
                                </footer>
                            </div>
                        </div>
                    </div>
                </div>

            </article>

        </div>



    </section>
</asp:Content>
