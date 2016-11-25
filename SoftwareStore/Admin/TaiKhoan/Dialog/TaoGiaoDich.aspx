<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaoGiaoDich.aspx.cs" Inherits="SoftwareStore.Admin.TaiKhoan.Dialog.TaoGiaoDich" %>


<style>
    .tdheader {
        background: #BBDEFB;
    }
</style>

<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divAddNewCategory">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center; text-transform: uppercase" runat="server" id="title">THỰC hiện giao dịch
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>

    <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 40px;">
        <label>
            Giao dịch của
        </label>
        <label class="input">
            <input type="text" id="txtTransactionFor" disabled="disabled" />
        </label>
        <label>
            Số tiền còn lại
        </label>
        <label class="input">
            <input type="text" id="txtMoneyLeft" disabled="disabled" />
        </label>
        <label>
            Số tiền
        </label>
        <label class="input">
            <input type="number" id="txtValue" />
        </label>
        <label>
            Nội dung giao dịch
        </label>
        <label class="input">
            <textarea rows="4" style="width: 100%; resize: vertical" id="txtDescription" />
        </label>
        <div class="inline-group">
            <label class="radio">
                <input type="radio" name="rdTransactionType" checked="" value="1">
                <i></i>Cộng tiền cho người này</label>
            <label class="radio">
                <input type="radio" name="rdTransactionType" value="2">
                <i></i>Trừ tiền của người này</label>
        </div>


        <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-top: 10px; margin-right: 0px; width: 90px;" data-dismiss="modal">HỦY</div>
        <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; margin-top: 10px; width: 90px;" onclick="TaoGiaoDichScript.ThemGiaoDichMoi(); ">LƯU</div>
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
    var taikhoan = TaiKhoanScript.GetById(TaiKhoanScript.IdEdit);
    if (taikhoan != null) {
        var name = taikhoan.FullName + " " + taikhoan.Email;
        $("#txtTransactionFor").val(name);
        $("#txtMoneyLeft").val(taikhoan.Money);
    }
    var TaoGiaoDichScript = {
        ThemGiaoDichMoi: function () {
            var type = $('input[name=rdTransactionType]:checked').val();
            var value = $("#txtValue").val();
            if (value == "") {
                alertSmallBox("Vui lòng nhập số tiền giao dịch", "1 giây trước!!", "Error");
                return;
            }
            var description = $("#txtDescription").val().trim();
            if(description=="")
            {
                alertSmallBox("Vui lòng nhập chi tiết giao dịch", "1 giây trước!!", "Error");
                return;
            }
            TaiKhoanScript.MakeATransaction(TaiKhoanScript.IdEdit, description, value, type);

        }

    }
</script>
