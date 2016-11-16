function getDateFromJsonDate(d) {
    return new Date(parseInt(d.substr(6)));
}

function getDateString(d) {
    return (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear();
}

function getShortDisplayIndexList(l) {
    var result = [];

    if (l > 10) {
        for (i = 0; i < 9; i++) {
            result.push(Math.round(i / 10 * (l - 1)));
        }
    }
    else {
        for (i = 0; i < l; i++) {
            result.push(i);
        }
    }

    return result;
}

function isPositiveInteger(s) {
    var i = +s; // convert to a number
    if (i < 0) return false; // make sure it's positive
    if (i != ~~i) return false; // make sure there's no decimal part
    return true;
}

function callApi(url, options) {
    if (!url || typeof url !== "string") {
        alert('Some errors occur. Please contact administrator for helps.');
        console.log('Url not valid: ' + JSON.stringify(url));
        return;
    }

    var defaults = {
        data: '',
        contentType: "application/json; charset=utf-8",
        dataType: 'json',
        processData: true,
        beforeSend: function () { },
        success: function () { },
        error: function () {
            console.log("Ajax error.");
            alert("Failed. Please try again later.");
        },
        complete: function () { }
    }
    
    for (var index in defaults) {
        if (typeof options[index] == 'undefined') options[index] = defaults[index];
    }

    $.ajax({
        type: "POST",
        url: url,
        data: options['data'],
        contentType: options['contentType'],
        dataType: options['dataType'],
        processData: options['processData'],
        beforeSend: options['beforeSend'],
        success: options['success'],
        error: options['error'],
        complete: options['complete']
    });
}

$(".btn").mouseup(function () {
    $(this).blur();
});

jQuery.validator.addMethod("dateGTE", function (value, element, params) {
    return this.optional(element) || !(new Date(value) < new Date(params.val()));
}, jQuery.validator.format('{0} must be after {1}'));

jQuery.validator.addMethod("positiveInteger", function (value, element, params) {
    return isPositiveInteger(value);
}), jQuery.validator.format('You must input a positive integer.');