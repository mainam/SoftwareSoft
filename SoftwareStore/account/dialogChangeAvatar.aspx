<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dialogChangeAvatar.aspx.cs" Inherits="SoftwareStore.account.dialogChangeAvatar" %>

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
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divchangeavatar">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">UPDATE AVATAR
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>
    <form runat="server" id="FormUpdateManDate">
        <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 20px;">
            <div class="row" style="margin-bottom: -20px;">
                <fieldset style="padding-top: 0px; margin-top: 15px;">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 100px;">
                                <img src="/images/no_image.jpg" id="imgAvatarUpdate" style="width: 100px; border: 1px dotted beige; background: black;" />
                            </td>
                            <td style="padding-left: 10px; vertical-align: top;">
                                <label for="file" class="input input-file">
                                    <div class="button">
                                        <input type="file" name="file-issue" id="inputFileAvatar" onchange="readURL(this);" accept="image/*" />Browse
                                    </div>
                                    <input type="text" placeholder="Select image file" id="inputFileAvatar2" readonly="" class="form-input">
                                </label>

                                <%--                                <div class="form-group" style="width: 100%;">
                                    <div style="width: 100%;">
                                        <input type="file" class="btn btn-default" id="inputFileAvatar" style="padding: 10px; width: 100%;" onchange="readURL(this);" accept="image/*">
                                    </div>
                                </div>--%>
                            </td>
                        </tr>
                    </table>

                </fieldset>
                <section class="col col-6" style="text-align: right; float: right">
                    <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
                    <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; width: 90px;" onclick="UpdateAvatar.Update(); ">SAVE</div>
                </section>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <div style="clear: both;"></div>

</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#divchangeavatar").delay(500).fadeIn(500).verticalAlign(200);
        $('#imgAvatarUpdate').attr("src", PersonalDetail.oriImg.attr("src"));
    });
    function readURL(input) {
        
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
    }


    var UpdateAvatar = {
        Update: function () {
            if (!($('#inputFileAvatar').get(0).files && $('#inputFileAvatar').get(0).files[0])) {
                alertSmallBox("Upload image failed", "Please select image file", "error");
                return;
            }

            confirm("Confirm", "Do you want to save data", "Save", "Cancel", function () {
                var data = new FormData();
                var files = $('#inputFileAvatar').get(0).files;
                if (files.length > 0) {
                    data.append("file", files[0]);
                }
                data.append("username", PersonalDetail.currentuser);
                $.ajax({
                    type: "POST",
                    url: "/account/AJAXImportAvatar.ashx",
                    contentType: false,
                    processData: false,
                    data: data,
                    success: function (response) {
                        var obj = JSON.parse(response);
                        if (obj.Status) {
                            if (!obj.isAdminEdit)
                                $("#imgAvatar").attr("src", obj.Link);
                            PersonalDetail.oriImg.attr("src", obj.Link);
                            alertSmallBox("Update avatar success", "1 second ago", "success");
                            $("#remoteModal").modal("hide");
                        }
                        else {
                            alertSmallBox("Update avatar failed", "1 second ago", "error");
                        }
                    }

                });

            });
        }
    };




</script>
