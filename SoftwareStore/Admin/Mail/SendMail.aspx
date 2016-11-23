<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendMail.aspx.cs" Inherits="SoftwareStore.Admin.Mail.SendMail" %>

<script>
    pageSetUp();
    CKEditorSetup.InputContent("<%=txtMailContent.ClientID%>");
    $('#<%=txtSearch.ClientID%>').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            SendMail.LoadData(1);
        }
    });
    var SendMail = {
        ListData: [],
        Title: "",
        currentpage: 1,
        numberinpage: 10,
        FindMail: function (mailid) {
            for (var i = 0; i < SendMail.ListData.length; i++) {
                if (SendMail.ListData[i].ID == mailid)
                    return SendMail.ListData[i];
            }
            return null;
        },
        ShowData: function (list) {
            var divitem = $('#divlistitem').empty();
            for (var i = 0; i < list.length; i++) {
                var div = $('<div class="well taskinnovation" style="padding: 5px; margin-bottom: 5px;">');
                var div2 = $('<div class="alert-heading">');
                var a = $('<a target="_blank" href="javascript:void(0)" style="  word-break: break-all;   word-wrap: break-word; word-break: break-word;">').attr("dataid", list[i].ID);
                var b = $('<b style="color: red">').append("[" + list[i].UserName + "]");
                a.click(function () {
                    var id = $(this).attr("dataid");
                    confirm("Confirm", "Do you want to load conten of mail just selected. All data will be replace with this conten", "OK", "Cancel", function () {
                        var mail = SendMail.FindMail(id);
                        if (mail != null) {
                            $("#<%=txtSubject.ClientID%>").val(mail.Subject);
                            $("#<%=cbListTo.ClientID%>").select2("val",mail.To.split(";"));
                            $("#<%=cbListCC.ClientID%>").select2("val", mail.CC.split(";"))
                            CKEditorSetup.SetData("<%=txtMailContent.ClientID%>", mail.Content)
                        }
                        else {
                            alertSmallBox("Load data failed", "", "error");
                        }
                    });
                });
                a.append(b).append(list[i].Subject);
                div2.append(a);
                var div3 = $('<div style="margin-top: 10px;">');
                var label = $('<label style="margin-right: 20px; font-style: italic">').append('Date: ' + list[i].Date);
                div3.append(label);
                var div4 = $('<div style="clear: both;">');
                div.append(div2).append(div3).append(div4);
                divitem.append(div);
            }
        },
        LoadData: function (page) {
            SendMail.currentpage = page;
            AJAXFunction.CallAjax("POST", "/Admin/Mail/SendMail.aspx", "LoadData", {
                keyword: $('#<%=txtSearch.ClientID%>').val(),
                page: SendMail.currentpage,
                numberinpage: SendMail.numberinpage
            }, function (obj) {
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitem').empty();
                    SendMail.ListData = obj.Data;
                    divtotalitem.append('Total Item: ' + obj.TotalItem)
                    SendMail.ShowData(SendMail.ListData);
                    var totalpage = Common.GetTotalPage(SendMail.numberinpage, obj.TotalItem);
                    AJAXFunction.CreatePaging($("#divpaging"), SendMail.currentpage, totalpage, SendMail.LoadData);
                }
                else {
                    alertbox("Can't load data in this time");
                }
            });
        },
        Send: function () {
            if ($("#<%=txtSubject.ClientID%>").val() == "") {
                alertSmallBox("Please input subject for email", "", "error");
                return;
            }
            if ($("#<%=cbFrom.ClientID%>").val() == null) {
                alertSmallBox("Please select sender", "", "error");
                return;
            }
            if ($("#<%=cbListTo.ClientID%>").val() == null) {
                alertSmallBox("Please select list receiver", "", "error");
                return;
            }

            if (CKEditorSetup.GetData("<%=txtMailContent.ClientID%>").trim() == "") {
                alertSmallBox("Please input mail content", "", "error");
                return;
            }
            var countto = $("#<%=cbListTo.ClientID%>").val().length;
            var countcc = $("#<%=cbListCC.ClientID%>").val() == null ? 0 : $("#<%=cbListCC.ClientID%>").val().length;
            confirm("Comfirmation!", "Do you want to send this content to " + countto + " person" + (countto > 1 ? "s" : "") + (countcc != 0 ? (" and CC to " + countcc + " person" + (countcc > 1 ? "s" : "")) : ""), "OK Send", "Cancel", function () {
                AJAXFunction.CallAjax("POST", "/Admin/Mail/SendMail.aspx", "Send", {
                    subject: $("#<%=txtSubject.ClientID%>").val(),
                    from: $("#<%=cbFrom.ClientID%>").val(),
                    to: $("#<%=cbListTo.ClientID%>").val(),
                    cc: $("#<%=cbListCC.ClientID%>").val() == null ? [] : $("#<%=cbListCC.ClientID%>").val(),
                    content: CKEditorSetup.GetData("<%=txtMailContent.ClientID%>").trim()
                }, function (response) {
                    if (response.Status) {
                        alertSmallBox("Send Mail successful", "1 second ago", "success");
                        SendMail.Clear();
                    }
                    else {
                        alertSmallBox("Send Mail failed", "1 second ago", "error");
                    }

                });
            });
        },
        Clear: function () {
            $("#<%=txtSubject.ClientID%>").val(SendMail.Title);
            $("#<%=cbFrom.ClientID%>").select2("val", $("#<%=cbFrom.ClientID%> > option").val());
            $("#<%=cbListTo.ClientID%>").select2("val", null);
            $("#<%=cbListCC.ClientID%>").select2("val", null);
            CKEditorSetup.ClearData("<%=txtMailContent.ClientID%>");
        }
    }

    $(document).ready(function () {
        SendMail.Title = $("#<%=txtSubject.ClientID%>").val();
        SendMail.LoadData(1);
    });
</script>
<div class="row">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-paper-plane-o"></i>SendMail Service SelPortal System</h1>
    </div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">

    <div class="row">

        <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
            <div class="jarviswidget jarviswidget-sortable jarviswidget-color-teal" id="LogSendMaiLBox" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">
                <header>
                    <span class="widget-icon"><i class="fa fa-eye"></i></span>
                    <h2>Log SendMail</h2>
                </header>

                <div>

                    <div class="jarviswidget-editbox">
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body padding" style="margin-bottom: 10px;">
                        <div style="padding-bottom: 10px;">

                            <div class="icon-addon addon-md">
                                <input name="txtSearch" type="search" id="txtSearch" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server">
                                <label for="txtSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                            </div>
                        </div>

                        <div style="width: 100%;" id="divlistitem">
                        </div>
                        <div id="divtotalitem" style="float: left; margin-top: 20px; font-weight: bold;">
                        </div>

                        <div id="divpaging" style="float: right;">
                        </div>

                    </div>
                </div>
            </div>
        </article>
        <article class="col-sm-12 col-md-12 col-lg-8">
            <div class="jarviswidget jarviswidget-color-pink" id="task_content" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" runat="server" data-widget-fullscreenbutton="false">
                <header>
                    <span class="widget-icon"><i class="fa fa-edit"></i></span>
                    <h2>Send Mail </h2>

                </header>

                <div>

                    <div class="jarviswidget-editbox">
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body no-padding">
                        <div class="smart-form">
                            <fieldset>

                                <section style="margin-bottom: 10px;">
                                    <label class="labelform labelform">Subject</label>
                                    <label class="input">
                                        <i class="icon-append fa fa-user"></i>
                                        <input type="text" name="title" id="txtSubject" placeholder="Input mail subject" runat="server" />
                                    </label>
                                </section>
                                <section style="margin-bottom: 10px;" runat="server" id="divTaskForIdea">
                                    <label class="labelform labelform">From</label>
                                    <label class="input">
                                        <select class="select2" runat="server" id="cbFrom">
                                        </select>
                                    </label>
                                </section>
                                <section style="margin-bottom: 10px;">
                                    <label class="labelform labelform">To</label>
                                    <label class="input">
                                        <select class="select2" multiple="true" runat="server" id="cbListTo"></select>
                                    </label>
                                </section>
                                <section style="margin-bottom: 10px;" runat="server" id="Section2">
                                    <label class="labelform labelform">CC</label>
                                    <label class="input">
                                        <select class="select2" multiple="true" runat="server" id="cbListCC"></select>
                                    </label>
                                </section>

                                <section>
                                    <label class="input">
                                        <i class="icon-append fa fa-edit"></i>
                                        <textarea name="txtMailContent" id="txtMailContent" runat="server"></textarea>
                                    </label>
                                </section>
                                <div>
                                </div>
                            </fieldset>
                            <footer>
                                <input type="button" class="btn btn-primary" value="Send" style="width: 90px;" onclick="SendMail.Send()" />
                                <input type="button" class="btn btn-default" onclick="SendMail.Clear()" style="width: 90px;" value="Clear" />
                            </footer>
                        </div>
                    </div>
                </div>
            </div>

        </article>

    </div>



</section>
