<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewNotice.aspx.cs" Inherits="DeviceManagement.device.ViewNotice" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>

<link href="/device/style/styleText.css" rel="stylesheet" />

<script type="text/javascript">
    pageSetUp();

    $("#formEditDevice").delay(500).fadeIn(500).verticalAlign(750);

</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="formEditDevice">
    <div class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-transform: uppercase; text-align: center;" runat="server" id="spanTitle">
                <label id="lbTitle" runat="server" style="font-size: 20px; font-weight: bold; word-break: break-all; word-wrap: break-word;"></label>
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row" style="margin-bottom: -15px;">
                <fieldset style="padding: 0 10px;">
                    <header style="margin: 0px; overflow: hidden;">
                        Created by: <b style="margin-right: 20px;">
                            <label id="lbCreatedBy" runat="server" style="font-weight: bold; word-break: break-all; word-wrap: break-word;">Mai Ngoc Nam</label>
                        </b>
                        Created date: <b>
                            <label id="lbCreatedDate" runat="server" style="font-weight: bold; word-break: break-all; word-wrap: break-word;">Mai Ngoc Nam</label>
                        </b>
                    </header>
                    <section style="margin-bottom: 5px; margin-top: 10px;">
                        <div id="lbContent" runat="server" style="padding-right: 10px; overflow: auto; word-break: break-all; word-wrap: break-word; line-height: 20px; margin-bottom: 15px; height: 500px;">
                        </div>
                    </section>
                </fieldset>
                <footer style="padding: 5px;">
                    <div class="btn btn-sm btn btn-primary " style="float: right; margin: 2px;" data-dismiss="modal" aria-hidden="true">Close</div>
                </footer>
            </div>
        </div>
    </div>
</div>
