<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaoTaiKhoan.aspx.cs" Inherits="SoftwareStore.Admin.TaiKhoan.Dialog.TaoTaiKhoan" %>


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
            Tài khoản
        </label>
        <label class="input">
            <input type="text" id="txtUserName" runat="server" />
        </label>
        <label>
            Họ tên
        </label>
        <label class="input">
            <input type="text" id="txtFullName" runat="server" />
        </label>
        <label>
            Email
        </label>
        <label class="input">
            <input type="text" id="txtEmail" runat="server" />
        </label>
        <label>
            Số điện thoại
        </label>
        <label class="input">
            <input type="text" id="txtPhoneNumber" runat="server" />
        </label>
        <label runat="server" id="inputPassword">
            Mật khẩu
        </label>
        <label class="input">
            <input type="password" id="txtPassword" />
        </label>
        <label>
            Xác Nhận Mật khẩu
        </label>
        <label class="input">
            <input type="password" id="txtConfirmPassword" />
        </label>
        <div class="inline-group">
            <label class="toggle state-success" style="margin-right: 20px;">
                <input type="checkbox" name="checkbox-toggle" checked="" runat="server" />
                <i data-swchon-text="ON" data-swchoff-text="OFF"></i>Kích hoạt</label>
        </div>


        <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-top: 10px; margin-right: 0px; width: 90px;" data-dismiss="modal">HỦY</div>
        <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; margin-top: 10px; width: 90px;" onclick="TaoTaiKhoanScript.ThemTaiKhoan(); ">LƯU</div>
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
    var TaoTaiKhoanScript = {
        ThemTaiKhoan: function () {

            var username = $("#txtUserName").val();
            if (username.trim() == "") {
                alertSmallBox("Vui lòng nhập tài khoản", "1 giây trước!!", "Error");
                return;
            }
            var fullname = $("#txtFullName").val();
            if (fullname.trim() == "") {
                alertSmallBox("Vui lòng nhập họ tên", "1 giây trước!!", "Error");
                return;
            }
            var email = $("#txtEmail").val();
            if (!validateEmail(email)) {
                alertSmallBox("Vui lòng nhập đúng định dạng email", "1 giây trước!!", "Error");
                return;
            }

            var type = $('input[name=rdTransactionType]:checked').val();
            var value = $("#txtValue").val();
            if (value == "") {
                alertSmallBox("Vui lòng nhập số tiền giao dịch", "1 giây trước!!", "Error");
                return;
            }
            var description = $("#txtDescription").val().trim();
            if (description == "") {
                alertSmallBox("Vui lòng nhập chi tiết giao dịch", "1 giây trước!!", "Error");
                return;
            }
        }
    }
</script>
