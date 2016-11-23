lotusModule.controller("eoAssignController", ["$scope", "$compile", function ($scope, $compile) {
    //location
    $scope.siteCriteria = {
        "SerType": "OR",
        "type": [1],
        "LocID": [""],
        "description": [""],
        "Country": [""],
        "State": [""],
        "City": [""],
        "Disc": [""],
        "postcode": [""],
        "address1": [""],
        "SalesArea": [""],
        "Group1": [""],
        "Group2": [""]
    };
    $scope.siteMessage = "";

    $scope.locationResult = [];
    $scope.updateLocation = function () {
        var keys = $scope.locationResult.filter(
             function (item) {
                 return item.checked;
             }
          ).map(function (item) {
              return item.locID;
          });
        $scope.selectedArea = keys;
    };

    $scope.searchLocation = function () {

        $.ajax({
            type: "GET",
            url: route.searchLocation,
            data: $scope.siteCriteria,
            success: function (result) {
                $scope.locationResult = result;
                $scope.$apply();
            },
            dataType: "json"
        });
    };
    $scope.clearLocation = function () {
        $scope.locationResult = [];
        $scope.$apply();
    };

    //customer
    $scope.CustomerCriteria = function (type) {

        if (!type || type == 1 || type == "1" || type.toLowerCase == "dep")
            this.type = [1];
        else if (type == 2 || type == "2" || type.toLowerCase == "rec")
            this.type = [2];
        else if (type == 5 || type == "5" || type.toLowerCase == "car")
            this.type = [5];
        this.SerType = "OR";
        this.customer = [""];
        this.name = [""];
        this.contact = [""];
        this.Email = [""];
        this.phone = [""];
        this.Country = [""];
        this.State = [""];
        this.City = [""];
        this.Disc = [""];
        this.postcode = [""];
        this.address1 = [""];
        this.SalesArea = [""];
        this.Group1 = [""];
        this.Group2 = [""];
        return this;
    };
    $scope.selectedCustomer = { "dep": [], "rec": [] };
    $scope.selectedArea = [];
    $scope.selectedPosition = { "dep": [], "rec": [] };
    //$scope.selectedDate = "";
    $scope.user = "";
    $scope.updateCustomers = function (type) {
        type = (!type || type == 1 || type == "1" || type.toLowerCase == "dep") ? "dep" : "rec";
        var keys = $scope.customers[type].filter(
             function (item) {
                 return item.checked;
             }
          ).map(function (item) {
              return item.customer;
          });
        $scope.selectedCustomer[type] = keys;
    };
    $scope.quickResult = [];
    $scope.quickSearch = function () {
        var data = {
            SerType: "OR",
            userID: $("#userID").val(),
            depAreaCode: $scope.selectedArea.toString(),
            depCustomer: $scope.selectedCustomer.dep.toString(),
            depLocCode: $scope.selectedPosition.dep.toString(),
            recCustomer: $scope.selectedCustomer.rec.toString(),
            recLocCode: $scope.selectedPosition.rec.toString(),
            createDate: $("#ercreatedate").val(),
            ERITNStatus: ["UNAS"],
            ERStatus: [""]
        };
        $.ajax({
            type: "POST",
            url: route.quickSearch,
            data: data,
            success: function (result) {

                $scope.updateTable(result);

            },
            dataType: "json"
        });
    };

    $scope.updateTable = function (data) {
        $scope.quickResult = data;
        $("#datatable_col_reorder_wrapper").remove();

        var table =
           '<table id="datatable_col_reorder" class="table table-striped table-hover">' +
              '<thead>' +
              '<tr>' +
              '<th>' +
              '<label class="checkbox">' +
              '<input type="checkbox" name="checkbox-inline">' +
              '<i></i>' +
              '</label>' +
              '</th>' +
              '<th><i class="fa fa-search"></i></th>' +
              '<th>ER</th>' +
              '<th>ERITN</th>' +
              '<th>类型</th>' +
              '<th>特殊</th>' +
              '<th>发货方</th>' +
              '<th>收货方</th>' +
              '<th>客户订单号</th>' +
              '<th>客户运单号</th>' +
              '<th>客户出库号</th>' +
              '<th>物料</th>' +
              '<th>箱号</th>' +
              '<th>件数</th>' +
              '<th>送达日期</th>' +
              '<th>方式</th>' +
              '<th>第三方</th>' +
              '</tr>' +
              '</thead>' +
              '<tbody>' +
              '<tr ng-repeat="item in quickResult">' +
              '<td>' +
              '<label class="checkbox">' +
              '<input type="checkbox" ng-model="item.checked" name="checkbox-inline">' +
              '<i></i>' +
              '</label>' +
              '</td>' +
              '<td><a href="#" data-target="#ERTemp" data-toggle="modal"><i class="fa fa-search"></i></a></td>' +
              '<td>{{item.requirementDetail.pk.erID}}</td>' +
              '<td>{{item.requirementDetail.pk.erITN}}</td>' +
              '<td>{{item.requirement.erType}}</td>' +
              '<td>{{item.requirement.erTag}}</td>' +
              '<td>{{item.requirement.depCustomer}}</td>' +
              '<td>{{item.requirement.recCustomer}}</td>' +
              '<td>{{item.requirement.customerOrder1}}</td>' +
              '<td>{{item.requirement.customerOrder2}}</td>' +
              '<td>{{item.requirement.customerOrder3}}</td>' +
              '<td>{{item.requirementDetail.matIID}}</td>' +
              '<td>{{item.requirementDetail.packNum}}</td>' +
              '<td>{{item.requirementDetail.amt}}</td>' +
              '<td>{{item.requirement.reqDelDate}}</td>' +
              '<td>{{item.requirement.erTRType}}</td>' +
              '<td>{{item.requirement.ertrvendor}}</td>' +
              '</tr>' +
              '</tbody>' +
              '</table>';

        $compile(table)($scope, function (clonedElement) {
            $("#tableWidget").append(clonedElement);
        });
        try {
            $scope.$apply();
        } catch (e) {
        }
        $('#datatable_col_reorder').dataTable({
            "sPaginationType": "bootstrap",
            "sDom": "R<'dt-top-row'Clf>r<'dt-wrapper't><'dt-row dt-bottom-row'<'row'<'col-sm-6'i><'col-sm-6 text-right'p>>",
            "fnInitComplete": function () {
                $('.ColVis_Button').addClass('btn btn-default btn-sm').html('Columns <i class="icon-arrow-down"></i>');
            }
        });
        var icon = $("#wid-id-2");
        if (icon.hasClass("jarviswidget-collapsed"))
            icon.find(".jarviswidget-toggle-btn").click();
    };
    $scope.reset = function () {
        $scope.selectedCustomer = { "dep": [], "rec": [] };
        $scope.selectedArea = [];
        $scope.selectedPosition = { "dep": [], "rec": [] };
        //$scope.selectedDate = "";
        $.datepicker._clearDate($("#ercreatedate"));
        $scope.user = "";
    };
    $scope.customers = { "dep": [], "rec": [], "car": [] };
    $scope.customerCriteria = {
        "dep": new $scope.CustomerCriteria(1),
        "rec": new $scope.CustomerCriteria(2),
        "car": new $scope.CustomerCriteria(5)
    };
    $scope.searchCustomer = function (type) {
        $.ajax({
            type: "GET",
            url: route.searchCustomer,
            data: $scope.customerCriteria[type],
            success: function (result) {
                $scope.customers[type] = result;
                 $scope.$apply();
            },
            dataType: "json"
        });
    };
    $scope.clearCustomer = function (type) {
        $scope.customers[type] = [];
        $scope.$apply();

    }
    $scope.selectedItems = { "ERID": [], "ERITN": [], length: 0 };
    $scope.$watch("quickResult", function (value) {
        var erids = value.filter(function (item) { return item.checked; })
        .map(function (item) {
            return item.requirementDetail.pk.erID;
        });

        $scope.selectedItems.ERID = erids;

        var eritns = value.filter(function (item) { return item.checked; })
       .map(function (item) {
           return item.requirementDetail.pk.erITN;
       });

        $scope.selectedItems.ERITN = eritns;
        $scope.selectedItems.length = erids.length;

    }, true);

    $scope.adjustData = {
        ERID: [],
        ERTRType: "",
        ERTRVendor: ""
    };
    $scope.createData = {

        "EOType": "0",
        "userID": $("#userID").val(),
        "EOTRType": "0",
        "EOTag": "0",
        "EOTRVendor1": "",
        "VendorOrder1": "",
        "DeliverBP1": "0",
        "reqDelDate1": "",
        "reqDelDate2": "",
        "customerOrder1": "",
        "ERID": [],
        "ERITN": [],
        "memo": ""

    };
    $scope.adjust = function () {
        if ($scope.selectedItems.length == 0)
            return false;
        if ($scope.customers.car.length == 0)
            $scope.searchCustomer("car");

    };
    $scope.confirmAdjust = function () {
        $.SmartMessageBox({
            title: "提示信息!",
            content: "是否修改运输方式及承运商?",
            buttons: '[否][是]'
        }, function (pressed) {
            if (pressed === "是") {
                $scope.doAdjust();
            }
            if (pressed === "否") {
                $.smallBox({
                    title: "操作回执",
                    content: "<i class='fa fa-clock-o'></i> 已取消...",
                    color: "#C46A69",
                    iconSmall: "fa fa-times fa-2x fadeInRight animated",
                    timeout: 4000
                });
            }
        });
    };
    $scope.doAdjust = function () {
        $scope.adjustData.ERID = $scope.selectedItems.ERID;
        if (!($scope.adjustData.ERID && $scope.adjustData.ERID.length))
            return false;
        $.ajax({
            type: "POST",
            url: route.adjust,
            data: $scope.adjustData,
            success: function (result) {
                if (!result.errorMessage || result.errorMessage === "OK") {

                    $.smallBox({
                        title: "操作回执",
                        content: "<i class='fa fa-clock-o'></i>数据更新成功...",
                        color: "#659265",
                        iconSmall: "fa fa-check fa-2x fadeInRight animated",
                        timeout: 4000
                    });
                }
                else {
                    alert(result.errorMessage);
                }
            },
            dataType: "json"
        });
    };

    $scope.deleteEr = function () {
        $.SmartMessageBox({
            title: "提示信息!",
            content: "是否删除所选择ER需求?",
            buttons: '[否][是]'
        }, function (pressed) {
            if (pressed === "是") {
                $scope.doDeleteEr();
            }
            if (pressed === "否") {
                $.smallBox({
                    title: "操作回执",
                    content: "<i class='fa fa-clock-o'></i> 已取消...",
                    color: "#C46A69",
                    iconSmall: "fa fa-times fa-2x fadeInRight animated",
                    timeout: 4000
                });
            }
        });
    };

    $scope.doDeleteEr = function () {
        $.ajax({
            type: "POST",
            url: route.deleteEr,
            data: {
                "ERID": $scope.selectedItems.ERID,
            },
            success: function (result) {
                if (!result.errorMessage || result.errorMessage === "OK") {
                    $.smallBox({
                        title: "操作回执",
                        content: "<i class='fa fa-clock-o'></i>删除操作成功...",
                        color: "#659265",
                        iconSmall: "fa fa-check fa-2x fadeInRight animated",
                        timeout: 4000
                    });
                }
                else {
                    alert(result.errorMessage);
                }
            },
            dataType: "json"
        });


    }
    $scope.deleteEritm = function () {
        $.SmartMessageBox({
            title: "提示信息!",
            content: "是否删除所选择ER需求明细项?",
            buttons: '[否][是]'
        }, function (pressed) {
            if (pressed === "是") {
                $scope.doDeleteEritm();
            }
            if (pressed === "否") {
                $.smallBox({
                    title: "操作回执",
                    content: "<i class='fa fa-clock-o'></i> 已取消...",
                    color: "#C46A69",
                    iconSmall: "fa fa-times fa-2x fadeInRight animated",
                    timeout: 4000
                });
            }
        });
    };
    $scope.doDeleteEritm = function () {
        $.ajax({
            type: "POST",
            url: route.deleteErItem,
            data: {
                "ERID": $scope.selectedItems.ERID,
                "ERITN": $scope.selectedItems.ERITN
            },
            success: function (result) {
                if (!result.errorMessage || result.errorMessage === "OK") {
                    $.smallBox({
                        title: "操作回执",
                        content: "<i class='fa fa-clock-o'></i>删除操作成功...",
                        color: "#659265",
                        iconSmall: "fa fa-check fa-2x fadeInRight animated",
                        timeout: 4000
                    });
                }
                else {
                    alert(result.errorMessage);
                }
            },
            dataType: "json"
        });



    };

    $scope.create = function () {
        if ($scope.selectedItems.length == 0)
            return false;
        if ($scope.customers.car.length == 0)
            $scope.searchCustomer("car");
    }

    $scope.confirmCreate = function () {
        if ($scope.selectedItems.length == 0)
            return false;

        $.SmartMessageBox({
            title: "提示信息!",
            content: "是否分配所选择需求至运单?",
            buttons: '[否][是]'
        }, function (pressed) {
            if (pressed === "是") {
                $scope.doCreate();
            }
            if (pressed === "否") {
                $.smallBox({
                    title: "操作回执",
                    content: "<i class='fa fa-clock-o'></i> 分配已取消...",
                    color: "#C46A69",
                    iconSmall: "fa fa-times fa-2x fadeInRight animated",
                    timeout: 4000
                });
            }
        });
    }
    $scope.doCreate = function () {
        if ($scope.selectedItems.length == 0)
            return false;

        $scope.createData.reqDelDate1 = $("#startdateEO").val();
        $scope.createData.reqDelDate2 = $("#DeldateEO").val();
        $scope.createData.ERID = $scope.selectedItems.ERID;
        $scope.createData.ERITN = $scope.selectedItems.ERITN;

        $.ajax({
            type: "POST",
            url: route.creatEo,
            data: $scope.createData,
            success: function (result) {
                if (!result.errorMessage || result.errorMessage === "OK") {
                    $.smallBox({
                        title: "操作回执",
                        content: "<i class='fa fa-clock-o'></i>运单已成功创建...",
                        color: "#659265",
                        iconSmall: "fa fa-check fa-2x fadeInRight animated",
                        timeout: 4000
                    });
                }
                else {
                    alert(result.errorMessage);
                }
            },
            dataType: "json"
        });


    }
}]);