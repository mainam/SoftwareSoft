<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dialogChangePassword.aspx.cs" Inherits="DeviceManagement.account.dialogChangePassword" %>

<style>
    .iconuser {
        color: orange;
    }

    .iconleader {
        color: red;
    }

    .iconteam {
        color: #3276b1;
    }
</style>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divchangepassword">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">CHANGE PASSWORD
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>
    <form runat="server" id="FormUpdateManDate">
        <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 20px;">
            <div class="row" style="margin-bottom: -20px;">
                <fieldset style="padding-top: 0px;">
                    <section>
                        <label class="label">Current Password</label>
                        <label class="input">
                            <i class="icon-append fa fa-lock"></i>
                            <input type="password" id="txtCurrentPassword">
                            <b class="tooltip tooltip-top-right">
                                <i class="fa fa-warning txt-color-teal"></i>
                                Enter current password</b>
                        </label>
                    </section>

                    <section>
                        <label class="label">New Password</label>
                        <label class="input">
                            <i class="icon-append fa fa-lock"></i>
                            <input type="password" id="txtNewPassword">
                            <b class="tooltip tooltip-top-right">
                                <i class="fa fa-warning txt-color-teal"></i>
                                Enter new password</b>
                        </label>
                    </section>

                    <section>
                        <label class="label">Confirm Password</label>
                        <label class="input">
                            <i class="icon-append fa fa-lock"></i>
                            <input type="password" id="txtConfirmPassword">
                            <b class="tooltip tooltip-top-right">
                                <i class="fa fa-warning txt-color-teal"></i>
                                Reenter new password</b>
                        </label>
                    </section>

                </fieldset>
                <section class="col col-6" style="text-align: right; float: right">
                    <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
                    <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; width: 90px;" onclick="UpdatePassWord.Update(); ">SAVE</div>
                </section>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <div style="clear: both;"></div>

</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#divchangepassword").delay(500).fadeIn(500).verticalAlign(370);
    });

    var UpdatePassWord = {
        Update: function () {
            var currentpassword = $("#txtCurrentPassword").val();
            var newpassword = $("#txtNewPassword").val();
            var confirmpassword = $("#txtConfirmPassword").val();
            if (newpassword != confirmpassword) {
                alertbox("Confirm password and New Password do not match");
                return;
            }
            if (newpassword == "" || confirmpassword == "" || currentpassword == "") {
                alertbox("Please fill out the fields below and submit the form");
                return;
            }
            if (newpassword.length < 6) {
                alertbox("The minimum password length is 6 characters");
                return;
            }
            AJAXFunction.CallAjax("POST", "/account/dialogchangepassword.aspx", "ChangePassword", { currentpassword: currentpassword, newpassword: newpassword }, function (response) {
                if (response.Status) {
                    alertSmallBox("Your password has been reset successfully", "1 second ago!!", "success");
                    $('#remoteModal').modal("hide");
                }
                else {
                    alertSmallBox("Failed to change password", response.Cause, "error");
                }
            });
        }
    };




</script>
