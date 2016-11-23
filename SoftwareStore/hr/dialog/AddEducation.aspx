<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEducation.aspx.cs" Inherits="SoftwareStore.hr.dialog.AddEducation" %>

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
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divchangeavatar">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" id="titlePopup">ADD EDUCATION
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
                        <label class="label">Education Level (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtEducationLevel" style="width: 100%;" runat="server"></select>
                        </label>
                    </section>
                    <section>
                        <label class="label">School (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtSchool" style="width: 100%;" runat="server"></select>
                        </label>
                    </section>
                    <section id="otherschool">
                        <label class="label">Input School (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <input type="text" id="txtOtherSchool" runat="server">
                        </label>
                    </section>
                    <section>
                        <label class="label">Major (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtMajor" style="width: 100%;" runat="server"></select>
                        </label>
                    </section>
                    <section id="othermajor">
                        <label class="label">Input Major (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <input type="text" id="txtOtherMajor" runat="server">
                        </label>
                    </section>
                    <section>
                        <label class="label">Period (*)</label>
                        <div class="row">
                            <section class="col col-6">
                                <label class="input">
                                    <i class="icon-append fa fa-calendar"></i>
                                    <input type="text" name="startdate" id="txtEnteredAt" runat="server" placeholder="Entered at" class="datepicker">
                                </label>
                            </section>
                            <section class="col col-6">
                                <label class="input">
                                    <i class="icon-append fa fa-calendar"></i>
                                    <input type="text" name="finishdate" id="txtGraduatedAt" runat="server" placeholder="Graduated at" class="datepicker">
                                </label>
                            </section>
                        </div>
                    </section>
                </fieldset>
                <section class="col col-6" style="text-align: right; float: right">
                    <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
                    <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; width: 90px;" onclick="AddEducation.Save(); ">SAVE</div>
                </section>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <div style="clear: both;"></div>

</div>
<script type="text/javascript">
    $('#txtEnteredAt').datepicker({
        prevText: '<i class="fa fa-chevron-left"></i>',
        nextText: '<i class="fa fa-chevron-right"></i>',
        onSelect: function (selectedDate) {
            $('#txtGraduatedAt').datepicker('option', 'minDate', selectedDate);
        }
    });

    $('#txtGraduatedAt').datepicker({
        prevText: '<i class="fa fa-chevron-left"></i>',
        nextText: '<i class="fa fa-chevron-right"></i>', onSelect: function (selectedDate) {
            $('#txtEnteredAt').datepicker('option', 'maxDate', selectedDate);
        }
    });

    $(document).ready(function () {
        $("#divchangeavatar").delay(500).fadeIn(500).verticalAlign(600);
        //pageSetUp();
        $("#txtEducationLevel").select2();
        $("#txtSchool").select2();
        $("#txtMajor").select2();
        $this = $(this);
        $('.datepicker').each(function () {
            $this = $(this);
            var dataDateFormat = $this.attr('data-dateformat') || 'mm/dd/yy';

            $this.datepicker({
                dateFormat: dataDateFormat,
                prevText: '<i class="fa fa-chevron-left"></i>',
                nextText: '<i class="fa fa-chevron-right"></i>',
            });
        })



        if ($("#txtSchool").val() == 1)
            $("#otherschool").show();
        else
            $("#otherschool").hide();
        if ($("#txtMajor").val() == 1)
            $("#othermajor").show();
        else
            $("#othermajor").hide();
        $("#txtSchool").change(function () {
            if ($("#txtSchool").val() == 1)
                $("#otherschool").show();
            else
                $("#otherschool").hide();
        });
        $("#txtMajor").change(function () {
            if ($("#txtMajor").val() == 1)
                $("#othermajor").show();
            else
                $("#othermajor").hide();
        });


        if (Education.currentid != null) {

            var education = Education.FindEducation(Education.currentid);
            if (education != null) {
                $("#<%=txtEducationLevel.ClientID%>").select2("val", education.EducationLevel);
                $("#<%=txtSchool.ClientID%>").select2("val", education.UniversityID);
                if (education.UniversityID == 1) {
                    $("#otherschool").show();
                }
                $("#<%=txtOtherSchool.ClientID%>").val(education.OtherUniversity);
                $("#<%=txtMajor.ClientID%>").select2("val", education.MajorID);
                if (education.MajorID == 1) {
                    $("#othermajor").show();
                }
                $("#<%=txtOtherMajor.ClientID%>").val(education.OtherMajor);
                $("#<%=txtEnteredAt.ClientID%>").val(education.Enteredat);
                $("#<%=txtGraduatedAt.ClientID%>").val(education.Graduated);
                $("#titlePopup").text("EDIT EDUCATION");
            }
            else {
                $("#titlePopup").text("ADD EDUCATION");
            }
        }
    });

    var AddEducation =
            {
                Save: function () {
                    if ($("#txtEducationLevel").val().trim() == "") {
                        alertSmallBox("Please select education level", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtSchool").val().trim() == "") {
                        alertSmallBox("Please select school", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtSchool").val() == 1) {
                        if ($("#txtOtherSchool").val().trim() == "") {
                            alertSmallBox("if you select school is Other, Please insert name of school", "Can't save", "Error");
                            return;
                        }
                    }
                    if ($("#txtMajor").val().trim() == "") {
                        alertSmallBox("Please select major", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtMajor").val() == 1) {
                        if ($("#txtOtherMajor").val().trim() == "") {
                            alertSmallBox("if you select major is Other, Please insert name of major", "Can't save", "Error");
                            return;
                        }
                    }
                    if ($("#txtEnteredAt").val() == "") {
                        alertSmallBox("Please input entered date", "Can't save", "Error");
                        return;
                    }
                    if (!Common.isValidDate($("#txtEnteredAt").val())) {
                        alertSmallBox("entered input format MM/dd/yyyy", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtGraduatedAt").val() == "") {
                        alertSmallBox("Please input graduated date", "Can't save", "Error");
                        return;
                    }
                    if (!Common.isValidDate($("#txtGraduatedAt").val())) {
                        alertSmallBox("graduated input format MM/dd/yyyy", "Can't save", "Error");
                        return;
                    }
                    if (new Date($("#txtGraduatedAt").val()) > new Date()) {
                        alertSmallBox("graduated date can not be greater than today.", "Can't save", "Error");
                        return;
                    }
                    confirm("Confirm", "Do you want to save data", "Save", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "SaveEducation", {
                            usereducation: {
                                ID: Education.currentid == null ? 0 : Education.currentid,
                                EducationLevel: $("#txtEducationLevel").val(),
                                UniversityID: $("#txtSchool").val(),
                                OtherUniversity: $("#txtOtherSchool").val(),
                                Enteredat: $("#txtEnteredAt").val(),
                                Graduated: $("#txtGraduatedAt").val(),
                                MajorID: $("#txtMajor").val(),
                                OtherMajor: $("#txtOtherMajor").val(),
                                UserName: GetQueryStringHash("user")
                            }
                        }, function (response) {
                            if (response.Status) {
                                if (Education.currentid == null) {
                                    alertSmallBox("Add education successfull", "1 second ago!!", "success");
                                }
                                else {
                                    alertSmallBox("Edit education successfull", "1 second ago!!", "success");
                                }
                                Education.LoadData();
                            }
                            else {
                                alertSmallBox("Save data not successful", "1 second ago!!", "error");
                                $("#remoteModal").modal("show");
                            }
                        });
                    });

                }
            }

    //function readURL(input) {
    //    var val = $(input).val();

    //    switch (val.substring(val.lastIndexOf('.') + 1).toLowerCase()) {
    //        case 'gif': case 'jpg': case 'png':
    //            break;
    //        default:
    //            $(input).val('');
    //            alertSmallBox("Please select image", "Only support *.png, *.jpg, *.gif", "Error");
    //            return;
    //    }

    //    if (input.files && input.files[0]) {
    //        var reader = new FileReader();
    //        reader.onload = function (e) {
    //            $('#imgAvatarUpdate')
    //              .attr('src', e.target.result);
    //        };
    //        reader.readAsDataURL(input.files[0]);
    //    }
    //}


    //var UpdateAvatar = {
    //    Update: function () {
    //        if (!(inputFileAvatar.files && inputFileAvatar.files[0])) {
    //            alertSmallBox("Upload image failed", "Please select image file", "error");
    //            return;
    //        }

    //        confirm("Confirm", "Do you want to save data", "Save", "Cancel", function () {
    //            var data = new FormData();
    //            var files = $('#inputFileAvatar').get(0).files;
    //            if (files.length > 0) {
    //                data.append("file", files[0]);
    //            }
    //            data.append("username", PersonalDetail.currentuser);
    //            $.ajax({
    //                type: "POST",
    //                url: "/account/AJAXImportAvatar.ashx",
    //                contentType: false,
    //                processData: false,
    //                data: data,
    //                success: function (response) {
    //                    var obj = JSON.parse(response);
    //                    if (obj.Status) {
    //                        $("#imgAvatar").attr("src", obj.Link);
    //                        PersonalDetail.oriImg.attr("src", obj.Link);
    //                        alertSmallBox("Update avatar success", "1 second ago", "success");
    //                        $("#remoteModal").modal("hide");
    //                    }
    //                    else {
    //                        alertSmallBox("Update avatar failed", "1 second ago", "error");
    //                    }
    //                }

    //            });


    //        });
    //    }
    //};




</script>
