<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="DeviceManagement.hr.AddUser" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>

<link href="/device/style/styleText.css" rel="stylesheet" />
<script type="text/javascript">
    var teams = JSON.parse('<%=GetAllTeam()%>');
    var jobTitles = JSON.parse('<%=GetAllTitle()%>');
    var permissions = JSON.parse('<%=GetAllPermission()%>');
    $("#formAddUser").delay(500).fadeIn(500).verticalAlign(750);
    loadComboBox();

    function loadComboBox() {
        var i;
        for (i = 0; i <= teams.length - 1; i++) {
            if (teams[i].substring(teams[i].indexOf('/') + 1) != "") {
                var com = "<option value=" + "'" + teams[i].substring(0, teams[i].indexOf('/')) + "'>" + teams[i].substring(teams[i].indexOf('/') + 1) + "</option>";
                $('#txtTeam').append(com);
            }
        }
        $("#s2id_txtTeam").find("span.select2-chosen").text(teams[0].substring(teams[0].indexOf('/') + 1))

        for (i = 0; i <= jobTitles.length - 1; i++) {
            if (jobTitles[i].substring(jobTitles[i].indexOf('/') + 1) != "") {
                var com = "<option value=" + "'" + jobTitles[i].substring(0, jobTitles[i].indexOf('/')) + "'>" + jobTitles[i].substring(jobTitles[i].indexOf('/') + 1) + "</option>";
                $('#txtTitle').append(com);
            }
        }
        $("#s2id_txtTitle").find("span.select2-chosen").text(jobTitles[0].substring(jobTitles[0].indexOf('/') + 1))
        for (i = 0; i <= permissions.length - 1; i++) {
            if (permissions[i].substring(permissions[i].indexOf('/') + 1) != "") {
                var com = "<option value=" + "'" + permissions[i].substring(0, permissions[i].indexOf('/')) + "'>" + permissions[i].substring(permissions[i].indexOf('/') + 1) + "</option>";
                $('#txtPermission').append(com);
            }
        }
        $("#s2id_txtPermission").find("span.select2-chosen").text(permissions[0].substring(permissions[0].indexOf('/') + 1))

    }

    function addUser() {
        if ($('#txtFullName').val() == "") {
            alertbox("Please input full information!");
            return;
        }
        if ($('#txtSingleID').val() == "") {
            alertbox("Please input full information!");
            return;
        }
        //if ($('#txtGEN').val() == "") {
        //    alertbox("Please input full information!");
        //    return;
        //}
        //if ($('#txtPhone').val() == "") {
        //    alertbox("Please input full information!");
        //    return;
        //}
        if ($('#txtTeam').val() == "") {
            alertbox("Please input full information!");
            return;
        }
        if ($('#txtTitle').val() == "") {
            alertbox("Please input full information!");
            return;
        }
        if ($('#txtPermission').val() == "") {
            alertbox("Please input full information!");
            return;
        }
        var temp = {
            "FullName": $("#txtFullName").val(),
            "SingleID": $("#txtSingleID").val(),
            "Gender": $("#txtGender").val(),
            "GEN": $("#txtGEN").val(),
            "DateOfBirth": $("#txtDateOfBirth").val(),
            "PhoneNo": $("#txtPhone").val(),
            "Team": $("#txtTeam").val(),
            "DateJoin": $("#txtDateJoin").val(),
            "Title": $("#txtTitle").val(),
            "Permission": $("#txtPermission").val(),
            "Active": $("#rdActive").get(0).checked
        };
        
        AJAXFunction.CallAjax("POST", "/hr/AddUser.aspx", "addUser",
            {
                userClass: temp
            },
            function (response) {
                if (response.Status) {
                    alertSmallBox("Add new user successful!", "", "Success");
                    LoadData(currentpage);
                    $('#remoteModal').modal("hide");
                }
                else {
                    alertbox("Add new user error!");
                }
            });
    }

    function reset() {
        document.getElementById("txtFullName").value = "";
        document.getElementById("txtSingleID").value = "";
        document.getElementById("txtGender").value = "";
        document.getElementById("txtGEN").value = "";
        document.getElementById("txtDateOfBirth").value = "01/01/2014";
        document.getElementById("txtPhone").value = "";
        document.getElementById("txtTeam").value = "";
        document.getElementById("txtDateJoin").value = "01/01/2014";
        document.getElementById("txtTitle").value = "";
        document.getElementById("txtPermission").value = "";
        document.getElementById("rdActive").get(0).checked = true;
    }

    $(document).ready(function () {
        $("#txtGender").select2();
        $("#txtTeam").select2();
        $("#txtPermission").select2();
        $("#txtTitle").select2();
    });
</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="formAddUser">
    <form id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" id="spanTitle">USER REGISTRATION
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px;">
            <div class="row" style="margin-top: 10px">
                <section class="row" style="margin-left: 10px; margin-right: 10px">
                    <label class="label labelform" style="padding-bottom: 0px; border-bottom-width: 0px; margin-bottom: 0px;">
                        Persional Information</label>
                    <div style="height: 1px; background-color: black">
                    </div>
                </section>
            </div>
            <div class="row" style="margin-top: 30px">
                <section class="col col-2">
                    <label class="label labelform">Full Name</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <input type="text" id="txtFullName" value="" />
                    </label>
                </section>
                <section class="col col-2">
                    <label class="label labelform">Single ID</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <input type="text" id="txtSingleID" value="" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-2">
                    <label class="label labelform">Gender</label>
                </section>
                <section class="col col-4">
                    <select id="txtGender" class="select2" style="width: 100%;">
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Female">Other</option>
                    </select>
                </section>
                <section class="col col-2">
                    <label class="label labelform">GEN</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <input type="text" id="txtGEN" value="" onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-2">
                    <label class="label labelform">Date of birth</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <input type="text" name="request" id="txtDateOfBirth" class="datepicker" data-dateformat='mm/dd/yy' value="01/01/2014" />
                    </label>
                </section>
                <section class="col col-2">
                    <label class="label labelform">Phone No.</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <input type="text" id="txtPhone" value="" onkeypress='return event.charCode >= 48 && event.charCode <= 57' />
                    </label>
                </section>
            </div>
            <div class="row" style="margin-top: 10px">
                <section class="row" style="margin-left: 10px; margin-right: 10px">
                    <label class="label labelform" style="padding-bottom: 0px; border-bottom-width: 0px; margin-bottom: 0px;">
                        Work Information</label>
                    <div style="height: 1px; background-color: black">
                    </div>
                </section>
            </div>
            <div class="row" style="margin-top: 30px">
                <section class="col col-2">
                    <label class="label labelform">Team</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <select id="txtTeam" class="select2" style="width: 100%;">
                        </select>
                    </label>
                </section>
                <section class="col col-2">
                    <label class="label labelform">Date Join</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <input type="text" name="request" id="txtDateJoin" class="datepicker" data-dateformat='mm/dd/yy' value="01/01/2014" />
                    </label>
                </section>
            </div>
            <div class="row">
                <section class="col col-2">
                    <label class="label labelform">Title</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <select id="txtTitle" class="select2" style="width: 100%;">
                        </select>
                    </label>
                </section>
            </div>
            <div class="row" style="margin-top: 10px">
                <section class="row" style="margin-left: 10px; margin-right: 10px">
                    <label class="label labelform" style="padding-bottom: 0px; border-bottom-width: 0px; margin-bottom: 0px;">
                        Permission</label>
                    <div style="height: 1px; background-color: black">
                    </div>
                </section>
            </div>
            <div class="row" style="margin-top: 30px">
                <section class="col col-2">
                    <label class="label labelform">Permission</label>
                </section>
                <section class="col col-4">
                    <label class="input">
                        <select id="txtPermission" class="select2" style="width: 100%;">
                        </select>
                    </label>
                </section>
                <section class="col col-2">
                    <label class="label labelform">Active</label>
                </section>
                <section class="col col-4">
                    <div class="inline-group">
                        <label class="radio">
                            <input type="radio" id="rdActive" name="radio-inline" checked="">
                            <i></i>Yes</label>
                        <label class="radio">
                            <input type="radio" name="radio-inline">
                            <i></i>No</label>
                    </div>
                </section>
            </div>
        </div>
        <div class="modal-body no-padding" style="margin: 20px auto; background: white; padding: 30px; margin-top: 10px;">
            <section>
                <div class="btn btn-sm btn btn-primary" style="float: right; margin: 2px;" onclick="addUser();">Submit Registration</div>
                <div class="btn btn-sm btn btn-primary " style="float: right; margin: 2px;" onclick="reset();">Reset</div>
            </section>
            <div style="clear: both"></div>
        </div>

    </form>
</div>
