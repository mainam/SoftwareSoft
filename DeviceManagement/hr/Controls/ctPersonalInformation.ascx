<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctPersonalInformation.ascx.cs" Inherits="DeviceManagement.hr.Controls.ctPersonalInformation" %>

<div class="jarviswidget jarviswidget-color-pink" id="wdPersonalInformation" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
    <header>
        <span class="widget-icon"><i class="fa fa-edit"></i></span>
        <h2>Personal Information </h2>
        <div class="widget-toolbar" role="menu" runat="server" id="btnEdit">
            <!-- add: non-hidden - to disable auto hide -->
            <div class="btn-group">
                <a class="btn dropdown-toggle btn-xs btn-success btnwidth" data-backdrop="static" onclick="PersonalDetail.EditPersonalDetail();" style="width: 70px;">Edit</a>
            </div>
        </div>
    </header>

    <!-- widget div-->
    <div>

        <!-- widget edit box -->
        <div class="jarviswidget-editbox">
            <!-- This area used as dropdown edit box -->

        </div>
        <!-- end widget edit box -->

        <!-- widget content -->
        <div class="widget-body padding">
            <div>

                <table style="width: 100%">
                    <tr>
                        <td style="width: 150px; padding: 0 10px 0 0px; vertical-align: top !important;">
                            <div style="width: 100%; border: 1px dotted gray; clear: both; display: block">
                                <img src="/images/SEL_Images/Chu%20Văn%20Luong.PNG" style="width: 100%" runat="server" id="imgAvatar" />
                            </div>
                            <label class="btn btn-primary" style="width: 100%; margin-top: 5px;" onclick="PersonalDetail.ChangeAvatar()" runat="server" id="btnChangeAvatar">
                                Change Avatar
                            </label>
                        </td>
                        <td style="vertical-align: top;">
                            <div class="row padding smart-form">
                                <div class="col-sm-4">
                                    <fieldset style="padding-top: 0px;">
                                        <section>
                                            <label class="label">Full Name</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-user"></i>
                                                <input type="text" id="txtFullName" runat="server" disabled="disabled">
                                            </label>
                                        </section>

                                        <section>
                                            <label class="label">Gender</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-question-circle"></i>
                                                <select class="select2" id="txtGender" runat="server" disabled="disabled">
                                                    <option value="Male">Male
                                                    </option>
                                                    <option value="Female">Female
                                                    </option>
                                                </select>
                                            </label>
                                        </section>

                                        <section>
                                            <label class="label">Date of Birth</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-calendar"></i>
                                                <input name="txtReceiveDate" type="text" id="txtDateofBirth" runat="server" class="datepicker" data-dateformat="mm/dd/yy" value="01/09/2015" disabled="disabled">
                                            </label>
                                        </section>
                                        <section>
                                            <label class="label">Date Join SEL</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-calendar"></i>
                                                <input name="txtReceiveDate" type="text" id="txtDateJoinSEL" runat="server" class="datepicker" data-dateformat="mm/dd/yy" value="01/09/2015" disabled="disabled">
                                            </label>
                                        </section>
                                    </fieldset>
                                </div>
                                <div class="col-sm-4">
                                    <fieldset style="padding-top: 0px;">
                                        <section>
                                            <label class="label">MySingle ID</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-lock"></i>
                                                <input type="text" id="txtMySingleID" runat="server" disabled="disabled">
                                            </label>
                                        </section>

                                        <section>
                                            <label class="label">Gen Number</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-tag"></i>
                                                <input type="text" id="txtGenNumber" runat="server" disabled="disabled">
                                            </label>
                                        </section>

                                        <section>
                                            <label class="label">Phone Number</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-phone"></i>
                                                <input name="txtPhoneNumber" type="text" id="txtPhoneNumber" runat="server" disabled="disabled">
                                            </label>
                                        </section>
                                        <section>
                                            <label class="label">Toeic Score</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-comments-o"></i>
                                                <input type="text" id="txtToeicScore" runat="server" disabled="disabled" />
                                            </label>
                                        </section>
                                    </fieldset>

                                </div>
                                <div class="col-sm-4">
                                    <fieldset style="padding-top: 0px;">
                                        <section>
                                            <label class="label">Job Title</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-question-circle"></i>
                                                <select class="select2" id="txtJobTitle" runat="server" disabled="disabled">
                                                </select>
                                            </label>
                                        </section>

                                        <section>
                                            <label class="label">Team</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-question-circle"></i>
                                                <select class="select2" id="txtTeam" runat="server" disabled="disabled">
                                                </select>
                                            </label>
                                        </section>

                                        <section>
                                            <label class="label">Leader</label>
                                            <label class="input">
                                                <i class="icon-append fa fa-question-circle"></i>
                                                <select class="select2" id="txtTeamLeader" runat="server" disabled="disabled">
                                                </select>
                                            </label>
                                        </section>
                                        <section>
                                            <label class="label">STC Level</label>
                                            <label class="input">
                                                <i class="icon-append fa  fa-file-code-o"></i>
                                                <select class="select2" id="txtSTCLevel" runat="server" disabled="disabled">
                                                    <option value="1">Level 1</option>
                                                    <option value="2">Level 2</option>
                                                    <option value="3">Level 3</option>
                                                    <option value="4">Level 4</option>
                                                    <option value="5">Level 5</option>
                                                </select>

                                                <%--<input type="text" id="txtSTCLevel" runat="server" disabled="disabled" />--%>
                                            </label>
                                        </section>
                                    </fieldset>
                                </div>

                            </div>
                            <fieldset style="padding-top: 0px; padding-left: 15px; padding-right: 15px;" class="smart-form">
                                <section>
                                    <label class="label">Address</label>
                                    <label class="input">
                                        <i class="icon-append fa fa-user"></i>
                                        <input name="txtAddress" id="txtAddress" runat="server" value="" org-data="" disabled="disabled" />
                                    </label>
                                </section>
                                <section>
                                    <label class="label">Job Description</label>
                                    <label class="input">
                                        <i class="icon-append fa fa-tag"></i>
                                        <textarea name="txtJobDescription" type="text" style="width: 100%; resize: none" rows="4" id="txtJobDescription" runat="server" value="" org-data="" disabled="disabled" />
                                    </label>
                                </section>
                            </fieldset>


                            <div style="clear: both; float: right; padding: 0px 14px 7px;" id="divButtonEdit" runat="server">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <!-- end widget content -->

    </div>
    <%--<!-- end widget div -->--%>
</div>
<script>
    var PersonalDetail = {
        currentuser: "",
        oriImg: null,
        EditPersonalDetail: function () {
            $("#<%=btnEdit.ClientID%>").hide();
            $("#<%=txtFullName.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtFullName.ClientID%>").val());
            $("#<%=txtGender.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtGender.ClientID%>").val());
            $("#<%=txtGenNumber.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtGenNumber.ClientID%>").val());
            $("#<%=txtPhoneNumber.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtPhoneNumber.ClientID%>").val());
            $("#<%=txtJobTitle.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtJobTitle.ClientID%>").val());
            $("#<%=txtTeam.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtTeam.ClientID%>").val());
            $("#<%=txtDateofBirth.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtDateofBirth.ClientID%>").val());
            $("#<%=txtDateJoinSEL.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtDateJoinSEL.ClientID%>").val());
            $("#<%=txtToeicScore.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtToeicScore.ClientID%>").val());
            $("#<%=txtSTCLevel.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtSTCLevel.ClientID%>").val());
            $("#<%=txtAddress.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtAddress.ClientID%>").val());
            $("#<%=txtJobDescription.ClientID%>").removeAttr("disabled").attr("org-data", $("#<%=txtJobDescription.ClientID%>").val());

            var div = $("#<%=divButtonEdit.ClientID%>").empty();
            var save = $('<label class="btn btn-primary" style="width: 80px;">').text("Save");
            save.click(function () {
                var fullname = $("#<%=txtFullName.ClientID%>").val();
                if (fullname.trim() == "") {
                    alertbox("Please input fullname");
                    return;
                }
                var gender = $("#<%=txtGender.ClientID%>").val();
                if (gender.trim() == "") {
                    alertbox("Please select gender");
                    return;
                }
                var dateofbirth = $("#<%=txtDateofBirth.ClientID%>").val();
                if (dateofbirth.trim() == "") {
                    alertbox("Please select birthday");
                    return;
                }
                var gennumber = $("#<%=txtGenNumber.ClientID%>").val();
                //if (gennumber.trim() == "") {
                //    alertbox("Please input gen number");
                //    return;
                //}
                var jobtitle = $("#<%=txtJobTitle.ClientID%>").val();
                if (jobtitle.trim() == "") {
                    alertbox("Please select jobtitle");
                    return;
                }

                var team = $("#<%=txtTeam.ClientID%>").val();
                if (team.trim() == "") {
                    alertbox("Please select team");
                    return;
                }

                confirm("Confirm", "Do you want to save information", "Save", "Cancel", function () {
                    if (!Common.isValidDate($("#<%=txtDateJoinSEL.ClientID%>").val())) {
                        alertSmallBox("datejoinsel input format MM/dd/yyyy", "Can't save", "Error");
                        return;
                    }
                    if (!Common.isValidDate(dateofbirth)) {
                        alertSmallBox("dateofbirth input format MM/dd/yyyy", "Can't save", "Error");
                        return;
                    }
                    AJAXFunction.CallAjax("POST", "/hr/userprofile.aspx", "SavePersonalDetail", {
                        user: {
                            FullName: fullname,
                            Gender: gender,
                            Birthday: dateofbirth,
                            GEN: gennumber,
                            PhoneNumber: $("#<%=txtPhoneNumber.ClientID%>").val(),
                            UserName: $("#<%=txtMySingleID.ClientID%>").val(),
                            JobDescription: $("#<%=txtJobDescription.ClientID%>").val(),
                            Address: $("#<%=txtAddress.ClientID%>").val(),
                            DateJoiningSEL: $("#<%=txtDateJoinSEL.ClientID%>").val(),
                            STCLevel: $("#<%=txtSTCLevel.ClientID%>").val(),
                            ToeicScore: $("#<%=txtToeicScore.ClientID%>").val(),
                            JobTitleID: jobtitle,
                            TeamID: team
                        }
                    }, function (response) {
                        if (response.Status) {
                            alertSmallBox("Update personal detail successful", "1 second ago!!", "success");
                            $("#<%=txtFullName.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtFullName.ClientID%>").val());
                            $("#<%=txtGender.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtGender.ClientID%>").val());
                            $("#<%=txtGenNumber.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtGenNumber.ClientID%>").val());
                            $("#<%=txtPhoneNumber.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtPhoneNumber.ClientID%>").val());
                            $("#<%=txtJobTitle.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtJobTitle.ClientID%>").val());
                            $("#<%=txtTeam.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtTeam.ClientID%>").val());
                            $("#<%=txtDateofBirth.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtDateofBirth.ClientID%>").val());
                            $("#<%=txtDateJoinSEL.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtDateJoinSEL.ClientID%>").val());
                            $("#<%=txtToeicScore.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtToeicScore.ClientID%>").val());
                            $("#<%=txtSTCLevel.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtSTCLevel.ClientID%>").val());
                            $("#<%=txtAddress.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtAddress.ClientID%>").val());
                            $("#<%=txtJobDescription.ClientID%>").attr("disabled", "disabled").attr("org-data", $("#<%=txtJobDescription.ClientID%>").val());
                            $("#<%=btnEdit.ClientID%>").show();
                            $("#<%=divButtonEdit.ClientID%>").empty();
                        }
                        else {
                            alertSmallBox("Update personal detail failed", "1 second ago!!", "error");
                        }
                    });
                });



            });
            div.append(save);
            var cancel = $('<label class="btn btn-default" style="width: 80px; margin-left:5px;">').text("Cancel").click(function () {
                $("#<%=btnEdit.ClientID%>").show();

                $("#<%=txtFullName.ClientID%>").attr("disabled", "disabled").val($("#<%=txtFullName.ClientID%>").attr("org-data"));
                $("#<%=txtGender.ClientID%>").attr("disabled", "disabled").select2("val", $("#<%=txtGender.ClientID%>").attr("org-data"));
                $("#<%=txtGenNumber.ClientID%>").attr("disabled", "disabled").val($("#<%=txtGenNumber.ClientID%>").attr("org-data"));
                $("#<%=txtPhoneNumber.ClientID%>").attr("disabled", "disabled").val($("#<%=txtPhoneNumber.ClientID%>").attr("org-data"));
                $("#<%=txtJobTitle.ClientID%>").attr("disabled", "disabled").select2("val", $("#<%=txtJobTitle.ClientID%>").attr("org-data"));
                $("#<%=txtTeam.ClientID%>").attr("disabled", "disabled").select2("val", $("#<%=txtTeam.ClientID%>").attr("org-data"));
                $("#<%=txtDateofBirth.ClientID%>").attr("disabled", "disabled").val($("#<%=txtDateofBirth.ClientID%>").attr("org-data"));
                $("#<%=txtDateJoinSEL.ClientID%>").attr("disabled", "disabled").val($("#<%=txtDateJoinSEL.ClientID%>").attr("org-data"));
                $("#<%=txtSTCLevel.ClientID%>").attr("disabled", "disabled").val($("#<%=txtSTCLevel.ClientID%>").attr("org-data"));
                $("#<%=txtToeicScore.ClientID%>").attr("disabled", "disabled").val($("#<%=txtToeicScore.ClientID%>").attr("org-data"));
                $("#<%=txtAddress.ClientID%>").attr("disabled", "disabled").val($("#<%=txtAddress.ClientID%>").attr("org-data"));
                $("#<%=txtJobDescription.ClientID%>").attr("disabled", "disabled").val($("#<%=txtJobDescription.ClientID%>").attr("org-data"));
                $("#<%=divButtonEdit.ClientID%>").empty();
            });
            div.append(cancel);
        },
        ChangeAvatar: function () {
            PersonalDetail.oriImg = $("#<%=imgAvatar.ClientID%>");
            PersonalDetail.currentuser = $('#<%=txtMySingleID.ClientID%>').val();
            var target = "/account/dialogChangeAvatar.aspx";
            //var target = "/hr/dialog/AddEducation.aspx";
            $("#remoteModal").removeData();
            $('#remoteModal').modal({ backdrop: 'static' });
            $("#remoteModal").load(target, function () {
                $("#remoteModal").modal("show");
            });
        }
    }

    $("#<%=txtTeam.ClientID%>").change(function () {
        $("#<%=txtTeamLeader.ClientID%>").select2("val", $(this).val());
    });


</script>


