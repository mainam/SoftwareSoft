<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DialogUserInformation.aspx.cs" Inherits="SoftwareStore.hr.DialogUserInformation" %>

<style>
    .tdheader {
        background: #BBDEFB;
    }
</style>

<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 900px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divUserInformation">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;">USER INFORMATION
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>

    <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px;  background: white; padding: 30px; margin-top: 40px;">
        <table style="width: 100%">
            <tr>
                <td style="width: 100px; padding: 0 10px 0 0px; vertical-align: top !important;">
                    <div style="width: 100%; border: 1px dotted gray; clear: both; display: block; ">
                        <img style="width: 100%" runat="server" id="imgAvatar" />
                    </div>
                </td>
                <td style="vertical-align: top;">
                    <table class="table table-bordered" style="width: 750px;">
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Full Name
                            </td>
                            <td style="width: 230px;">
                                <label class="labelform" runat="server" id="lbFullName"></label>
                            </td>
                            <td style="width: 90px;" class="labelform tdheader">JobTitle
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbJobTitle"></label>
                            </td>

                        </tr>
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Birthday</td>
                            <td>
                                <label class="labelform" runat="server" id="lbBirthday"></label>
                            </td>

                            <td style="width: 90px;" class="labelform tdheader">Date Join Sel
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbDateJoinSel"></label>
                            </td>


                        </tr>
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Gender
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbGender"></label>
                            </td>
                            <td style="width: 90px;" class="labelform tdheader">SingleID
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbSingleID"></label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Phone
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbPhone"></label>
                            </td>
                            <td style="width: 90px;" class="labelform tdheader">Gen Number
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbGenNumber"></label>
                            </td>
                        </tr>

                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Team
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbTeam"></label>
                            </td>
                            <td style="width: 90px;" class="labelform tdheader">STC Score
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbSTCScore"></label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Leader
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbLeader"></label>
                            </td>
                            <td style="width: 90px;" class="labelform tdheader">Toeic Score
                            </td>
                            <td>
                                <label class="labelform" runat="server" id="lbToeicScore"></label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Address
                            </td>
                            <td colspan="3">
                                <label class="labelform" runat="server" id="lbAddress"></label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 90px;" class="labelform tdheader">Job Description
                            </td>
                            <td colspan="3">
                                <label class="labelform" runat="server" id="lbJobDescription"></label>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
    </div>
</div>

<script>
    $(document).ready(function () {
        ;
        $("#divUserInformation").delay(500).fadeIn(500).verticalAlign(400);
    });
</script>
