<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNewNotice.aspx.cs" Inherits="DeviceManagement.device.AddNewNotice" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">
    pageSetUp();
    loadScript("js/plugin/ckeditor/ckeditor.js", ckeditorStart);

    function ckeditorStart() {
        CKEDITOR.replace("txtContent", {
            height: '270px', startupFocus: true,
            toolbar: [
    ['Bold', 'Italic', 'Underline', 'Strike'],
    ['Subscript', 'Superscript'],
    ["JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"],	// Defines toolbar group with name (used to create voice label) and items in 3 subgroups.
    ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', 'Templates'],
    ['Undo', 'Redo'], ["NumberedList", "BulletedList", "Outdent", "Indent", "Blockquote"], ["Link", "Image", "Table", "HorizontalRule", "Smiley", "SpecialChar"],			// Defines toolbar group without name.
    ["Styles", "Format", "Font", "FontSize", "TextColor", "BGColor", "-", "Maximize", 'Preview']																			// Line break - next group will be placed in new line.
            ]

        });
    }

    var notice = findNotice(IDDeviceNoticeEdit);

    $("#formEditDevice").delay(500).fadeIn(500).verticalAlign(750);

    function findNotice(id) {
        var i = 0;
        for (i = 0; i < ListNotice.length; i++) {
            if (ListNotice[i].ID == id) {
                return ListNotice[i];
            }
        }
        return null;
    }


    function loadNotice(notice) {
        $('#txtTitle').val(notice.Title);
        $("#txtContent").val(notice.Content);
    }

    function SaveNotice() {
        if ($('#txtTitle').val() == "") {
            alertbox("Please input title");
            return;
        }
        if (CKEDITOR.instances["txtContent"].getData() == "") {
            alertbox("Please input content");
            return;
        }

        AJAXFunction.CallAjax("POST", "/device/AddNewNotice.aspx", "SaveNotice", {
            IDNotice: IDDeviceNoticeEdit == null ? 0 : IDDeviceNoticeEdit,
            Title: $('#txtTitle').val(),
            Active: true,
            Content: CKEDITOR.instances["txtContent"].getData()
        }, function (response) {
            if (response.Status) {
                alertSmallBox("Save data success", "2 seconds ago!!", "Error");
                LoadListNotice(1);
                $('#remoteModal').modal("hide");
            }
            else {
                alertSmallBox("Save data failed", "2 seconds ago!!", "Error");
            }
        });
    }


    $(document).ready(function () {
        //$("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(670);
        if (notice != null) {
            loadNotice(notice);
            $('#spanTitle').text("EDIT NOTICE");
        }
        else {
            $('#spanTitle').text("ADD NOTICE");
        }
    });


</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="formEditDevice">
    <div class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">ADD NOTICE
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row" style="margin-bottom: -15px;">
                <fieldset style="padding: 0 10px;">
                    <div class="row" style="padding: 10px;">
                        <section>
                            <label class="label labelform" style="padding: 0px;">Title</label>
                            <label class="input">
                                <i class="icon-prepend fa fa-tag"></i>
                                <input type="text" id="txtTitle" placeholder="Input title">
                            </label>
                            <label class="label labelform" style="padding: 0px; margin-top: 20px;">Content</label>
                            <label class="input">
                                <i class="icon-append fa fa-edit"></i>
                                <textarea name="txtContent" id="txtContent"></textarea>
                            </label>
                        </section>
                    </div>
                </fieldset>
                <footer style="padding: 5px;">
                    <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px;" onclick="SaveNotice(); ">Save</div>
                    <div class="btn btn-sm btn btn-primary " style="float: right; margin: 2px;" data-dismiss="modal" aria-hidden="true">Cancel</div>
                </footer>
            </div>
        </div>
    </div>
</div>
