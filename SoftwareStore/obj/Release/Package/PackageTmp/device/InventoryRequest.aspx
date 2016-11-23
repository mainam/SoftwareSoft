<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryRequest.aspx.cs" Inherits="DeviceManagement.device.InventoryRequest" %>

<link href="/css/tablecss.css" rel="stylesheet" />

<link href="/device/style/styleText.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />

<style type="text/css">
    #s2id_select-model {
        width: 100%;
    }
</style>

<body>


    <section id="widget-grid" class="">

        <!-- row -->
        <div class="row">
            <div class="alert alert-info alert-block" style="margin-left: 10px;">
                <h4 class="alert-heading">Inventory device</h4>
            </div>
            <!-- NEW WIDGET START -->
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget jarviswidget-color-teal" id="statisticinventory" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>Inventory statistic</h2>
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
                            <div id="line-chart-issues" class="chart has-legend" style="height: 180px;"></div>
                        </div>
                        <!-- end widget content -->

                    </div>
                    <!-- end widget div -->

                </div>

            </article>
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                <!-- Widget ID (each widget will need unique ID)-->
                <div class="jarviswidget jarviswidget-color-teal" id="listrequestinventory" data-widget-editbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false" data-widget-sortable="false" data-widget-attstyle="jarviswidget-color-teal">
                    <header>
                        <span class="widget-icon"><i class="fa fa-table"></i></span>
                        <h2>Inventory List</h2>
                        <div class="widget-toolbar" role="menu">
                            <!-- add: non-hidden - to disable auto hide -->
                            <div class="btn-group">
                                <label class="btn dropdown-toggle btn-xs btn-success" onclick="AddRequestInventory();">Add New Request</label>
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
                            <div class="table-responsive" style="min-height: 290px; width: 100%; overflow: auto">
                                <table id="tableinventory" class="table table-striped table-bordered table-hover" style="min-width: 1065px;">
                                    <thead>
                                        <tr>
                                            <th rowspan="2" class="theadtable">Request Name</th>
                                            <th rowspan="2" class="theadtable">Request Date</th>
                                            <th colspan="5" class="theadtable">Status</th>
                                            <th rowspan="2" class="theadtable" style="width: 80px">Action</th>
                                        </tr>
                                        <tr>
                                            <th style="width: 120px;" class="theadtable">Not Confirm
                                            </th>
                                            <th style="width: 120px;" class="theadtable">Not Borrow
                                            </th>
                                            <th style="width: 120px;" class="theadtable">Loss
                                            </th>
                                            <th style="width: 120px;" class="theadtable">Broken
                                            </th>
                                            <th style="width: 120px;" class="theadtable">Good
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>

                            </div>
                            <div id="divpaging" style="float: right;">
                                <ul class="pagination" style="margin: 0px !important;">
                                </ul>
                            </div>
                        </div>
                        <!-- end widget content -->

                    </div>
                    <!-- end widget div -->

                </div>

            </article>
        </div>

    </section>


    <div id="dialog-message" title="Dialog Simple Title">
        <p style="width: 500px;">

            <div class="row smart-form">
                <section class="col col-6">
                    <label class="labelform">Inventory Name</label>
                    <label class="input">
                        <i class="icon-append fa fa-tag"></i>
                        <input type="text" id="InventoryName">
                    </label>
                </section>
                <section class="col col-6">
                    <label class="labelform">Request Date</label>
                    <label class="input">
                        <i class="icon-append fa fa-calendar"></i>
                        <input type="text" name="mydate" runat="server" placeholder="Select a date" class="form-control datepicker" data-dateformat="mm/dd/yy" id="RequestDate" />
                    </label>
                </section>
                <section class="col col-6">
                    <label class="labelform">Models</label>
                    <label class="select">
                        <select multiple="multiple" class="select2" id="select-model" style="width: 100% !important;">
                        </select>
                    </label>
                </section>
            </div>
        </p>

    </div>
    <!-- end widget grid -->

    <script type="text/javascript">

        var json = '<%= json %>'

        var obj = JSON.parse(json);

        models = obj.models;
        /* chart colors default */
        var $chrt_border_color = "#efefef";
        var $chrt_grid_color = "#DDD"
        var $chrt_main = "#E24913";			/* red       */
        var $chrt_second = "#6595b4";		/* blue      */
        var $chrt_third = "#FF9F01";		/* orange    */
        var $chrt_fourth = "#7e9d3a";		/* green     */
        var $chrt_fifth = "#BD362F";		/* dark red  */
        var $chrt_mono = "#000";
        pageSetUp();
        var currentpage = 1;

        var selectorModel = $('#select-model');
        //var modelsSelected = getModelsFromInput();

        for (var i = 0; i < models.length; i++) {
            var option = $('<option>').val(models[i]).text(models[i]);
            selectorModel.append(option);
        }

        selectorModel.select2({
            //formatSelection: function (term) {
            //    console.log(term);
            //    return '<a href="#" style="color: white;" onclick=modelClicked("' + term.id + '")>' + term.text + '</a>';
            //}
        });

        LoadData(1);
        loadScript("js/plugin/flot/jquery.flot.cust.min.js", function () {
            loadScript("js/plugin/flot/jquery.flot.resize.min.js", function () {
                loadScript("js/plugin/flot/jquery.flot.fillbetween.min.js", function () {
                    loadScript("js/plugin/flot/jquery.flot.orderBar.min.js", function () {
                        loadScript("js/plugin/flot/jquery.flot.pie.min.js", function () {
                            loadScript("js/plugin/flot/jquery.flot.tooltip.min.js", LoadStatistic);
                        });
                    });
                });
            });
        });


        function createAction(id) {
            var btndel = $('<label class="btn btn-xs btn-default" style="margin-left: 1px;">');
            btndel.attr("dataid", id);
            btndel.append($('<i class="fa fa-times" />'))

            btndel.click(function (event) {
                event.stopPropagation();
                var idinventory = $(this).attr('dataid');
                var callback = function () {
                    AJAXFunction.CallAjax("POST", "/device/InventoryRequest.aspx", "DeleteInventory",
                        {
                            inventoryid: parseInt(idinventory)
                        },
                        function (obj) {
                            if (obj.Status) {
                                alertSmallBox("Delete seccessful!", "1 second ago!!", "Success");
                                LoadStatistic();
                                LoadData(currentpage);
                            }
                            else
                                alertSmallBox("Can't delete this item, please contact administrator", "1 second ago!!", "Error");
                        });
                }
                confirm("Confirm", "Do you want to delete this inventory, data inventory will loss when you click OK!!", "OK", "Cancel", callback);

            });

            var btnexport = $('<label class="btn btn-xs btn-default" style="margin-left: 1px;">');
            btnexport.attr("dataid", id);
            btnexport.append($('<i class="fa fa-file-excel-o" />'))
            btnexport.click(function (event) {
                window.open('/device/AjaxProcess/Export.aspx?type=inventoryform&InventoryID=' + $(this).attr("dataid"), "_blank");
                event.stopPropagation();
                //AJAXFunction.CallAjax("POST", "/device/inventoryrequest.aspx", "ExportForm", { data: $(this).attr("dataid") }, function (response) {

                //}
                //);
            });

            var td = $('<td style="text-align: center">');
            //td.append(action);
            td.append(btndel);
            td.append(btnexport);
            return td;
        }

        function LoadTable(listdata) {
            var table = $('#tableinventory > tbody').empty();
            if (listdata.length == 0) {
                EmptyTable(table, 8);
            }
            for (var i = 0; i < listdata.length; i++) {
                var tr = $('<tr style="cursor: pointer;">').attr("dataid", listdata[i].id);
                tr.click(function () {
                    window.open("/#device/InventoryConfirm.aspx?inventoryid=" + $(this).attr("dataid"), '_blank');
                });
                //var td = $('<td>').append(listinventory[i].ID);
                //tr.append(td);
                var a = $('<a href="javascript:void(0)">').text(listdata[i].InventoryName).attr('dataid', listdata[i].id);
                a.click(function () {
                    var dataid = $(this).attr('dataid');
                    window.location.href = "/#device/InventoryConfirm.aspx?inventoryid=" + dataid;
                });
                var td = $('<td>').append(a);
                tr.append(td);
                td = $('<td>').append(listdata[i].RequestDate).css("text-align", "center");
                tr.append(td);
                td = $('<td>').append(listdata[i].NotConfirm).css("text-align", "center");
                tr.append(td);
                td = $('<td>').append(listdata[i].NotBorrow).css("text-align", "center");
                tr.append(td);
                td = $('<td>').append(listdata[i].Loss).css("text-align", "center");
                tr.append(td);
                td = $('<td>').append(listdata[i].Broken).css("text-align", "center");
                tr.append(td);
                td = $('<td>').append(listdata[i].Good).css("text-align", "center");
                tr.append(td);
                tr.append(createAction(listdata[i].id)).css("text-align", "center");

                table.append(tr);
            }
        }


        function AddRequestInventory() {
            $('#dialog-message').dialog('open');
            return false;

        }

        function SubmitRequestInventory() {

            if ($('#RequestDate').val() == "") {
                alertbox("Please select date");
                return;
            }
            AJAXFunction.CallAjax("POST", "/device/InventoryRequest.aspx", "CreateNewRequest",
                {
                    InventoryName: $('#InventoryName').val(),
                    RequestDate: $('#RequestDate').val(),
                    models: $('#select-model').val()
                },
                function (response) {
                    if (response.Status) {

                        alertSmallBox("Create request inventory successful", "2 seconds ago!!", "success");
                        LoadStatistic();
                        LoadData(currentpage);
                        $('#dialog-message').dialog('close');
                    }
                    else {
                        alertSmallBox("Create request inventory failed", "2 seconds ago!!", "error");

                    }
                });

        }

        $("#dialog-message").dialog({
            autoOpen: false,
            width: 600,
            modal: true,
            title: "Create Request Inventory",
            buttons: [{
                html: "Cancel",
                "class": "btn btn-default",
                click: function () {
                    $(this).dialog("close");
                }
            }, {
                html: "<i class='fa fa-check'></i>&nbsp; OK",
                "class": "btn btn-primary",
                click: function () {
                    SubmitRequestInventory();
                }
            }]

        });


        function LoadStatistic() {
            $.ajax({
                type: "POST",
                url: "/device/InventoryRequest.aspx/LoadStatistic",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var obj = JSON.parse(response.d);
                    if (obj.Status) {

                        var ticksValue = [];
                        var NotBorrow = [];
                        var Loss = [];
                        var Broken = [];
                        var Good = [];
                        for (var i = 0; i < obj.ticksValue.length; i++) {
                            var tmpticksValue = [];
                            tmpticksValue.push(i + 1);
                            tmpticksValue.push(obj.ticksValue[i]);
                            ticksValue.push(tmpticksValue);

                            var tmpNotBorrow = [];
                            tmpNotBorrow.push(i + 1);
                            tmpNotBorrow.push(obj.NotBorrow[i]);
                            NotBorrow.push(tmpNotBorrow);

                            var tmpLoss = [];
                            tmpLoss.push(i + 1);
                            tmpLoss.push(obj.Loss[i]);
                            Loss.push(tmpLoss);

                            var tmpBroken = [];
                            tmpBroken.push(i + 1);
                            tmpBroken.push(obj.Broken[i]);
                            Broken.push(tmpBroken);

                            var tmpGood = [];
                            tmpGood.push(i + 1);
                            tmpGood.push(obj.Good[i]);
                            Good.push(tmpGood);

                        }



                        $.plot($("#line-chart-issues"), [{
                            data: NotBorrow,
                            label: "Not Borrow"
                        }, {
                            data: Loss,
                            label: "Loss"
                        }, {
                            data: Broken,
                            label: "Broken"
                        }, {
                            data: Good,
                            label: "Good"
                        }], {
                            series: {
                                lines: {
                                    show: true,
                                    lineWidth: 1,
                                    fill: false,
                                    fillColor: {
                                        colors: [{
                                            opacity: 0.1
                                        }, {
                                            opacity: 0.15
                                        }]
                                    }
                                },
                                points: {
                                    show: true
                                },
                                shadowSize: 0
                            },
                            xaxis: {
                                ticks: ticksValue
                            },
                            grid: {
                                hoverable: true,
                                clickable: true,
                                tickColor: $chrt_border_color,
                                borderWidth: 0,
                                borderColor: $chrt_border_color,
                            },
                            legend: {
                                show: true,
                                noColumns: 1, // number of colums in legend table
                                labelFormatter: null, // fn: string -> string
                                labelBoxBorderColor: "#000", // border color for the little label boxes
                                container: null, // container (as jQuery object) to put legend in, null means default on top of graph
                                position: "ne", // position of default legend container within plot
                                margin: [5, 10], // distance from grid edge to default legend container within plot
                                backgroundColor: "#efefef", // null means auto-detect
                                backgroundOpacity: 1 // set to 0 to avoid background
                            },
                            tooltip: true,
                            tooltipOpts: {
                                content: "%s: %y device(s)",
                                dateFormat: "%y-%0m-%0d",
                                defaultTheme: false
                            },
                            colors: [$chrt_main, $chrt_second, $chrt_third],
                            yaxis: {
                                tickDecimals: 0
                            },
                        });

                    }
                },
                failure: function (response) {
                }
            });
        }
        function LoadData(page) {
            currentpage = page;
            var keyword = '';// $('#inputSearch').val();
            var numberinpage = 6;
            AJAXFunction.CallAjax("POST", "device/InventoryRequest.aspx", "LoadData", {
                keyword: keyword,
                currentpage: page,
                numberinpage: numberinpage
            },
            function (obj) {
                if (obj.Status) {
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    listdevices = obj.Data;
                    LoadTable(obj.Data);
                    AJAXFunction.CreatePaging($("#divpaging"), page, totalpage, LoadData);
                }
            });
        }
    </script>
</body>
