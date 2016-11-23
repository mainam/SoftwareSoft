<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddLanguage.aspx.cs" Inherits="SoftwareStore.hr.dialog.AddLanguage" %>

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
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 500px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="popupAddLanguage">
    <div class="modal-header" style="height: 50px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white;">
        <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" id="titlePopup">ADD LANGUAGE
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
                        <label class="label">Language (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtLanguage" style="width: 100%;" runat="server"></select>
                        </label>
                    </section>
                    <section id="otherlanguage">
                        <label class="label">Input Language (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <input type="text" id="txtOtherLanguage" runat="server">
                        </label>
                    </section>
                    <section>
                        <label class="label">Overall (*)</label>
                        <label class="input">
                            <input class="input" type="number" min="0" id="txtOverall" style="width: 100%;" runat="server" value="1" />
                            <%--                            <select class="select2" id="txtOverall" style="width: 100%;" runat="server">
                                <option value="1">Excellent
                                </option>
                                <option value="2">Average
                                </option>
                                <option value="3">Not Qualified
                                </option>
                            </select>--%>
                        </label>
                    </section>

                    <section>
                        <label class="label">Speak (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtSpeak" style="width: 100%;" runat="server">
                                <option value="1">Excellent
                                </option>
                                <option value="2">Average
                                </option>
                                <option value="3">Not Qualified
                                </option>
                            </select>
                        </label>
                    </section>
                    <section>
                        <label class="label">Read (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtRead" style="width: 100%;" runat="server">
                                <option value="1">Excellent
                                </option>
                                <option value="2">Average
                                </option>
                                <option value="3">Not Qualified
                                </option>
                            </select>
                        </label>
                    </section>
                    <section>
                        <label class="label">Write (*)</label>
                        <label class="input">
                            <i class="icon-append fa fa-question-circle"></i>
                            <select class="select2" id="txtWrite" style="width: 100%;" runat="server">
                                <option value="1">Excellent
                                </option>
                                <option value="2">Average
                                </option>
                                <option value="3">Not Qualified
                                </option>
                            </select>
                        </label>
                    </section>
                    <section>
                        <label class="label" style="display: inline">Native</label>
                        <label class="checkbox state-success" style="display: inline-block;">
                            <input type="checkbox" name="checkbox" id="chbNative" checked=""><i></i></label>
                    </section>

                </fieldset>
                <section class="col col-6" style="text-align: right; float: right">
                    <div class="btn btn-sm btn-default" style="float: right; margin: 2px; margin-right: 0px; width: 90px;" data-dismiss="modal">CANCEL</div>
                    <div class="btn btn-sm btn-primary" style="float: right; margin: 2px; width: 90px;" onclick="AddLanguage.Save(); ">SAVE</div>
                </section>
            </div>
        </div>
        <div style="clear: both"></div>
    </form>
    <div style="clear: both;"></div>

</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#popupAddLanguage").delay(500).fadeIn(500).verticalAlign(600);
        $("#txtLanguage").select2();
        $("#txtSpeak").select2();
        $("#txtRead").select2();
        $("#txtWrite").select2();
        $this = $(this);

        if ($("#txtLanguage").val() == 1)
            $("#otherlanguage").show();
        else
            $("#otherlanguage").hide();
        $("#txtLanguage").change(function () {
            if ($("#txtLanguage").val() == 1)
                $("#otherlanguage").show();
            else
                $("#otherlanguage").hide();
        });


        if (Language.currentid != null) {

            var language = Language.FindLanguage(Language.currentid);
            if (language != null) {
                $("#<%=txtLanguage.ClientID%>").select2("val", language.Languageid);
                if (language.Languageid == 1) {
                    $("#otherlanguage").show();
                }
                $("#<%=txtOtherLanguage.ClientID%>").val(language.OtherLanguage);
                $("#<%=txtOverall.ClientID%>").val(language.ScoreOverall);

                $("#<%=txtSpeak.ClientID%>").val(language.ScoreSpeak);
                $("#<%=txtRead.ClientID%>").val(language.ScoreRead);
                $("#<%=txtWrite.ClientID%>").val(language.ScoreWrite);
                $("#chbNative").get(0).checked = language.Native;
                $("#titlePopup").text("EDIT LANGUAGE");
            }
            else {
                $("#titlePopup").text("ADD LANGUAGE");
            }
        }
    });

    var AddLanguage =
            {
                Save: function () {
                    if ($("#txtLanguage").val().trim() == "") {
                        alertSmallBox("Please select language", "Can't save", "Error");
                        return;
                    }


                    if ($("#txtLanguage").val() == 1) {
                        if ($("#txtOtherLanguage").val().trim() == "") {
                            alertSmallBox("if you select language is Other, Please insert name of language", "Can't save", "Error");
                            return;
                        }
                    }
                    if ($("#txtOverall").val().trim() == "") {
                        alertSmallBox("Please select Overall", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtSpeak").val().trim() == "") {
                        alertSmallBox("Please select Speak", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtRead").val().trim() == "") {
                        alertSmallBox("Please select Read", "Can't save", "Error");
                        return;
                    }
                    if ($("#txtWrite").val().trim() == "") {
                        alertSmallBox("Please select Write", "Can't save", "Error");
                        return;
                    }

                    confirm("Confirm", "Do you want to save data", "Save", "Cancel", function () {
                        AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "SaveLanguage", {
                            userlanguage: {
                                ID: Language.currentid == null ? 0 : Language.currentid,
                                Languageid: $("#txtLanguage").val(),
                                OtherLanguage: $("#txtOtherLanguage").val(),
                                Native: $("#chbNative").get(0).checked,
                                ScoreOverall: $("#txtOverall").val(),
                                ScoreSpeak: $("#txtSpeak").val(),
                                ScoreRead: $("#txtRead").val(),
                                ScoreWrite: $("#txtWrite").val(),
                                UserName: GetQueryStringHash("user")
                            }
                        }, function (response) {
                            if (response.Status) {
                                if (Language.currentid == null) {
                                    alertSmallBox("Add language successfull", "1 second ago!!", "success");
                                }
                                else {
                                    alertSmallBox("Edit language successfull", "1 second ago!!", "success");
                                }
                                Language.LoadData();
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
