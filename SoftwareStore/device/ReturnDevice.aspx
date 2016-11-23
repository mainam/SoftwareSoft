<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnDevice.aspx.cs" Inherits="SoftwareStore.device.ReturnDevice" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/css/tablecss.css" rel="stylesheet" />
    <script src="/js/plugin/morris/morris.min1.js"></script>
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <script type="text/javascript">

        pageSetUp();


        var listtype = JSON.parse('<%=SoftwareStore.device.DeviceManagement.ListCategoryDevice()%>');
        function LoadListCategory() {
            var ul = $('#ulddltype').empty();
            var a = $('<a href="javascript:void(0)">').text("All");
            a.attr('dataid', 0);
            a.click(function () {
                $('#ddlType').text($(this).text());
                $('#ddlType').attr("dataid", $(this).attr("dataid"));
                LoadData(1);
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < listtype.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(listtype[i].Name);
                a.attr('dataid', listtype[i].ID);
                a.click(function () {
                    $('#ddlType').text($(this).text());
                    $('#ddlType').attr("dataid", $(this).attr("dataid"));
                    LoadData(1);
                });
                ul.append($('<li>').append(a));

            }
        }
        LoadListCategory();

        var liststatus = JSON.parse('<%=SoftwareStore.device.DeviceManagement.ListStatusDevice()%>');
        function LoadListStatus() {
            var ul = $('#ulddlstatus').empty();
            var a = $('<a href="javascript:void(0)">').text("All");
            a.attr('dataid', 0);
            a.click(function () {
                $('#ddlStatus').text($(this).text());
                $('#ddlStatus').attr("dataid", $(this).attr("dataid"));
                LoadData(1);
            });
            ul.append($('<li>').append(a));
            for (var i = 0; i < liststatus.length; i++) {
                var a = $('<a href="javascript:void(0)">').text(liststatus[i].Name);
                a.attr('dataid', liststatus[i].ID);
                a.click(function () {
                    $('#ddlStatus').text($(this).text());
                    $('#ddlStatus').attr("dataid", $(this).attr("dataid"));
                    LoadData(1);
                });
                ul.append($('<li>').append(a));
            }
        }
        LoadListStatus();


        var IDDeviceEdit;
        var listdevices = [];
        var numberdeviceinpage = 15;
        var currentpage = 1;
        var imeitext = "";

        LoadData(1);
        function ShowNumberDevice(numberdevice) {
            $("#btnSelectNumberDevice").empty().append("Show: " + numberdevice).append($('<i class="fa fa-caret-down" style="margin-left:5px;">'))
            numberdeviceinpage = numberdevice;
            LoadData(1);
        }

        function GetFullName(info) {
            var arr = info.split("/");
            if (arr.length > 1)
                return arr[1];
            return "";
        }


        function Export() {
            window.open('/device/AjaxProcess/Export.aspx?type=returndevice');
        }

        function displayManager(managers) {
            var i;

            for (i = 0; i < managers.length; i++) {
                var temp = managers[i].split(';');
                var com = "<div class='body' style='margin-bottom: 10px; margin-top: 10px; text-align:left;'><a href='sip:" + temp[0] + "@samsung.com' title='Start chat' style='color: #15c23c'> <img alt='" + temp[0] + "' class='statusMySingle' src='/js/communicator/Images/unknown.png' /> " + temp[1] + " </a></div>";
                $('#manager').append(com);
            }
        }


        function LoadTableOnStatus(filter) {
            ddlStatus.innerHTML = filter;
            LoadData(1);
        }

        function UpdateButton() {
            var listinput = $('#tablelistdevice').find('input[typecheckbox="itemdevice"]:checked');

            if (listinput.length > 0)
                $('#btnReturn').removeAttr('disabled');
            else
                $('#btnReturn').attr('disabled', 'disabled');
        }

        function LoadHeader() {
            var table = $('#tablelistdevice > thead').empty();
            var tr = $('<tr>');
            var td = $('<th style="width: 20px; text-align: center;">').append($(' <label class="checkbox">').append($('<input type="checkbox" id="btncheck">').click(function () {
                input = $('#tablelistdevice > tbody').find('input[typecheckbox="itemdevice"][disabled!="disabled"]');
                if (this.checked) {
                    for (var i = 0; i < input.length; i++) {
                        input[i].checked = true;
                    }
                }
                else {
                    for (var i = 0; i < input.length; i++) {
                        input[i].checked = false;
                    }
                }
                UpdateButton();
            })).append($('<i>')));
            tr.append(td);
            tr.append('<th class="theadtable" style="width: 60px;">Type</th>');
            tr.append('<th class="theadtable" style="width: 30px;">#Tag</th>');
            tr.append('<th class="theadtable" style="width: 130px;">Model</th>');
            tr.append('<th class="theadtable" style="width: 20px;">Version</th>');
            tr.append('<th class="theadtable" style="width: 170px;">Manager</th>');
            tr.append('<th class="theadtable" style="width: 180px;">Borrower</th>');
            tr.append('<th class="theadtable" style="width: 90px;">Borrowed date</th>');
            tr.append('<th class="theadtable" style="width: 90px;">Return date</th>');
            tr.append('  <th class="theadtable" style="width: 70px;">Status</th>');
            tr.append(' <th class="theadtable" style="width: 130px;">IMEI</th>');
            tr.append('  <th class="theadtable" style="width: 130px;">S/N</th>');
            tr.append('<th style="text-align: center;">Note</th>');
            table.append(tr);
        }


        function LoadTable(list) {
            LoadHeader();
            var table = $('#tablelistdevice > tbody');
            table.empty();
            UpdateButton();
            listIDCheckBox = [];
            if (list.length == 0) {
                EmptyTable(table, 15);
            }

            for (i = 0; i < list.length; i++) {
                listIDCheckBox.push(list[i].IDDevice);

                var tr = $('<tr>');
                var tr1 = $('<tr>');
                var td = createCheckBox(list[i].IDDevice, true, false);
                tr.append(td);
                var td = createCell(list[i].Type);
                tr.append(td);


                var td = createCell(list[i].Tag);
                tr.append(td);

                var td = createCell(list[i].Model);
                tr.append(td);

                var td = createCell(list[i].Version);
                tr.append(td);

                var td = createCellName(list[i].Manager);
                tr.append(td);

                var td = createCellName(list[i].Borrower);
                tr.append(td);

                var td = createCellNameNoImage(list[i].Keeper);
                tr1.append(td);

                if (list[i].Borrower != null && list[i].Borrower != "") {
                    var td = createCell(list[i].BorrowDate);
                    tr.append(td);

                    var td = createCell(list[i].BorrowDate);
                    tr1.append(td);

                    var td = createCell(list[i].ReturnDate);
                    tr.append(td);

                    var td = createCell(list[i].ReturnDate);
                    tr1.append(td);
                }
                else {
                    var td = createCell("");
                    tr.append(td);

                    var td = createCell("");
                    tr1.append(td);

                    var td = createCell("");
                    tr.append(td);

                    var td = createCell("");
                    tr1.append(td);
                }

                var td = $("<td style='vertical-align: middle;'>");//createCell(list[i].Status);
                switch (list[i].Status) {
                    case "Good":
                        td.append(Common.CreateLabelStylePrimary(list[i].Status));
                        break;
                    case "Broken":
                        td.append(Common.CreateLabelStyleWarning(list[i].Status));
                        break;
                    case "Loss":
                        td.append(Common.CreateLabelStyleDanger(list[i].Status));
                        break;
                }
                tr.append(td);

                var td = createCell(list[i].IMEI);
                tr.append(td);

                var td = createCell(list[i].Serial);
                tr.append(td);

                var td = createCell(list[i].From);
                tr1.append(td);

                var td = createCell(list[i].Note);
                tr.append(td);

                table.append(tr);
            }
        }

        function createCell(text) {
            var td = $('<td>');
            if (text == null) text = "";
            var label = "<label>" + text + "</label>";
            td.append(label);
            return td;
        }
        function createCellName(idCommunicator) {
            if (idCommunicator == "") return createCell("");
            var td = $('<td>');
            var id, name, index = idCommunicator.indexOf('/');
            id = idCommunicator.substring(0, index);
            name = idCommunicator.substring(index + 1, idCommunicator.length);
            var com = "<a href='sip:" + id + "@samsung.com' title='Start chat' style='color: #17375D;'> <img alt='" + id + "' class='statusMySingle' src='/js/communicator/Images/unknown.png' /> " + name + " </a>";
            td.append(com);
            return td;
        }

        function createCellNameNoImage(idCommunicator) {
            if (idCommunicator == "") return createCell("");
            var td = $('<td>');
            var id, name, index = idCommunicator.indexOf('/');
            id = idCommunicator.substring(0, index);
            name = idCommunicator.substring(index + 1, idCommunicator.length);
            var com = "<a href='sip:" + id + "@samsung.com' title='Start chat' style='color: #17375D;'> " + name + " </a>";
            td.append(com);
            return td;
        }


        function createCheckBox(id, allowborrow, check) {
            var td = $('<td>');
            var label = $('<label class="checkbox">');
            var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemdevice">');
            if (check) {
                checkbox.attr("checked", "checked");
            }
            checkbox.attr('dataid', id);
            label.append(checkbox);
            label.append($('<i>'));
            checkbox.click(function () {
                UpdateButton();
            });
            if (!allowborrow) {
                label.addClass('state-disabled');
                checkbox.attr('disabled', 'disabled');
            }
            td.append(label);
            return td;
        }


        //// Search and load data on table
        $('#inputSearch, #inputSearch2').keydown(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                setTimeout(function () {
                    LoadData2(1);
                });
            }
        });
        //////// Search and load data on table
        //$('#inputSearch, #inputSearch2').change(function () {
        //    //var keycode = (event.keyCode ? event.keyCode : event.which);
        //    //if (keycode == '13') {
        //    setTimeout(function () {
        //        listHasSelect = [];
        //        LoadData(1);
        //    }, 300);
        //    //}
        //});

        function SearchIMEI() {
            imeitext = $("#txtIMEINumber").val();
            var target = "/device/ReturnDeviceByIMEI.aspx";
            $("#remoteModal").removeData();
            $('#remoteModal').modal({ backdrop: 'static' });
            $("#remoteModal").load(target, function () {
                $("#remoteModal").modal("show");
            });
        }

        function returnDevice() {
            var listinput = $('#tablelistdevice').find('input[typecheckbox="itemdevice"]:checked');
            var callback = function () {
                var listid = [];
                for (var i = 0; i < listinput.length; i++) {
                    listid.push($(listinput[i]).attr("dataid"));
                }
                AJAXFunction.CallAjax("POST", "/device/ReturnDevice.aspx", "Return", {
                    arrid: listid,
                }, function (response) {
                    LoadData(currentpage)
                });
            };
            if (listinput.length == 0) {
                alertbox("Please select devices want to return ");
            }
            else {
                confirm("Confirm", "Do you want to return list devices selected", "OK", "Cancel", callback);
            }
        }



        function LoadData(page) {
            currentpage = page;

            var type = $("#ddlType").attr("dataid");
            var status = $("#ddlStatus").attr("dataid");
            var keyword = $('#inputSearch').val();
            var keyword2 = $('#inputSearch2').val();
            var numberinpage = numberdeviceinpage;
            AJAXFunction.CallAjax("POST", "/device/ReturnDevice.aspx", "LoadData", {
                type: type,
                status: status,
                keyword: keyword,
                keyword2: keyword2,
                currentpage: page,
                numberinpage: numberinpage
            },
                function (obj) {
                    if (obj.Status) {
                        var divtotalitem = $('#divtotalitem').empty();
                        divtotalitem.append('Total Device: ' + obj.TotalItem)
                        var _totalpage = Math.round(obj.TotalItem / numberinpage);
                        var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                        listdevices = obj.Data;
                        LoadTable(obj.Data);
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                    }
                });
        }

        function LoadData2(page) {
            currentpage = page;

            var type = $("#ddlType").attr("dataid");
            var status = $("#ddlStatus").attr("dataid");
            var keyword = $('#inputSearch').val();
            var keyword2 = $('#inputSearch2').val();
            var numberinpage = numberdeviceinpage;
            AJAXFunction.CallAjaxNoLoading("POST", "/device/ReturnDevice.aspx", "LoadData", {
                type: type,
                status: status,
                keyword: keyword,
                keyword2: keyword2,
                currentpage: page,
                numberinpage: numberinpage
            },
                function (obj) {
                    if (obj.Status) {
                        var divtotalitem = $('#divtotalitem').empty();
                        divtotalitem.append('Total Device: ' + obj.TotalItem)
                        var _totalpage = Math.round(obj.TotalItem / numberinpage);
                        var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                        listdevices = obj.Data;
                        LoadTable(obj.Data);
                        AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                    }
                });
        }

        function SearchByIMEI() {
            AJAXFunction.CallAjax("POST", "/device/ReturnDevice.aspx", "LoadDataByIMEI", {
                ListIMEI: $("#txtIMEINumber").val()
            }, function (obj) {
                if (obj.Status) {
                    var divtotalitem = $('#divtotalitem').empty();
                    divtotalitem.append('Total Device: ' + obj.TotalItem)
                    listdevices = obj.Data;
                    LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($("#divpaging"), 1, 1, LoadData);
                    $("#remoteModal").modal("hide");
                }
            });
        }

    </script>

</head>
<body>
    <section id="widget-grid" class="">

        <div class="row" style="margin-left: 0px; margin-bottom: 5px;">
            <div class="alert alert-info alert-block">
                <h4 class="alert-heading">Return device</h4>
            </div>

            <article class="col-xs-12 col-sm-6 col-md-6 col-lg-6 sortable-grid ui-sortable">
                <label class="label" style="float: left;">Type</label>
                <div class="btn-group">
                    <div class="btn-group">
                        <a class="btn btn-primary" id="ddlType" style="width: 90px" dataid="0">All</a>
                        <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>

                        <ul class="dropdown-menu" id="ulddltype">
                            <li>
                                <a href="javascript:LoadTableOnType('All');">All</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnType('Phone');">Phone</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnType('Camera');">Camera</a>
                            </li>
                            <li>
                                <a href="javascript:LoadTableOnType('Equipment');">Equipment</a>
                            </li>
                        </ul>
                    </div>

                    <label class="label" style="float: left;">Status</label>
                    <div class="btn-group">
                        <a class="btn btn-primary" id="ddlStatus" style="width: 70px" dataid="0">All</a>
                        <a class="btn btn-primary dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><span class="caret"></span></a>
                        <ul class="dropdown-menu" id="ulddlstatus">
                        </ul>
                    </div>
                    <input class="btn btn-primary" type="button" id="btnEnterIMEI" value="Enter IMEI" style="margin-left: 10px; width: 95px" onclick="SearchIMEI();" />
                    <input class="btn btn-primary" type="button" id="btnReturn" disabled="disabled" value="Return" style="margin-left: 10px; width: 95px" onclick="returnDevice();" />
                </div>
            </article>

            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable pull-right">
                <div class="col-md-12" style="padding: 0px;">
                    <div class="icon-addon addon-md">
                        <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" data-html="true" rel="popover-hover" data-placement="top" data-original-title="Help" data-content="you can use the following format to search: <br>keyword1 | keyword2 | keywork3 ... <br> and <b> input 'model:model name' to search by model" />
                        <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="Enter model:keyword to search by model" data-original-title="Search"></label>
                    </div>
                </div>
            </article>
            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable" style="display: none">

                <div class="col-md-12" style="padding: 0px;">
                    <div class="icon-addon addon-md">
                        <input id="inputSearch2" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" runat="server" />
                        <label for="inputSearch2" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="Search"></label>
                    </div>
                </div>
            </article>
        </div>


        <div class="row">

            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget  jarviswidget-color-teal" id="widlistdevicereturn" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>List of devices</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->
                            <div class="btn-group">
                                <input type="button" class="btn dropdown-toggle btn-xs btn-success btnwidth" value="Export" style="margin-right: 10px;" onclick="Export();" />
                            </div>
                            <div class="btn-group">
                                <button class="btn dropdown-toggle btn-xs btn-success" data-toggle="dropdown" id="btnSelectNumberDevice" style="width: 100px;">Show: 15<i class="fa fa-caret-down" style="margin-left: 10px;"></i></button>
                                <ul class="dropdown-menu pull-right js-status-update">
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(5);">5</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(10);">10</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(15);">15</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(20);">20</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(50);">50</a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0);" onclick="ShowNumberDevice(100);">100</a>
                                    </li>
                                </ul>
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
                        <div class="widget-body">

                            <div class="table-responsive smart-form">
                                <div style="min-height: 560px; overflow: auto;">

                                    <table id="tablelistdevice" class="table table-striped table-bordered table-hover" style="min-width: 1600px;">
                                        <thead>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                                <div>
                                    <div id="divtotalitem" style="float: left; margin-top: 10px; font-weight: bold;">
                                    </div>

                                    <div id="divpaging" style="float: right; margin-top: 10px;">
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- end widget content -->

                    </div>
                    <!-- end widget div -->
                </div>

            </article>


            <!-- WIDGET END -->

        </div>



    </section>


    <div class="modal fade" id="remoteModal" tabindex="-1" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>

</body>
</html>
