<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddChuyenMuc.aspx.cs" Inherits="SoftwareStore.Admin.ChuyenMuc.Dialog.AddChuyenMuc" %>


<style>
    .tdheader {
        background: #BBDEFB;
    }
</style>

<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divAddNewCategory">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="title">THÊM CHUYÊN MỤC
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>

    <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 40px;">
        <label>
            Tên chuyên mục
        </label>
        <label class="input">
            <input type="text" id="txtCategoryName" />
        </label>
        <label>
            Chuyên mục cha
        </label>
        <select runat="server" id="cbListCategory" class="select2">
        </select>
        <label>
            Thứ tự
        </label>
        <label class="input">
            <input type="number" id="txtOrder" />
        </label>
        <label>
            Mô tả
        </label>
        <label class="input">
            <textarea rows="2" style="width: 100%; resize: vertical" id="txtDescription" />
        </label>

        <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-top: 10px; margin-right: 0px; width: 90px;" data-dismiss="modal">HỦY</div>
        <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; margin-top: 10px; width: 90px;" onclick="ThemChuyenMucScript.ThemMoiChuyenMuc(); ">LƯU</div>
    </div>
</div>
<style>
    .select2 {
        width: 100%;
    }
</style>
<script>
    $(document).ready(function () {
        $("#divAddNewCategory").delay(500).fadeIn(500).verticalAlign(400);
    });
    $("#<%=cbListCategory.ClientID%>").select2();
    var chuyenmuc = ChuyenMucScript.GetById(ChuyenMucScript.IdEdit);
    if (chuyenmuc != null) {
        $("#txtCategoryName").val(chuyenmuc.Name);
        $("#txtDescription").val(chuyenmuc.Description);
        $("#txtOrder").val(chuyenmuc.Order);
        if (chuyenmuc.ParentId == 0)
            $("#<%=cbListCategory.ClientID%>").val(null);
        else
            $("#<%=cbListCategory.ClientID%>").val(chuyenmuc.ParentId);
    }
    var ThemChuyenMucScript = {
        ThemMoiChuyenMuc: function () {
            AJAXFunction.CallAjax("POST", "/admin/chuyenmuc/chuyenmucmgr.aspx", "AddCategory", { id: ChuyenMucScript.IdEdit, name: $("#txtCategoryName").val(), description: $("#txtDescription").val(), order: $("#txtOrder").val() == "" ? 0 : $("#txtOrder").val(), parent: $("#<%=cbListCategory.ClientID%>").val() == null ? 0 : $("#<%=cbListCategory.ClientID%>").val() }, function (response) {
                if (response.Status) {
                    if (ChuyenMucScript.IdEdit != 0)
                        alertSmallBox("Thêm chuyên mục thành công", "", "success");
                    else
                        alertSmallBox("Chỉnh sửa chuyên mục thành công", "", "success");
                    $('#remoteModal').modal("hide");
                    ChuyenMucScript.LoadData(1);
                }
                else {
                    alertSmallBox("Chỉnh sửa chuyên mục thất bại", response.Data, "error");
                }
            });

        }

    }
</script>
