
var CKEditorSetup = {
    Comment: function (idtextarea) {
        CKEDITOR.replace(idtextarea, {
            height: '100px', startupFocus: true,
            toolbar: [
    ['Bold', 'Italic', 'Underline'],
    ['Subscript', 'Superscript'],
    ["JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"],	// Defines toolbar group with name (used to create voice label) and items in 3 subgroups.
   ["NumberedList", "BulletedList", "Outdent", "Indent", "Blockquote"], ["uploadfile", "Image", "Link", "Table", "HorizontalRule", "Smiley", "SpecialChar"],			// Defines toolbar group without name.
    ["Font", "FontSize", "TextColor", "BGColor"]																			// Line break - next group will be placed in new line.
            ]
            //        toolbar: [
            //['Bold', 'Italic', 'Underline', 'Strike'],
            //['Subscript', 'Superscript'],
            //["JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock"],	// Defines toolbar group with name (used to create voice label) and items in 3 subgroups.
            //['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', 'Templates'],
            //['Undo', 'Redo'], ["NumberedList", "BulletedList", "Outdent", "Indent", "Blockquote"], ["uploadfile", "Link", "Image", "Table", "HorizontalRule", "Smiley", "SpecialChar"],			// Defines toolbar group without name.
            //["Styles", "Format", "Font", "FontSize", "TextColor", "BGColor", "-", "Maximize", 'Preview']																			// Line break - next group will be placed in new line.
            //    ]
        });
    },
    IdeaSummary: function (idtextarea) {
        CKEDITOR.replace(idtextarea, {
            height: '100px', startupFocus: true,
            toolbar: [
    ['Bold', 'Italic', 'Underline', 'Strike'],
    ['Subscript', 'Superscript'],
    ["JustifyLeft", "JustifyCenter", "JustifyRight"],	// Defines toolbar group with name (used to create voice label) and items in 3 subgroups.
    ["Blockquote"],			// Defines toolbar group without name.
    ["Font", "FontSize"]																		// Line break - next group will be placed in new line.
            ],
        });
    },

    InputContent: function (idtextarea) {
        CKEDITOR.replace(idtextarea, {
            height: '270px', startupFocus: true,
            toolbar: [
    ['Bold', 'Italic', 'Underline', 'Strike'],
    ['Subscript', 'Superscript', "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock", "NumberedList", "BulletedList", "Outdent", "Indent", "Blockquote"], ["imagepaste", "quicktable", "uploadfile", "Link", "Image", "Table", "HorizontalRule", "Smiley",
       "Styles", "Format", "Font", "FontSize", "TextColor", "BGColor", "-", 'Preview', 'Source', "Maximize"]																			// Line break - next group will be placed in new line.
            ],
            qtRows: 20, // Count of rows
            qtColumns: 20, // Count of columns
            qtWidth: '90%', // Width of inserted table
            qtStyle: { 'border-collapse': 'collapse' },
            qtClass: 'test', // Class of table
            qtCellPadding: '0', // Cell padding table
            qtCellSpacing: '0', // Cell spacing table
            qtPreviewSize: '4px', // Preview table cell size 
            qtPreviewBackground: '#c8def4' // preview table background (hover)
        });
    },
    GetData: function (idtextarea) {
        return CKEDITOR.instances[idtextarea].getData();
    },
    SetData: function (idtextarea, value) {
        return CKEDITOR.instances[idtextarea].setData(value);
    },
    ClearData: function (idtextarea) {
        return CKEDITOR.instances[idtextarea].setData("");
    }


}

var Cookie = {
    set: function (cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
    },

    get: function (cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1);
            if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
        }
        return "";
    },
    Reset: function () {
        Cookie.set("deadlinecurrentpage", 1);
        Cookie.set("myassigncurrentpage", 1);
        Cookie.set("inreviewcurrentpage", 1);
        Cookie.set("todolistcurrentpage", 1);
    }
}

var Common = {
    GetTotalPage: function (numberinpage, totalitem) {
        var temp = totalitem / numberinpage;
        var _totalpage = Math.round(temp);
        var totalpage = (temp > _totalpage) ? _totalpage + 1 : _totalpage;
        return totalpage;
    },
    EndWith: function (a, b) {
        var index = a.lastIndexOf(b);
        if (index != -1 && (index + b.length) == a.length)
            return true;
        return false;
    },
    IsNumeric: function (input) {
        return (input - 0) == input && ('' + input).replace(/^\s+|\s+$/g, "").length > 0;
    },
    IsValidDate: function (d) {
        var timestamp = Date.parse(d)
        return !isNaN(timestamp);
    },
    isValidDate: function (d) {
        re = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
        if (d != '') {
            if (regs = d.match(re)) {
                if (regs[1] < 1 || regs[1] > 12) {
                    return false;
                }
                if (regs[2] < 1 || regs[2] > 31) {
                    return false;
                }
                if (regs[1] == 2 && regs[2] > 29) {
                    return false;
                }
                if (regs[3] < 1902 || regs[3] > (new Date()).getFullYear()) {
                    return false;
                }
                return true;
            }
            return false;
        }
        else
            return false;
    },
    ExistFunction: function (func) {
        if (typeof func != "undefined" && typeof func === 'function') {
            return true;
        }
        return false;
    },
    Erroroccur: function () {
        confirm("Error occurr", "Unexpected error occurred, please reload the page.", "Reload", "Cancel", function () { location.reload() });
    },
    CreateSpanNumber: function (number, _class) {
        var span = $('<span class="badge bg-color-greenLight pull-right inbox-badge">');
        span.text(number);
        span.addClass(_class);
        return span;
    },
    CreateLabelStyle: function (_class, text) {
        var label = $('<span class="label" style="padding:0px !important; text-align:center; color: white; font-weight: bold; margin: 0px;">').addClass(_class).text(text);
        return label;
    },
    CreateLabelStyleSuccess: function (text) {
        return Common.CreateLabelStyle("label-success", text);
    },
    CreateLabelStyleInfo: function (text) {
        return Common.CreateLabelStyle("label-info", text);
    },
    CreateLabelStyleWarning: function (text) {
        return Common.CreateLabelStyle("label-warning", text);
    },
    CreateLabelStyleDanger: function (text) {
        return Common.CreateLabelStyle("label-danger", text);
    },
    CreateLabelStylePrimary: function (text) {
        return Common.CreateLabelStyle("label-primary", text);
    },
    CreateLabelBadge: function (_class, text) {
        var label = $('<span class="badge" style="padding:5px !important; text-align:center;color: white;font-weight: bold; margin: 0px;">').addClass(_class).text(text);
        return label;
    },
    CreateLabelBadgeSuccess: function (text) {
        return Common.CreateLabelBadge("bg-color-greenLight", text);
    },
    CreateLabelBadgeInfo: function (text) {
        return Common.CreateLabelBadge("bg-color-blueLight", text);
    },
    CreateLabelBadgeWarning: function (text) {
        return Common.CreateLabelBadge("bg-color-orange", text);
    },
    CreateLabelBadgeDanger: function (text) {
        return Common.CreateLabelBadge("bg-color-red", text);
    },
    CreateLabelBadgePrimary: function (text) {
        return Common.CreateLabelBadge("bg-color-darken", text);
    },
    CreateSwitch: function (text, checked, textON, textOFF, funClick) {
        var label = $("<label class='toggle' style='display: inline;'>");
        var input = $('<input type="checkbox" name="checkbox-toggle">');
        if (checked)
            input.attr("checked", "checked");
        input.click(function () {
            if (Common.ExistFunction(funClick))
                funClick(this);
        });
        var i = $('<i style="margin-top: -3px;">').attr('data-swchon-text', textON).attr('data-swchoff-text', textOFF);
        label.append(input).append(i).append(text);
        return label;
    },
    ShowSingleStatus: function (username, fullname) {
        var a = $('<a>');
        a.attr('href', 'mysingleim://' + username + '@samsung.com');
        a.attr('title', 'Start chat');
        a.addClass('singlestatus');
        var img = $('<img>');
        img.attr('alt', username);
        img.addClass('statusMySingle');
        img.attr('src', '/js/communicator/Images/unknown.png');
        a.append(img);
        a.append("&nbsp;" + fullname);
        return a;
    },
    ShowManyMemberStatus: function (text, listmember) {
        var url = 'im:';
        listmember.forEach(function (item) {
            url += '<mysingleim://' + item.username + '@samsung.com>';
        });
        var a = $('<a>');
        a.addClass('singlestatus');
        a.attr('href', url);
        a.attr('title', 'Start chat');
        var img = $('<img>');
        img.attr('src', '/js/communicator/Images/unknown.png');
        a.append(img);
        a.append(text);
        return a;
    },
    MissDeadline: function (miss) {
        var i = $('<i style="  cursor: pointer">').addClass(miss ? "Delay" : "Running").attr("title", miss ? "The task has missed deadline" : "Ongoing");
        return i;
    },
    Priority: function (priority) {
        var i = $('<i style="  cursor: pointer">').addClass("priority" + priority).attr("title", "Priority " + priority);
        return i;
    },
    MyAssign: function (myassign) {
        var label = $("<label  style='margin-top: -1px;  margin-left:5px;  '>");
        var i = $('<i style="  cursor: pointer;  font-size: 24px; margin-top:-2px; color:' + (myassign ? "red" : "green") + '">').addClass(myassign ? "fa fa-angle-double-right" : "fa fa-angle-double-right").attr("title", myassign ? "My assign" : "Assign for me");
        var i1 = $('<i style="  cursor: pointer; font-size: 24px; margin-top:-2px; color:' + (myassign ? "red" : "green") + '">').addClass(myassign ? "fa fa-user" : "fa fa-user").attr("title", myassign ? "My assign" : "Assign for me");
        if (myassign) {
            label.append(i1);
            label.append(i);
        }
        else {
            label.append(i);
            label.append(i1);
        }
        return label;
    },
    IsTaskInnovation: function (istaskinnovation) {
        var label = $("<label>");
        var i = $('<i style=" cursor: pointer; margin-right:5px; margin-left:5px;  font-size: 24px; margin-top:-4px; color:' + (istaskinnovation ? "red" : "gray") + '">').addClass((istaskinnovation ? "fa fa-lightbulb-o" : "fa")).attr("title", istaskinnovation ? "Task innovation" : "");
        label.append(i);
        return label;
    },
    htmlEncode: function (value) {
        return $('<div/>').text(value).html().replace(/ /g, '%20');
    },
};

jQuery.fn.verticalAlign = function (height) {

    return this
            .css("top", ($(window).height() - height) / 2 + 'px')
};




var AJAXFunction = {
    Loading: function (loading) {
        //if (loading)
        //    $("body").addClass("loading");
        //else
        //    $("body").removeClass("loading");
    },

    ShowModal: function (placeholder, target) {
        $('#' + placeholder).removeData();
        $("body").addClass("loading");
        $('#' + placeholder).load(target, function () {
            $("body").removeClass("loading");
            $('#' + placeholder).modal("show");
        });
    },

    CallAjaxNoLoading: function (methodtype, url, methodname, data, callback) {

        datasend = JSON.stringify(data);
        $.ajax({
            type: methodtype,
            url: url + '/' + methodname,
            data: datasend,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                setTimeout(function () { callback(JSON.parse(data.d)) });
            },
            failure: function (response) {
                Common.Erroroccur();
            }
        });
    },
    CallAjax: function (methodtype, url, methodname, data, callback) {
        datasend = JSON.stringify(data);
        $.ajax({
            type: methodtype,
            url: url + '/' + methodname,
            data: datasend,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                $("body").addClass("loading");
            },
            success: function (data) {
                setTimeout(function () { callback(JSON.parse(data.d)) });
                $("body").removeClass("loading");
            },
            failure: function (response) {
                Common.Erroroccur();
            }
        });
    },
    CreateLinkPage: function (text, page, isCurrentPage, disabled, funclick) {
        var li = $('<li>');
        var a = $('<a href="javascript:void(0);">').append(text);
        li.append(a);
        a.attr('gotopage', page);
        if (!isCurrentPage) {
            a.click(function () {
                funclick($(this).attr('gotopage'));
            });
        }
        else {
            li.addClass("active");
        }
        if (disabled)
            li.addClass("disabled");
        return li;
    },
    CreatePaging: function (divpaging, curentpage, totalpage, funclick) {
        divpaging.empty();
        //if (totalpage > 1)
        {
            var ul = $('<ul class="pagination">');
            divpaging.append(ul);
            var i;
            curentpage = parseInt(curentpage);
            ul.append(AJAXFunction.CreateLinkPage($('<i class="fa fa-arrow-left">'), 1, false, curentpage <= 1, funclick));

            var temp = curentpage - 3 - (totalpage - curentpage > 3 ? 0 : (3 - (totalpage - curentpage)));
            if (temp < 1)
                temp = 1;
            for (i = temp; i <= temp + 6; i++) {
                if (i > totalpage) break;
                if (i >= 1) {
                    ul.append(AJAXFunction.CreateLinkPage(i, i, i == curentpage, false, funclick));
                }
            }
            ul.append(AJAXFunction.CreateLinkPage('<i class="fa fa-arrow-right"></i>', totalpage, false, curentpage >= totalpage, funclick));
        }
    },

    LoadData: function (targetdata, targetpaing, page, typemethod, url, dataarg, funshowdata, numberinpage, funclick, funbeforesend, funcomplete) {
        $.ajax({
            type: typemethod,
            url: url,
            data: dataarg,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                if (Common.ExistFunction(funbeforesend))
                    funbeforesend();
            },
            success: function (response) {
                if (Common.ExistFunction(funcomplete))
                    funcomplete();
                var obj = JSON.parse(response.d);
                if (obj.Status) {
                    var _totalpage = Math.round(obj.TotalItem / numberinpage);
                    var totalpage = ((obj.TotalItem / numberinpage) > _totalpage) ? _totalpage + 1 : _totalpage;
                    funshowdata(obj.TotalItem, targetdata, obj.Data);
                    AJAXFunction.CreatePaging(targetpaing, page, totalpage, funclick);
                }
            },
            failure: function (response) {
            }
        });
    },
    AjaxLoadData: function (typemethod, url, dataarg, funshowdata, funbeforeSend, funcomplete) {
        $.ajax({
            type: typemethod,
            url: url,
            data: dataarg,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: funbeforeSend,
            complete: funcomplete,
            success: function (response) {
                var obj = JSON.parse(response.d);
                if (obj.Status) {
                    funshowdata(obj);
                }
            },
            failure: function (response) {
            }
        });
    },
    LoadComment: function (target, listcomment) {
        target.empty();
        listcomment.forEach(function (item) {
            var li = $('<li class="parent_li" style="word-wrap: normal; display: list-item;">');
            var div = $('<div style="margin-top: 10px; border-bottom: 2px solid #ECECEC; padding-left: 5px; margin-left: 10px; padding-right: 5px;">');
            var name = $('<label style="width: 250px; font-weight: bold;">').append($('<i style="margin-right: 5px;">').addClass('fa fa-hand-o-right')).append(item.fullname);
            var date = $('<i>').append(item.createdate);
            var content = $('<div style="word-break: break-all; padding-left: 20px; color: #0061bc; margin-top: 10px; padding-bottom: 10px;">').append(item.content);
            div.append(name).append(date).append(content).append('<div style="clear: both"></div>');
            li.append(div);
            target.append(li);
        });
    },
    LoadUrl: function (url, showdata) {
        $.ajax({
            type: "GET",
            url: url,
            dataType: 'html',
            cache: true,
            success: function (data) {
                if (Common.ExistFunction(showdata))
                    showdata(data);
            },
            async: false
        });

        //console.log("ajax request sent");
    }
};
function GetQueryStringHash(name) {
    name = name.toLowerCase();
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.hash.toLowerCase());
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}
function GetQueryStringHref(name) {
    name = name.toLowerCase();
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.href.toLowerCase());
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}


function EmptyTableWithSearch(table, numberCol, keyword) {
    table.empty();
    var tr = $('<tr>');
    var td = $('<td>');
    td.attr('ColSpan', numberCol);
    var div = $('<div class="alert alert-info fade in">').append(keyword == "" ? 'No data record available' : 'Your search returned no matches.');
    td.append(div);
    tr.append(td);
    table.append(tr);
}

function EmptyTable(table, numberCol) {
    table.empty();
    var tr = $('<tr>');
    var td = $('<td>');
    td.attr('ColSpan', numberCol);
    var div = $('<div class="alert alert-info fade in">').append('No data record available');
    td.append(div);
    tr.append(td);
    table.append(tr);
}
function createCellNameApprove(idCommunicator, status) {
    if (idCommunicator == "") return createCell("");
    var td = $('<td>');
    var id, name, index = idCommunicator.indexOf('/');
    id = idCommunicator.substring(0, index);
    name = idCommunicator.substring(index + 1, idCommunicator.length);
    var com = "<a href='mysingleim://" + id + "@samsung.com' title='Start chat' style='color: #17375D;'> <img alt='" + id + "' class='statusMySingle' src='/js/communicator/Images/unknown.png' /> " + name + "/ " + status + " </a>";
    td.append(com);
    return td;
}

function createCellNameNoImage(idCommunicator) {
    if (idCommunicator == "") return createCell("");
    var td = $('<td>');
    var id, name, index = idCommunicator.indexOf('/');
    id = idCommunicator.substring(0, index);
    name = idCommunicator.substring(index + 1, idCommunicator.length);
    var com = "<a href='mysingleim://" + id + "@samsung.com' title='Start chat' style='color: #17375D;'> " + name + " </a>";
    td.append(com);
    return td;
}

function createCellName(idCommunicator) {
    var td = $('<td style="vertical-align: middle;">');
    if (idCommunicator != "") {
        var id, name, index = idCommunicator.indexOf('/');
        id = idCommunicator.substring(0, index);
        name = idCommunicator.substring(index + 1, idCommunicator.length);
        var com = "<a href='mysingleim://" + id + "@samsung.com' title='Start chat' style='color: #17375D;'> <img alt='" + id + "' class='statusMySingle' src='/js/communicator/Images/unknown.png' /> " + name + " </a>";
        td.append(com);
    }
    td.click(function (event) {
        event.stopPropagation();

    });
    return td;

}

function createUserNameMySingle(idCommunicator) {
    if (idCommunicator != "") {
        var id, name, index = idCommunicator.indexOf('/');
        id = idCommunicator.substring(0, index);
        name = idCommunicator.substring(index + 1, idCommunicator.length);
        var com = "<a href='mysingleim://" + id + "@samsung.com' title='Start chat' style='color: #17375D;'> <img alt='" + id + "' class='statusMySingle' src='/js/communicator/Images/unknown.png' /> " + name + " </a>";
        return com;
    }
    return "";
}

function createCellCheckBox(id, check, disable, type) {
    var td = $('<td style="vertical-align: middle;">');
    var label = $('<label class="checkbox">');
    var checkbox = $('<input type="checkbox" name="checkbox">').attr("typecheckbox", type);
    if (check) {
        checkbox.attr("checked", "checked");
    }
    checkbox.attr('dataid', id);
    label.append(checkbox);
    label.append($('<i>'));
    if (disable) {
        label.addClass('state-disabled');
        checkbox.attr('disabled', 'disabled');
    }
    td.append(label);
    return td;
}


function createCheckBox(id, check, disable, listselect) {
    var td = $('<td style="vertical-align: middle;">');
    var label = $('<label class="checkbox">');
    var checkbox = $('<input type="checkbox" name="checkbox" typecheckbox="itemdevice">');
    if (check) {
        checkbox.attr("checked", "checked");
    }
    checkbox.attr('dataid', id);
    label.append(checkbox);
    label.append($('<i>'));
    checkbox.click(function () {
        if (this.checked)
            listselect.push($(this).attr('dataid'));
        else {
            var index = listHasSelect.indexOf($(this).attr('dataid'));
            if (index != -1)
                listselect.splice(index, 1);
        }
    });
    if (disable) {
        label.addClass('state-disabled');
        checkbox.attr('disabled', 'disabled');
    }
    td.append(label);
    return td;
}

function createCellInput(text) {

    var td = $('<td style="vertical-align: middle;">');
    if (text == null) text = "";
    var input = $("<input type='text' role='textbox' style='width: 100%;'>");
    input.val(text);
    td.append(input);
    return td;
}
function createCell(text) {

    var td = $('<td style="vertical-align: middle;">');
    if (text == null) text = "";
    var label = "<label>" + text + "</label>";
    // var input = "<input type='text' name='date' role='textbox' class='editable' style='width: 98%;'/>";
    td.append(label);
    // td.append(input);
    return td;
}

function createCellImage(text) {
    var td = $('<td style="vertical-align: middle;">');
    var label = '<img style="width:40px; height:50px" alt="Avatar" src="' + text.replace("~", "") + '" class="user-avatar">';
    td.append(label);
    return td;
}

function createCellTick(tick) {

    var td = $('<td style="vertical-align: middle; text-align:center;">');
    if (tick) {
        var label = "<label style='color:green'><i class='fa fa-lg fa-check-circle'></i></label>";
        td.append(label);
    }
    return td;
}


Array.prototype.contains = function (k) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] === k) {
            return true;
        }
    }
    return false;
}


jQuery.validator.addMethod("positiveInteger", function (value, element, params) {
    return isPositiveInteger(value);
}), jQuery.validator.format('You must input a positive integer');




function GetQueryStringHash(name) {
    name = name.toLowerCase();
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.hash.toLowerCase());
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}
function GetQueryStringHref(name) {
    name = name.toLowerCase();
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.href.toLowerCase());
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}
function confirm(title, message, titlebuttonOK, titlebuttonCancel, callback, allowshow) {
    if (allowshow == false) {
        callback();
        return;
    }



    var confirmModal = $('<div id="dialog_simple" style="margin-top: 20px; line-height: 25px;">');
    confirmModal.attr('title', title)
    confirmModal.append($('<p>').append(message));

    confirmModal.dialog({
        width: 500,
        autoOpen: false,
        resizable: false,
        modal: true,
        buttons: [{
            html: titlebuttonOK,
            width: 100,
            "class": "btn btn-primary",
            click: function () {
                if (Common.ExistFunction(callback))
                    callback();
                $(this).dialog("close");
            }
        }, {
            html: titlebuttonCancel,
            width: 100,
            "class": "btn btn-default",
            click: function () {
                $(this).dialog("close");
            }
        }]
    });

    confirmModal.dialog('open');

}
function dialogbox(title, message, closefunction) {
    var confirmModal = $('<div id="dialog_simple" style="margin-top: 20px; line-height: 25px;">');
    confirmModal.attr('title', title)
    confirmModal.append($('<p>').append(message));

    confirmModal.dialog({
        width: 500,
        autoOpen: false,
        resizable: false,
        modal: true,
        buttons: [{
            html: "Close",
            width: 100,
            "class": "btn btn-primary",
            click: function () {
                $(this).dialog("close");
                if (Common.ExistFunction(closefunction))
                    closefunction();
            }
        }]
    });

    confirmModal.dialog('open');
}

function alertbox(message, closefunction) {
    dialogbox("Alert!", message, closefunction);
}
function alertSmallBox(title, mes, typealert) {
    typealert = (typealert + "").toLowerCase();
    var color = "#296191";
    var icon = "fa-thumbs-up";
    switch (typealert) {
        case "success":
            color = "#8ac38b";
            icon = "fa-thumbs-up";
            break;
        case "info":
            color = "#9cb4c5";
            icon = "fa-info-circle";
            break;
        case "error":
            color = "#c26565";
            icon = "fa-times";
            break;
    }


    $.smallBox({
        title: title,
        content: (mes != "" ? "<i class='fa fa-clock-o'></i>" : "") + " <i>" + mes + "</i>",
        color: color,
        iconSmall: "fa " + icon + " bounce animated",
        timeout: 4000
    });
}



function CallAjax(methodtype, url, methodname, data, callback) {
    datasend = JSON.stringify(data);
    $.ajax({
        type: methodtype,
        url: url + '/' + methodname,
        data: datasend,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            callback(JSON.parse(data.d));
        },
        failure: function (response) {
        }
    });
}

function DateToString(d) {
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1; //Months are zero based
    var curr_year = d.getFullYear();
    return curr_month + "/" + curr_date + "/" + curr_year;
}

$(".btn").mouseup(function () {
    $(this).blur();
});


var ckeditor = null;
function ShowSelectPicture(editor, now) {
    ckeditor = editor;
    var target = "/ajaxprocess/FileExplorer.aspx";
    $('#remoteModal2').removeData();
    $('#remoteModal2').modal({ backdrop: 'static' });
    $('#remoteModal2').load(target, function () {
        $('#remoteModal2').modal("show");
    });
}
var folder = "\\Uploads\\AttachFiles\\";
var byuser = true;


