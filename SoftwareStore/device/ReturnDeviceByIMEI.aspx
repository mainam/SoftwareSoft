<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnDeviceByIMEI.aspx.cs" Inherits="SoftwareStore.device.ReturnDeviceByIMEI" %>


<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">


    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(670);
        $("#txtIMEINumber").val(imeitext);
    });
    function ClearForm() {
        $("#txtIMEINumber").val("");
        $("#NumberRow").text("Count: " + 0);
        imeitext = "";
    }

    $('#txtIMEINumber').bind('input propertychange', function () {

        var text = $("#txtIMEINumber").val();
        var lines = text.split("\n");
        var count = 0;
        for (var i = 0; i < lines.length; i++) {
            if (!lines[i].trim() == "")
                count++;
        }

        $("#NumberRow").text("Count: " + count);
    });

</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 700px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <form runat="server" id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">SEARCH BY IMEI
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row" style="margin-bottom: -30px;">
                <div class="row smart-form " style="padding-bottom: 10px; padding-left: 10px; padding-right: 10px;">
                    <header style="font-weight: bold; margin-top: -10px;">
                        Input IMEI Devices (one line a IMEI)
                    </header>
                    <div style="padding: 20px; padding-right: 40px;">
                        <label class="input">
                            <textarea rows="10" style="width: 100%; resize: none; padding: 10px; line-height: 30px;" name="request" id="txtIMEINumber" />
                        </label>
                    </div>
                </div>

            </div>

        </div>
        <div class="modal-body no-padding" style="margin: 0px auto; background: white; padding: 30px; padding-top: 10px;">
            <section>
                <div style="float: left; margin: 2px; width: 95px; margin-top: -10px;" id="NumberRow">Count: 0 </div>
                <div class="btn btn-sm btn btn-success" style="float: right; margin: 2px; width: 95px;" onclick="ClearForm();">Clear</div>
                <div class="btn btn-sm btn btn-default" style="float: right; margin: 2px; width: 95px;" data-dismiss="modal" aria-hidden="true">Cancel</div>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px; width: 95px;" onclick="SearchByIMEI(); ">Search</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
