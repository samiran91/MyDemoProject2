function readURL(input) {

    var today = new Date();
    var date = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
    var time = today.getHours() + "-" + today.getMinutes() + "-" + today.getSeconds();
    var dateTime = date + "-" + time;


    if (input.files && input.files[0]) {
        var ImgUploadedFiles = input.files[0].name;
        ImgUploadedFiles = dateTime + "-" + ImgUploadedFiles;


        var files = input.files;
        var fileData = new FormData();
        for (var i = 0; i < files.length; i++) {
            fileData.append(dateTime + "-" + files[i].name, files[i]);
        }

        $('input[name=hiddeninputname]').val(ImgUploadedFiles);

        $.ajax({
            url: '/Candidate/UploadFiles',
            type: "POST",
            contentType: false, // Not to set any content header  
            processData: false, // Not to process data  
            data: fileData,
            success: function (result) {

            },
            error: function (err) {
                alert(err.statusText);
            }
        });



        var reader = new FileReader();
        reader.onload = function (e) {
            $('#imagePreview').css('background-image', 'url(' + e.target.result + ')');
            $('#imagePreview').hide();
            $('#imagePreview').fadeIn(650);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$(document).ready(function () {
    PopulateInterests();
    $("#imageUpload").change(function () {
        readURL(this);
    });

    $("div.avatar-edit").hide();


    $(".avatar-upload").hover(function () {
        $("div.avatar-edit").show();
    }, function () {
        $("div.avatar-edit").hide();
    });

    $("#myMultiSearch").multisearch({
        source: InterestNames,
    });

 
    FetchCandidateDetails();

});
function PopulateInterests()
    {
    $.ajax({
        url: '/Jobs/GetKeywordAutocompleteValue',

       
        dataType: "json",
        success: function (data) {
            debugger;
           InterestData = JSON.parse(data);
           for (index = 0; index < InterestData.length; index++) {
               var element = {};
               element.name = InterestData[index].Keyword;

               InterestNames.push(element);
           } 
        }
   });
}
var InterestData = [];
var InterestNames= [
   
];


function SaveCandidateInfo() {

    var Intrest = [];
    var Str_Intrst;

    $("#myMultiSearch div.sel-anchor a").each(function () {
        Intrest.push($(this).text());
        
    });

    var insttextvalues = $("#txt_inst").val().split(",");
    for (index = 0; index < insttextvalues.length; index++) {
        Intrest.push(insttextvalues[index]);

    }
    Str_Intrst = Intrest.toString();
    var Name = $("#txt_candName").val();
    var Gender = $('#txt_candGender :selected').val();
    var DOB = $("#txt_candDOB").val();
    var Address = $("#txt_candAddress").val();
    var Email = $("#txt_candEmail").val();
    var Mobile = $("#txt_candMobile").val();
    var Qual = $("#txt_candQual").val();
    var Exp = $("#txt_candExp").val();
    var ImgValue = $("#hdn_imgfname").val();

    var ValidateCandidate = 1;
    if (Name == null || Name == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide name',
        });
        ValidateCandidate = 0;
    }
  
    else if (Email == null || Email == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide email',
        });
        ValidateCandidate = 0;
    }

    else if (!isEmail(Email)) {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide a valid email id!!',
        });
        ValidateCandidate = 0;
    }

   

   

    if (ValidateCandidate > 0) {
        var CandidateLogin = new Object();

        CandidateLogin.Name = Name;
        CandidateLogin.Gender = Gender;
        CandidateLogin.DOB = DOB;
        CandidateLogin.Address = Address;
        CandidateLogin.Email = Email;
        CandidateLogin.Qualification = Qual;
        CandidateLogin.Experiance = Exp;
        CandidateLogin.Interests = Str_Intrst;
        CandidateLogin.ImgValue = ImgValue;

        console.log(CandidateLogin);
        
        $.ajax({
            type: "POST",
            url: "/Candidate/SaveCandidateRecord",
            data: JSON.stringify(CandidateLogin),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
             


                 
                    $.alert({
                        type: 'green',
                        title: 'Sucessfull!',
                        content: 'Profile Saved Successfully',
                    });
                
              
            },

            error: function (response) {
                $.alert({
                    type: 'red',
                    title: 'Failed!',
                    content: 'Failed to Save!!',
                });
              
            }
        });
    }
}




function FetchCandidateDetails() {


    $.ajax({
        type: 'POST',
        url: '/Candidate/FetchCandidateDetails',
       
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
           
            $("#imagePreview").css("background-image", "url('" + data.ImgValue + "')");
            $("#txt_candName").val(data.Name);
            $("#txt_candGender").val(data.Gender);
            $("#txt_candDOB").val(formatDate(data.DOB));
            $("#txt_candAddress").val(data.Address);
            $("#txt_candEmail").val(data.Email);
          
            $("#txt_candQual").val(data.Qualification);
            $("#txt_candExp").val(data.Experiance);
            var arr = data.ImgValue.split('/');
            $('input[name=hiddeninputname]').val(arr[2]);


            var Intr = data.Interests;
            var temp = new Array();

            temp = Intr.split(",");
            var htm1 = '<a href="#" data-role="selected-item">';
            var htm2 = '</a>';
            $.each(temp, function (i, val) {

                if (temp[i] == "") {
                    return true;
                }
                else {
                    var final = htm1 + val + htm2;
                    $("div.sel-anchor").append(final);
                }


            });

        },
        error: function (ex) {
            alert("Message: " + ex.Message);
            alert("StackTrace: " + ex.StackTrace);
            alert("ExceptionType: " + ex.ExceptionType);
        }
    });
}


