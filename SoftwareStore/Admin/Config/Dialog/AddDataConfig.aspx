<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddDataConfig.aspx.cs" Inherits="SoftwareStore.Admin.Config.Dialog.AddDataConfig" %>


<style>
    .tdheader {
        background: #BBDEFB;
    }
</style>

<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 900px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divAddDataConfig">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">ADD OR EDIT DATA CONFIG
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>

    <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 40px;">
        <label>
            Data Key
        </label>
        <select runat="server" id="cbListTypeEnum" class="select2">
        </select>
        <label>
            Data Value
        </label>
        <label class="input">
            <input type="text" id="txtDataValue" />
        </label>
        <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-top: 10px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
        <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; margin-top: 10px; width: 90px;" onclick="AddNewDataConfig(); ">SAVE</div>
    </div>
</div>
<style>
    .select2 {
        width: 100%;
    }
</style>
<script>
    $(document).ready(function () {
        $("#divAddDataConfig").delay(500).fadeIn(500).verticalAlign(400);
        if (SetupDataConfig.currentid != 0) {
            $("#<%=cbListTypeEnum.ClientID%>").val(SetupDataConfig.currentkey);
            $("#txtDataValue").val(SetupDataConfig.currentval);
        }
    });

    $("#<%=cbListTypeEnum.ClientID%>").select2();

    var AddNewDataConfig = function () {
        if ($("#<%=cbListTypeEnum.ClientID%>").val() == null) {
            alertSmallBox("Please select key for config", "", "error");
            return;
        }
        AJAXFunction.CallAjax("POST", "/admin/config/dialog/addDataConfig.aspx", "AddNewDataConfig", { id: SetupDataConfig.currentid, datakey: $("#<%=cbListTypeEnum.ClientID%>").val(), datavalue: $("#txtDataValue").val() }, function (response) {
            if (response.Status) {
                alertSmallBox("data changed", "", "success");
                $('#remoteModal2').modal("hide");
                SetupDataConfig.LoadData(1);
            }
            else {
                alertSmallBox("error", "", "error");
            }
        });
    }
</script>
