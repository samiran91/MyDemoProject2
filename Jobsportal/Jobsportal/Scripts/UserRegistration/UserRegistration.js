$(document).ready(function () {

    $("#JobReturn").click(function () {
        window.location.href = "/jobs";
    });
    var uid = GetParameterValues('uid');

    if (uid != null) 
    {
        $('#ResetPass').modal('show');
    }
});

function SignUp() {
    var SignUpValidator = 1;
    var Name = $("#txt_UsrName").val();
    var Phone = $("#txt_UsrPhone").val();
    var Email = $("#txt_UsrEmail").val();
    var Password = $("#txt_UsrPassword").val();

    if (Name == null || Name == "") {

        $.alert({
            title: 'Alert!',
            content: 'Please provide Name',
            type: 'red'
        });
        $("#txt_UsrName").focus();
        SignUpValidator = 0;
    }

    else if (Phone == null || Phone == "") {

        $.alert({
            title: 'Alert!',
            content: 'Please provide Phone',
            type: 'red'
        });
        $("txt_UsrPhone").focus();
        SignUpValidator = 0;
    }

    else if (!phonenumber(Phone)) {


        $.alert({
            title: 'Alert!',
            content: 'Please provide a valid Phone Number',
            type: 'red'
        });
        $("#txt_UsrPhone").focus();
        SignUpValidator = 0;
    }

    else if (Email == null || Email == "") {



        $.alert({
            title: 'Alert!',
            content: 'Please Provide Email',
            type: 'red'
        });
        $("#txt_UsrEmail").focus();
        SignUpValidator = 0;
    }

    else if (!isEmail(Email)) {



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
        $.ajax({
            type: "POST",
            url: "/Login/CandidateSignUp",
            data: JSON.stringify(CandidateSignUp),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                
                if (response["Message"] == 'InsertSuccess') {
                    window.location = "/Candidate/CandidateProfile";
                }
                else if (response["Message"] == 'MOBILE_EXISTS') {
                    $.alert({
                        title: 'Alert!',
                        content: 'Mobile number you entered is already exists',
                        type: 'red'
                    });
                    $("#txt_UsrPhone").focus();
                }
            },

            error: function (response) {
                console.log(response);
            }
        });
    }
}

function signin() {
   

    var Mobile = $('#phone').val();

    var password = $('#pwd').val();
    var UserData = {

        Mobile: Mobile,
        Password: password
    };

    if (Mobile == "" || password == "") {

        $('#error-message').css("display", "block");
        $('#error-message-text').text("Invalid Phone Number/Password");
    }
    else {
        $.ajax({ url: "/Login/SignIn", type: "POST", data: { UserData: UserData } })
            .done(function (data) {
               
                if (data != false) {
                    if (Mobile == "admin") {
                        window.location = "/Jobs/ListJob_Admin";
                    }
                    else {
                    
                        var JobNumber = GetParameterValues('FromJobNo');
                        
                        if (JobNumber==null)
                        {

                            window.location = "/Candidate/CandidateProfile";
                        }
                        else {
                            window.location = "/jobs/JobDetails?JobNo="+JobNumber+"&Username="+Mobile;

                        }

                    }
                }
                else {
                    $('#error-message').css("display", "block");
                    $('#error-message-text').text("Invalid Phone Number/Password");

                }

            })
            .fail(function () {


            });
    }
}

function ResetPassword() {

    var mob = $("#txt_ResetPassword").val();

    $.ajax({
        type: "GET",
        url:"/Login/GetResetPassword",
        data: { ResetPasswordvalue: mob },
        success: function (data) {

            if (!(data == "Mobile Number is not found!")) {

                $('#success-message_fp').css("display", "block");
                $('#success-message-text_fp').text(data);

                setTimeout(function () {

                    $('#success-message_fp').css("display", "none");

                }, 3000);
            }
            else {

                $('#error-message_fp').css("display", "block");
                $('#error-message-text_fp').text(data);
                setTimeout(function () {

                    $('#error-message_fp').css("display", "none");
                   
                }, 3000);

            }


        },
        error: function (ex) {

            console.log(ex.Message);
        }
    });
}

function ChangePasswordViaReset() {
    var GUIDURL = GetParameterValues('uid');
    var Password = $("#txt_fpassword").val();

    $.ajax({
        type: "POST",
        url: "/Login/ChangeUserPasswordViaReset",
        data: { GUID: GUIDURL, PasswordValue: Password },

        success: function (response) {
            $('#success-message').css("display", "block");
            $('#success-message-text').text("Password Changed Successfully!!");

            setTimeout(function () {

                window.location = "/Login/LoginRegistration";

            }, 3000);
        },

        error: function (response) {

        }
    });
}

