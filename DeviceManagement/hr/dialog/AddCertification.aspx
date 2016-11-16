<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCertification.aspx.cs" Inherits="DeviceManagement.hr.dialog.AddCertification" %>


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
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="popupAddCertification">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" id="titlePopup">ADD CERTIFICATION
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
                        <label class="label">Certification (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtCertification" style="width: 100%;" runat="server"></select>
                        </label>
                    </section>
                    <section id="otherCertification">
                        <label class="label">Input Certification (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <input type="text" id="txtOtherDataCertification" runat="server">
                        </label>
                    </section>
                    <section>
                        <label class="label">Grade (*)</label>
                        <label class="input">
                            <select class="select2" id="txtGrade" style="width: 100%;" runat="server">
                                <option value="1">Top Class
                                </option>
                                <option value="2">2nd Grade
                                </option>
                                <option value="3">3rd Grade
                                </option>
                                <option value="4">4th Grade
                                </option>
                                <option value="5">5th Grade
                                </option>
                                <option value="6">6th Grade
                                </option>
                                <option value="7">7th Grade
                                </option>
                                <option value="8">8th Grade
                                </option>
                                <option value="9">No Grade
                                </option>
                            </select>
                        </label>
                    </section>

                    <section>
                        <label class="label">Issue Date (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-calendar"></i>
                            <input type="text" readonly="readonly" id="txtIssueDate" placeholder="Issue Date" class="datepicker" runat="server" />
                        </label>
                    </section>
                    <section>
                        <label class="label">Expiration Date</label>
                        <label class="input">
                            <i class="icon-append fa fa-calendar"></i>
                            <input type="text" id="txtExpirationDate" placeholder="Expiration Date" class="datepicker" runat="server" />
                        </label>
                    </section>
                    <section>
                        <label class="label">License No.</label>
                        <label class="input">
                            <i class="icon-append fa fa-tag"></i>
                            <input type="text" id="txtLicenseNo" runat="server" />
                        </label>
                    </section>
                    <section>
                        <label class="label" style="display: inline">Issued by</label>
                        <label class="input">
                            <i class="icon-append fa fa-group"></i>
                            <input type="text" id="txtIssuedby" runat="server" />
                        </label>
                    </section>

                </fieldset>
                <section class="col col-6" style="text-align: right; float: right">
                    <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
                    <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; width: 90px;" onclick="AddCertification.Save(); ">SAVE</div>
                </section>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <div style="clear: both;"></div>

</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#popupAddCertification").delay(500).fadeIn(500).verticalAlign(600);
        $("#txtCertification").select2();
        $("#txtGrade").select2();
        $('.datepicker').each(function () {
            $this = $(this);
            var dataDateFormat = $this.attr('data-dateformat') || 'mm/dd/yy';

            $this.datepicker({
                dateFormat: dataDateFormat,
                prevText: '<i class="fa fa-chevron-left"></i>',
                nextText: '<i class="fa fa-chevron-right"></i>',
            });
        })

        if ($("#txtCertification").val() == 1)
            $("#otherCertification").show();
        else
            $("#otherCertification").hide();
        $("#txtCertification").change(function () {
            if ($("#txtCertification").val() == 1)
                $("#otherCertification").show();
            else
                $("#otherCertification").hide();
        });

        
        if (Certification.currentid != null) {
            
            var certification = Certification.FindCertification(Certification.currentid);
            if (certification != null) {
                $("#<%=txtCertification.ClientID%>").select2("val", certification.DataCertificationID);
                if (certification.DataCertificationID == 1) {
                    $("#otherCertification").show();
                }
                $("#<%=txtOtherDataCertification.ClientID%>").val(certification.OtherDataCertification);
                $("#<%=txtGrade.ClientID%>").select2("val", certification.Grade);
                $("#<%=txtIssueDate.ClientID%>").val(certification.IssueDate);
                $("#<%=txtIssuedby.ClientID%>").val(certification.IssuedBy);
                $("#<%=txtExpirationDate.ClientID%>").val(certification.Expiration);
                $("#<%=txtLicenseNo.ClientID%>").val(certification.LicenseNo);

                $("#titlePopup").text("EDIT CERTIFICATION");
            }
            else {
                $("#titlePopup").text("ADD CERTIFICATION");
            }
        }
    });

    var AddCertification =
            {
                Save: function () {
                    if ($("#txtCertification").val().trim() == "") {
                        alertSmallBox("Please select Certification", "Can't save", "Error");
                        return;
                    }

                    if ($("#txtCertification").val() == 1) {
                        if ($("#txtOtherDataCertification").val().trim() == "") {
                            alertSmallBox("if you select Certification is Other, Please insert name of Certification", "Can't save", "Error");
                            return;
                        }
                    }

                    if ($("#txtIssueDate").val().trim() == "") {
                        alertSmallBox("Please input Issue Date", "Can't save", "Error");
                        return;
                    }

                    if ($("#txtGrade").val().trim() == "") {
                        alertSmallBox("Please select Grade", "Can't save", "Error");
                        return;
                    }
                    if (new Date($("#txtIssueDate").val().trim()) > new Date()) {
                        alertSmallBox("Issue date can not be greater than today.", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtExpirationDate").val().trim() != "" && new Date($("#txtExpirationDate").val().trim()) < new Date()) {
                        alertSmallBox("Expiration date  can not be less than today.", "Can't save", "Error");
                        return;
                    }

                    if ($("#txtExpirationDate").val().trim() != "" && new Date($("#txtExpirationDate").val().trim()) < new Date($("#txtIssueDate").val().trim())) {
                        alertSmallBox("Expiration date  can not be less than issue date.", "Can't save", "Error");
                        return;
                    }

                    confirm("Confirm", "Do you want to save data", "Save", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "SaveCertification", {
                            usercertification: {
                                ID: Certification.currentid == null ? 0 : Certification.currentid,
                                DataCertificationID: $("#txtCertification").val(),
                                OtherDataCertification: $("#txtOtherDataCertification").val(),
                                Grade: $("#txtGrade").val(),
                                IssueDate: $("#txtIssueDate").val(),
                                Expiration: $("#txtExpirationDate").val() == null ? null : $("#txtExpirationDate").val(),
                                LicenseNo: $("#txtLicenseNo").val(),
                                IssuedBy: $("#txtIssuedby").val(),
                                UserName: GetQueryStringHash("user")
                            }
                        }, function (response) {
                            if (response.Status) {
                                if (Certification.currentid == null) {
                                    alertSmallBox("Add Certification successfull", "1 second ago!!", "success");
                                }
                                else {
                                    alertSmallBox("Edit Certification successfull", "1 second ago!!", "success");
                                }
                                Certification.LoadData();
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
