<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAwardReward.aspx.cs" Inherits="DeviceManagement.hr.dialog.AddAwardReward" %>

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

    .select2 {
        width: 100%;
    }
</style>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="popupAddAwardReward">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" id="titlePopup">ADD AWARD
        </span>

        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; opacity: 1">
            &times;
        </button>
    </div>
    <form runat="server" id="FormUpdateManDate">
        <div class="modal-body no-padding smart-form" style="margin: 20px auto 0px; background: white; padding: 30px; margin-top: 20px;">
            <div class="row" style="margin-bottom: -20px;">
                <fieldset style="padding-top: 0px; margin-top: 15px;">
                    <section>
                        <label class="label" id="typeAwardReward1">Award Title(*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-tag"></i>
                            <input type="text" id="txtAwardRewardTitle" runat="server" />
                        </label>
                    </section>
                    <section>
                        <label class="label">Issue Date (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-calendar"></i>
                            <input type="text" id="txtIssueDate" runat="server" class="datepicker">
                        </label>
                    </section>
                    <section>
                        <label class="label" id="typeAwardReward2">Awarded By (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-user"></i>
                            <input type="text" id="txtAwardRewardBy" runat="server">
                        </label>
                    </section>
                    <section>
                        <label class="label">Content (*)</label>
                        <label class="input">
                            <textarea id="txtContent" runat="server" rows="4" class="form-control" style="resize: none; margin-top: 3px;"></textarea>
                        </label>
                    </section>
                </fieldset>
                <section class="col col-6" style="text-align: right; float: right">
                    <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
                    <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; width: 90px;" onclick="AddAwardReward.Save();">SAVE</div>
                </section>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <div style="clear: both;"></div>

</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#popupAddAwardReward").delay(500).fadeIn(500).verticalAlign(600);
        $('.datepicker').each(function () {
            $this = $(this);
            var dataDateFormat = $this.attr('data-dateformat') || 'mm/dd/yy';

            $this.datepicker({
                dateFormat: dataDateFormat,
                prevText: '<i class="fa fa-chevron-left"></i>',
                nextText: '<i class="fa fa-chevron-right"></i>',
            });
        })
        
        if (UserProfilePage.TypeAward == "award") {
            
            $("#titlePopup").text("ADD AWARD");
            $("#typeAwardReward1").text("Award Title(*)");
            $("#typeAwardReward2").text("Awarded By (*)");
            if (Award.currentid != null) {
                var award = Award.FindAward(Award.currentid);
                if (award != null) {
                    $("#<%=txtAwardRewardTitle.ClientID%>").val(award.Name);
                    $("#<%=txtIssueDate.ClientID%>").val(award.IssueDate);
                    $("#<%=txtAwardRewardBy.ClientID%>").val(award.AwardBy);
                    $("#<%=txtContent.ClientID%>").val(award.Content);
                    $("#titlePopup").text("EDIT AWARD");
                }
            }
            else {
                $("#titlePopup").text("ADD AWARD");
            }
        }
        else {
            $("#titlePopup").text("ADD REWARD");
            $("#typeAwardReward1").text("Reward Title(*)");
            $("#typeAwardReward2").text("Rewarded By (*)");
            
            if (Reward.currentid != null) {
                var award = Reward.FindAward(Reward.currentid);
                if (award != null) {
                    $("#<%=txtAwardRewardTitle.ClientID%>").val(award.Name);
                    $("#<%=txtIssueDate.ClientID%>").val(award.IssueDate);
                    $("#<%=txtAwardRewardBy.ClientID%>").val(award.AwardBy);
                    $("#<%=txtContent.ClientID%>").val(award.Content);
                    $("#titlePopup").text("EDIT REWARD");
                }
                else {
                    $("#titlePopup").text("ADD REWARD");
                }
            }
        }
    });

    var AddAwardReward =
            {
                Save: function () {
                    
                    if ($("#txtAwardRewardTitle").val().trim() == "") {
                        alertSmallBox("Please input " + $("#typeAwardReward1").text(), "Can't save", "Error");
                        return;
                    }

                    if ($("#<%=txtIssueDate.ClientID%>").val().trim() == "") {
                        alertSmallBox("Please select Issue Date ", "Can't save", "Error");
                        return;
                    }
                    if ($("#<%=txtAwardRewardBy.ClientID%>").val().trim() == "") {
                        alertSmallBox("Please input " + $("#typeAwardReward2").text(), "Can't save", "Error");
                        return;
                    }
                    if ($("#<%=txtContent.ClientID%>").val().trim() == "") {
                        alertSmallBox("Please input Content ", "Can't save", "Error");
                        return;
                    }

                    confirm("Confirm", "Do you want to save data", "Save", "Cancel", function () {
                        
                        AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "SaveAwardReward", {
                            userawardreward: {
                                ID: (UserProfilePage.TypeAward == "award") ? (Award.currentid == null ? 0 : Award.currentid) : (Reward.currentid == null ? 0 : Reward.currentid),
                                Name: $("#txtAwardRewardTitle").val(),
                                OtherAward: $("#txtAwardRewardTitle").val(),
                                IssueDate: $("#txtIssueDate").val(),
                                AwardBy: $("#txtAwardRewardBy").val(),
                                Content: $("#txtContent").val(),
                                UserName: GetQueryStringHash("user"),
                                Type: (UserProfilePage.TypeAward == "award") ? 1 : 2
                            }
                        }, function (response) {
                            if (response.Status) {
                                if (Award.currentid == null) {
                                    alertSmallBox("Add " + (UserProfilePage.TypeAward == "award") ? "Award" : "Reward" + " successfull", "1 second ago!!", "success");
                                }
                                else {
                                    alertSmallBox("Edit " + (UserProfilePage.TypeAward == "award") ? "Award" : "Reward" + " successfull", "1 second ago!!", "success");
                                }
                                if (UserProfilePage.TypeAward == "award")
                                    Award.LoadData();
                                else
                                    Reward.LoadData();
                            }
                            else {
                                alertSmallBox("Save data not successful", "1 second ago!!", "error");
                                $("#remoteModal").modal("show");
                            }
                        });
                    });

                }
            }


</script>
