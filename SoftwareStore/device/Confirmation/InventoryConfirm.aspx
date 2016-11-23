<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryConfirm.aspx.cs" Inherits="SoftwareStore.device.Confirmation.InventoryConfirm" %>

<div id="contentinventoryconfirm">
</div>

<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
<script type="text/javascript">


    $(document).ready(function () {
        
        if (typeinventory == "leader") {
            loadURL("/device/Confirmation/LeaderInventoryPage.aspx", $("#contentinventoryconfirm"));
        }
        else {
            loadURL("/device/Confirmation/UserInventoryPage.aspx", $("#contentinventoryconfirm"));
        }
    });

</script>
