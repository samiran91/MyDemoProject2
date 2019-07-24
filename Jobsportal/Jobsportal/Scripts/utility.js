function formatDate(date) {
    var datestr = parseJsonDate(date);

    var d = new Date(datestr),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}
function parseJsonDate(jsonDate) {

    var fullDate = new Date(parseInt(jsonDate.substr(6)));
    var twoDigitMonth = (fullDate.getMonth() + 1) + ""; if (twoDigitMonth.length == 1) twoDigitMonth = "0" + twoDigitMonth;

    var twoDigitDate = fullDate.getDate() + ""; if (twoDigitDate.length == 1) twoDigitDate = "0" + twoDigitDate;
    var currentDate = twoDigitMonth + "/" + twoDigitDate + "/" + fullDate.getFullYear();

    return currentDate;
};


function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}
function isEmail(Email) {
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(Email);
}


function phonenumber(Mobile) {
    var regex = /^\d{10}$/;
    return regex.test(Mobile);
}
function getCookie(name) {
    var v = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return v ? v[2] : null;
}
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires + ";path=/";
} 
function validURL(str) {
    var pattern = new RegExp('^(https?:\\/\\/)?' + // protocol
        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' + // domain name
        '((\\d{1,3}\\.){3}\\d{1,3}))' + // OR ip (v4) address
        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
        '(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
        '(\\#[-a-z\\d_]*)?$', 'i'); // fragment locator
    return !!pattern.test(str);
}

function ModifyPassword() {
    var OldPassword = $("#txt_OldPassword").val();
    var NewPassword = $("#txt_NewPassword").val();

    $.ajax({
        type: "POST",
        url: "/Login/ModifyPassword",
        data: { OldPassword: OldPassword, NewPassword: NewPassword },

        success: function (response) {
            debugger;
            
            if (response != 'False') {
                $('#success-message').css("display", "block");
                $('#error-message').css("display", "none");
                $('#success-message-text').text("Password Changed Successfully");
                setTimeout(function () {

                    window.location = "/Login/LoginRegistration";

                }, 3000);
            }
            else {
                $('#success-message').css("display", "none");
                $('#error-message').css("display", "block");
                $('#error-message-text').text("Failed to Change Password");
                setTimeout(function () {

                    $('#ChangePassword').modal('hide');

                }, 3000);
            }
        },

        error: function (response) {

        }
    });
}