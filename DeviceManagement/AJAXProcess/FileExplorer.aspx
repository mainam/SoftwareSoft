<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileExplorer.aspx.cs" Inherits="SELPORTAL.AJAXProcess.FileExplorer" %>

<style>
    .smart-form .input input, .smart-form .select select, .smart-form .textarea textarea {
        height: 34px;
    }
</style>
<link href="/device/style/styleText.css" rel="stylesheet" />
<style>
    .stylefile {
        margin: 20px auto;
        border: 1px solid #e7e7e7;
        border-radius: 5px;
        background: #fff;
        box-shadow: 1px 1px 0px 1px rgba(0,0,0,0.07);
        padding: 17px;
    }

    .btn-insert {
        width: 100%;
        padding: 2px;
        bottom: 0px;
        margin-top: 10px;
    }
</style>

<script type="text/javascript">
    var currentpage = 1;


    $(document).ready(function () {
        $("#divBorrowPopup").delay(500).fadeIn(500).verticalAlign(665);
    });

    $('#inputSearchFile').keypress(function (event) {
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            LoadData(1);
        }
    });


    function LoadData(page) {
        currentpage = page;
       
        var numberinpage = 12;
        if (folder == null)
            folder = "Uploads/AttachFiles";
        if (byuser == null)
            byuser == false;
        if (byuser != true && byuser != false)
            byuser = false;

        AJAXFunction.CallAjax("POST", "/AjaxProcess/FileExplorer.aspx", "GetFile", {

            folder: folder,
            byuser: byuser,
            type: $("#ddlFileType").text() == "Image" ? 1 : 2,
            numberinpage: numberinpage,
            keyword: $("#inputSearchFile").val(),
            currentpage: page
        }, function (obj) {
            if (obj.Status) {
                var divtotalitem = $('#divtotalitem').empty();
                divtotalitem.append('Total File: ' + obj.TotalItem)
                var _totalpage = Math.round(obj.TotalItem / numberinpage);
                var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                listdevices = obj.Data;
                ShowData(obj.Data, (numberinpage * (page - 1)));
                AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
            }
            else {
                alertSmallBox("Can't load file in this time, please contact ngoc.nam@samsung.com", "1 second ago", "error");
            }
        });
    }

    function ShowData(listfile) {
        var div = $('#divFiles').empty();
        if ($("#ddlFileType").text() == "Image") {
            for (var i = 0; i < listfile.length; i++) {
                var filename = listfile[i].split('\\').pop().replace("\\", "");

                var divtem = $("<div class='stylefile' style='margin-left:20px; width:100px; height: 150px; float:left'>");
                var img = $("<img style='width:100px; height: 100px; '>").attr("src", listfile[i]);
                divtem.append(img);
                var divfilename = $("<marquee  SCROLLDELAY=200>").text(filename);
                divtem.append(divfilename);
                var btn = $("<label class='btn btn-primary btn-insert'>").attr("datalink", listfile[i]).text('Insert');
                btn.click(function () {
                    ckeditor.insertHtml("<img  src='" + $(this).attr("datalink") + "'/>");
                });
                divtem.append(btn);
                div.append(divtem);
            }
        }
        else {
            for (var i = 0; i < listfile.length; i++) {
                var filename = listfile[i].split('\\').pop().replace("\\", "");
                //if(Common.EndWith(listfile.toLowerCase(),"",))
                var divtem = $("<div class='stylefile' style='margin-left:20px; width:100px; height: 150px; float:left'>");
                var img = $("<img style='width:100px; height: 100px; '>").attr("src", "/AJAXProcess/Document-Blank-icon.png");
                divtem.append(img);
                var divfilename = $("<marquee  SCROLLDELAY=200>").text(filename);
                divtem.append(divfilename);
                var btn = $("<label class='btn btn-primary btn-insert'>").attr("datalink", listfile[i]).text('Insert');
                btn.click(function () {
                    ckeditor.insertHtml("<a  href='" + $(this).attr("datalink") + "'>" + filename + "</a><br>");
                    alertSmallBox("Insert success", "", "success");
                });


                divtem.append(btn);
                div.append(divtem);
            }
        }
    }
    LoadData(1);
    function LoadFileType(type) {
        $("#ddlFileType").text(type);
        LoadData(1);

    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#inputFile2").val(input.value);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }


    function Upload() {
        if (!($('#inputFile').get(0).files && $('#inputFile').get(0).files[0])) {
            alertSmallBox("Upload failed", "Please select file", "error");
            return;
        }

        var data = new FormData();
        var files = $('#inputFile').get(0).files;
        if (files.length > 0) {
            data.append("Filedata", files[0]);
        }
        data.append("folder", folder);
        data.append("byuser", byuser);

        $.ajax({
            type: "POST",
            url: "/AJAXProcess/UploadFile.ashx",
            contentType: false,
            processData: false,
            data: data,
            success: function (response) {
                if (response.Status) {
                    LoadData(currentpage);
                    alertSmallBox("Update file successful", "1 second ago", "success");
                }
                else {
                    alertSmallBox("Update file failed", "1 second ago", "error");
                }
            }

        });
    }
</script>
<div style="background: #fff; padding: 20px; margin: auto; clear: both; width: 1000px; height: 665px; margin: auto; position: absolute; bottom: auto; left: 0; right: 0; vertical-align: middle;" id="divBorrowPopup">
    <div id="FormUpdateManDate" class="smart-form">
        <div class="modal-header" style="height: 40px; background: #3276b1; text-align: center; margin-bottom: 20px; margin: -20px; color: white; padding-top: 10px;">
            <span style="font-weight: bold; font-family: 'Open Sans',Arial,Helvetica,Sans-Serif; font-size: 20px; text-align: center;" runat="server" id="spanTitle">FILE EXPLORER
            </span>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: #fff !important; padding-right: 10px; opacity: 1">
                &times;
            </button>
        </div>
        <div style="margin-top: 30px; height: 490px;">
            <div>

                <div class="" style="padding: 0px; width: 150px; float: right; margin-right: 25px;">
                    <div class="icon-addon addon-md">
                        <input id="inputSearchFile" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                        <label for="inputSearchFile" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                    </div>
                </div>
                <div class="btn-group" style="margin-left: 20px;">
                    <label style="float: left; margin-top: 8px; font-weight: bold; margin-right: 10px;">
                        File Type
                    </label>
                    <a class="btn btn-primary" id="ddlFileType" style="width: 70px; padding: 5px;">Image</a>
                    <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);" style="padding: 5px;"><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="javascript:LoadFileType('Image');">Image</a>
                        </li>
                        <li>
                            <a href="javascript:LoadFileType('Other File');">Other File</a>
                        </li>
                    </ul>
                </div>

            </div>
            <div class="table-responsive smart-form" style="width: 100%; margin-top: 10px;">
                <div style="height: 470px; overflow: auto" id="divFiles">
                </div>
            </div>
            <div>
                <div id="divtotalitem" style="float: left; margin-top: 10px; font-weight: bold;">
                </div>

                <div id="divpaging" style="float: right; margin-top: 10px;">
                </div>
            </div>
            <fieldset style="padding-top: 0px; margin-top: 50px;">
                <label style="float: left; margin-top: 8px; font-weight: bold; margin-right: 10px;">
                    File Type
                </label>
                <label for="file" class="input input-file" style="float: left; width: 320px;">
                    <div class="button" style="margin-top: 2px;">
                        <input type="file" name="file-issue" id="inputFile" onchange="readURL(this);">Browse
                    </div>
                    <input type="text" placeholder="Select file upload" id="inputFile2" readonly="" class="form-input">
                </label>
                <label class="btn btn-primary" style="padding: 7px; margin-left: 5px; width: 90px;" onclick="Upload();">
                    Upload</label>
            </fieldset>
        </div>

    </div>
</div>
