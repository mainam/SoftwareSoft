<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetMySingle.aspx.cs" Inherits="DeviceManagement.GetMySingle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function goSession() {

            var rrtn = EpAdmC.GetSecureBox();
            if (rrtn != null && rrtn != "") {
                Form1.totaldataloginsingle.value = rrtn;
                Form1.submit();
            }
            else {
                Form1.totaldataloginsingle.value = "";
                Form1.submit();
            }
        }
    </script>
</head>
<body onload="goSession();">
    <form id="Form1" runat="server" method="post">
        <div>
            <input type="hidden" name="totaldataloginsingle" value="" />
        </div>
    </form>
    <object style="visibility: hidden; height: 1px;" id="EpAdm2 Control" name="EpAdmC" classid="CLSID:C63E3330-049F-4C31-B47E-425C84A5A725"></object>

</body>
</html>
