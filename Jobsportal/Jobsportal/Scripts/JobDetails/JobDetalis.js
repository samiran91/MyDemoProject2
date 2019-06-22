
$(document).ready(function () {

    $("#JobApplyLink").click(function () {

        var JobNumber = GetParameterValues('JNo');

        $.ajax({
            type: 'POST',
            url: '/Jobs/FetchJobApplyLink',
            data: {
                JobNo: JobNumber
            },
            success: function (data) {
                debugger;
                window.location.href = data;
            },
            error: function (ex) {
                var r = jQuery.parseJSON(response.responseText);
                alert("Message: " + r.Message);
                alert("StackTrace: " + r.StackTrace);
                alert("ExceptionType: " + r.ExceptionType);
            }
        });


    });
    $("#JobReturn").click(function () {
        window.location.href = "/jobs";
    });

});


function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
} 
