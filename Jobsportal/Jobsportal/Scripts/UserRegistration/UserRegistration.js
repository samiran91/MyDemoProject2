$(document).ready(function () {




});

function SignUp() {
    //debugger;
    var SignUpValidator = 1;
    var Name = $("#txt_UsrName").val();
    var Phone = $("#txt_UsrPhone").val();
    var Email = $("#txt_UsrEmail").val();
    var Password = $("#txt_UsrPassword").val();

    if (Name == null || Name == "") {
       // $('#error-message_SignUP').css("display", "block");
       // $('#error-message-text_SignUP').text("Invalid Username");

        $.alert({
            title: 'Alert!',
            content: 'Please provide Name',
            type: 'red'
        });
        $("#txt_UsrName").focus();
        SignUpValidator = 0;
    }

    else if (Phone == null || Phone == "") {
       // $('#error-message_SignUP').css("display", "block");
       // $('#error-message-text_SignUP').text("Please provide Phone");

        $.alert({
            title: 'Alert!',
            content: 'Please provide Phone',
            type: 'red'
        });
        $("txt_UsrPhone").focus();
        SignUpValidator = 0;
    }

    else if (!phonenumber(Phone)) {

       // $('#error-message_SignUP').css("display", "block");
       // $('#error-message-text_SignUP').text("Please enter a valid Phone Number");

        $.alert({
            title: 'Alert!',
            content: 'Please provide a valid Phone Number',
            type: 'red'
        });
        $("#txt_UsrPhone").focus();
        SignUpValidator = 0;
    }

    else if (Email == null || Email == "") {
      //  $('#error-message_SignUP').css("display", "block");
      //  $('#error-message-text_SignUP').text("Please Provide Email");


        $.alert({
            title: 'Alert!',
            content: 'Please Provide Email',
            type: 'red'
        });
        $("#txt_UsrEmail").focus();
        SignUpValidator = 0;
    }

    else if (!isEmail(Email)) {

      //  $('#error-message_SignUP').css("display", "block");
      //  $('#error-message-text_SignUP').text("Please enter a valid email id");


        $.alert({
            title: 'Alert!',
            content: 'Please provide a valid email id',
            type: 'red'
        });
        $("#txt_UsrEmail").focus();
        SignUpValidator = 0;
    }


    if (SignUpValidator > 0) {

        var CandidateSignUp = new Object();

        CandidateSignUp.Username = Name;
        CandidateSignUp.Mobile = Phone;
        CandidateSignUp.Email = Email;
        CandidateSignUp.Password = Password;
      //  debugger;

        $.ajax({
            type: "POST",
            url: "/Login/CandidateSignUp",
            data: JSON.stringify(CandidateSignUp),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                debugger;
                if (response["Message"] == 'InsertSuccess') {
                    window.location = "/Jobs/CandidateProfile";
                }
            },

            error: function (response) {
                console.log(response);
            }
        });
    }
}


function isEmail(Email) {
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(Email);
}


function phonenumber(Phone) {
    var regex = /^\d{10}$/;
    return regex.test(Phone);
}