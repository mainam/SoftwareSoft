<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Borrow.aspx.cs" Inherits="DeviceManagement.device.BorrowDevice.Borrow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/device/style/styleText.css" rel="stylesheet" />
    <link href="/css/tablecss.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <script type="text/javascript">
        Array.prototype.contains = function (k) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] === k) {
                    return true;
                }
            }
            return false;
        }
        pageSetUp();
        LoadListBorrow();

        // START AND FINISH DATEconf
        $('#startBorrow').datepicker({
            dateFormat: 'mm/dd/yy',
            prevText: '<i class="fa fa-chevron-left"></i>',
            nextText: '<i class="fa fa-chevron-right"></i>',
            onSelect: function (selectedDate) {
                $('#finishBorrow').datepicker('option', 'minDate', selectedDate);
            }
        });

        $('#finishBorrow').datepicker({
            dateFormat: 'mm/dd/yy',
            prevText: '<i class="fa fa-chevron-left"></i>',
            nextText: '<i class="fa fa-chevron-right"></i>',
            onSelect: function (selectedDate) {
                $('#startBorrow').datepicker('option', 'maxDate', selectedDate);
            }
        });


        // Click select all
        $('#btncheck').click(function (event) {  //on click 
            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]');
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
        });

        // Click select all

        function LoadListBorrow() {
            AJAXFunction.LoadUrl("/device/AjaxProcess/ListDevice.aspx?Type=getdeviceselected", function (response) {
                var res = $(response).eq(1);

                var obj = JSON.parse($(response).eq(1).text());
                LoadTable(obj);
            });
        }


        function LoadTable(list) {
            var table = $('#datatable_tabletools > tbody');
            table.empty();
            if (list.length == 0)
                EmptyTable(table, 14);
            $('#totalItem').empty().text("Total device: " + list.length);
            for (i = 0; i < list.length; i++) {
                var tr = $('<tr>');

                var td = createCheckBox(list[i].IDDevice);
                tr.append(td);

                var td = createCell(i + 1);
                tr.append(td);

                var td = createCell(list[i].Type);
                tr.append(td);

                var td = createCell(list[i].Tag);
                tr.append(td);

                var td = createCell(list[i].Model);
                tr.append(td);

                var td = createCell(list[i].Project);
                tr.append(td);

                var td = createCell(list[i].Version);
                tr.append(td);

                var td = createCellName(list[i].Manager);
                tr.append(td);

                var td = createCellName(list[i].Borrower);
                tr.append(td);

                //var td = createCellName(list[i].Keeper);
                //tr.append(td);

                var td = createCell(list[i].Status);
                tr.append(td);

                var td = createCell(list[i].IMEI);
                tr.append(td);

                var td = createCell(list[i].Serial);
                tr.append(td);

                var td = createCell(list[i].Region);
                tr.append(td);

                //var td = createCell(list[i].ReceiveDate);
                //tr.append(td);

                //var td = createCellName(list[i].Receiver);
                //tr.append(td);

                //var td = createCell(list[i].From);
                //tr.append(td);

                var td = createCell(list[i].Note);
                tr.append(td);
                table.append(tr);

            }
            set_statuses();
        }
        function createCell(text) {
            var td = $('<td>');
            if (text == null) text = "";
            var label = "<label>" + text + "</label>";
            // var input = "<input type='text' name='date' role='textbox' class='editable' style='width: 98%;'/>";
            td.append(label);
            // td.append(input);
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

        function UpdateButton() {
            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]:checked');
            if (input.length > 0)
                $('#btnDelete').removeAttr('disabled');
            else
                $('#btnDelete').attr('disabled', 'disabled');
        }

        function createCheckBox(id) {
            var td = $('<td>');
            var label = $('<label class="checkbox">');
            var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemdevice">');
            checkbox.attr('dataid', id);
            checkbox.click(function () {
                UpdateButton();
            });
            label.append(checkbox);
            label.append($('<i>'));
            td.append(label);
            return td;
        }

        // Button add
        function add() {
            AJAXFunction.CallAjax("POST", "/device/BorrowDevice/Borrow.aspx", "Search", {
                txtSearch: $('#inputSearch').val(),
                txtFrom: $('#startBorrow').val(),
                txtTo: $('#finishBorrow').val(),
                txtReason: $('#txtReason').val()
            }, function (response) {
                window.location = "Default.aspx#device/ListAllDeviceAllowBorrow.aspx";
            });
        }
        // Button delete
        function btnDelete() {

            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]');
            var arrid = [];
            var arriddel = [];
            for (var i = 0; i < input.length; i++) {
                if (!input[i].checked)
                    arrid.push($(input[i]).attr('dataid'));
                else
                    arriddel.push($(input[i]).attr('dataid'));
            }

            if (arriddel.length == 0) {
                alertbox("Please select device to delete");
            }
            else {
                var callback = function () {
                    AJAXFunction.CallAjax("POST", "/device/BorrowDevice/Borrow.aspx", "UpdateId", {
                        arrid: arrid,
                        txtFrom: $('#startBorrow').val(),
                        txtTo: $('#finishBorrow').val(),
                        txtReason: $('#txtReason').val()
                    }, function (obj) {
                        if (obj.Status)
                            location.reload();
                    });
                };
                confirm("Confirm", "Do you want to remove selected items!!", "OK", "Cancel", callback);
            }
        }
        // Button Submit
        function btnSubmit() {
            var reason = $('#txtReason').val();
            var startDate = $('#startBorrow').val();
            var endDate = $('#finishBorrow').val();

            if (!Common.IsValidDate(endDate) || !Common.IsValidDate(startDate)) {
                alertbox("Date time input invalid, please input again!!");
                return;
            }


            if (new Date(startDate) > new Date(endDate)) {
                alertbox("Start time must be prior to end time");
                return;
            }

            input = $('#datatable_tabletools > tbody').find('input[typecheckbox="itemdevice"]');
            var arrid = [];
            for (var i = 0; i < input.length; i++) {
                arrid.push($(input[i]).attr('dataid'));
            }

            var callback = function () {
                AJAXFunction.CallAjax("POST", "/device/BorrowDevice/Borrow.aspx", "borrow", {
                    listid: arrid,
                    from: startDate,
                    to: endDate,
                    reason: reason
                }, function (obj) {
                    if (obj.Status) {
                        alertbox("Send request successful !", function () {
                            window.location = "Default.aspx#device/Request.aspx";
                        });
                    }
                    else alertbox("Fail!");

                });
            }
            var fail = function () { };
            if (arrid == null || arrid.length < 1)
                alertbox("Please choose device!!");
            else {
                if (startDate == "" || endDate == "")
                    alertbox("Please fill information!!");
                else
                    confirm("Confirm", "Do you want to submit!!", "OK", "Cancel", callback);
            }
        };



        $('#inputSearch').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                //    
                //    var target = "/device/BorrowDevice.aspx";
                //    $("#remoteModal").removeData();
                //    $('#remoteModal').modal({ backdrop: 'static' });
                //    $("#remoteModal").load(target, function () {
                //        $("#remoteModal").modal("show");
                //    });

                //}
                AJAXFunction.CallAjax("POST", "device/BorrowDevice/Borrow.aspx", "Search", { keyword: $('#inputSearch').val() }, function (response) {
                    if (response.Status) {
                        var typesearch = GetQueryStringHash("type");
                        if (typesearch == "borrowreturndevice")
                            location.replace("#device/BorrowDevice/BorrowDeviceHaveReturn.aspx");
                        else
                            location.replace("#device/ListAllDeviceAllowBorrow.aspx");
                    }
                });
            }
        });


    </script>
</head>
<body>
    <div class="row" style="margin-top: 0px">
        <div class="alert alert-info alert-block" style="margin-left: 10px;">
            <h4 class="alert-heading">Borrow device</h4>
        </div>



        <!-- NEW WIDGET START -->
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget  jarviswidget-color-teal" id="listborrow" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <%--<span class="widget-icon"><i class="fa fa-table"></i></span>--%>
                    <h2>Devices borrow</h2>
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
                        <div class="row" style="margin-bottom: 5px;">
                            <article class="col-xs-12 col-sm-3 col-md-3 col-lg-3 sortable-grid ui-sortable pull-right">
                                <div class="col-md-12" style="padding: 0px;">
                                    <div class="icon-addon addon-md">
                                        <input id="inputSearch" type="search" placeholder="Enter keyword to search" class="form-control" aria-controls="dt_basic" />
                                        <label for="inputSearch" class="glyphicon glyphicon-search" rel="tooltip" title="" data-original-title="search"></label>
                                    </div>
                                </div>
                            </article>
                        </div>
                        <div class="table-responsive smart-form">
                            <div style="height: 400px; overflow: auto; border: 1px solid #ddd;">
                                <table id="datatable_tabletools" class="table table-striped table-bordered table-hover" style="min-width: 1600px;">
                                    <thead>
                                        <tr>
                                            <th class="theadtable" style="width: 20px;">
                                                <label class="checkbox">
                                                    <input type="checkbox" id="btncheck" /><i></i></label>
                                            </th>
                                            <th class="theadtable" style="width: 30px;">No</th>
                                            <th class="theadtable" style="width: 60px;">Type</th>
                                            <th class="theadtable" style="width: 30px;">#Tag</th>
                                            <th class="theadtable" style="width: 130px;">Model</th>
                                            <th class="theadtable" style="width: 80px;">Project</th>
                                            <th class="theadtable" style="width: 20px;">Version</th>
                                            <th class="theadtable" style="width: 170px;">Manager</th>
                                            <th class="theadtable" style="width: 180px;">Borrower</th>
                                            <th class="theadtable" style="width: 50px;">Status</th>
                                            <th class="theadtable" style="width: 120px;">IMEI</th>
                                            <th class="theadtable" style="width: 120px;">S/N</th>
                                            <th class="theadtable">Region</th>
                                            <th class="theadtable" style="width: 120px;">Note</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div id="totalItem" style="font-size: 15px; font-weight: bold; margin-top: 10px;">
                            </div>
                        </div>
                    </div>
                    <!-- end widget content -->

                </div>
                <!-- end widget div -->
            </div>

        </article>
        <div class=" pull-right">
            <input class="btn btn-primary" type="button" value="Delete" id="btnDelete" disabled="disabled" style="width: 95px; margin-bottom: 10px;" onclick="btnDelete();" />
        </div>


        <!-- WIDGET END -->

    </div>

    <div class="row">


        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

            <!-- Widget ID (each widget will need unique ID)-->
            <div class="jarviswidget  jarviswidget-color-teal" id="listborrowinformation" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                <header>
                    <h2>Information</h2>
                </header>
                <!-- widget div-->

                <div>

                    <div class="widget-body pading smart-form">
                        <div class="form-group padding">
                            <div class="col-md-6">
                                <fieldset style="margin-top: -10px; padding: 10px;">
                                    <div class="row">
                                        <section class="col col-6">
                                            <label class="labelform">
                                                From
                                            </label>
                                            <label class="input">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                                <input type="text" id="startBorrow" runat="server" placeholder=" From" class="form-control" />
                                            </label>
                                        </section>
                                        <section class="col col-6">
                                            <label class="labelform">
                                                To
                                            </label>
                                            <label class="input">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                                <input type="text" id="finishBorrow" runat="server" placeholder=" To" class="form-control" />
                                            </label>
                                        </section>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="col-md-12" style="margin-top: -19px;">
                                <fieldset style="padding: 0px 25px;">
                                    <div class="row">
                                        <section>
                                            <label style="margin-bottom: 0px; margin-top: 10px;" class="labelform">Reason</label>
                                            <label class="input">
                                                <textarea id="txtReason" runat="server" class="form-control" placeholder=" Reason for borrow" rows="3" style="font-size: 15px; height: 100%;"></textarea>
                                            </label>
                                        </section>
                                    </div>
                                </fieldset>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </article>
        <div class=" pull-right">
            <input class="btn btn-primary" type="button" value="Submit" style="width: 95px;" onclick="btnSubmit();" />
        </div>
    </div>

    <div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</body>
</html>
