function readURL(input) {

    var today = new Date();
    var date = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
    var time = today.getHours() + "-" + today.getMinutes() + "-" + today.getSeconds();
    var dateTime = date + "-" + time;
    

    if (input.files && input.files[0]) {
        debugger;
        var ImgUploadedFiles = input.files[0].name;
        ImgUploadedFiles = dateTime + "-" + ImgUploadedFiles;


        var files = input.files;
        var fileData = new FormData();
        for (var i = 0; i < files.length; i++) {
            fileData.append(dateTime + "-" + files[i].name, files[i]);
        }
       
        $('input[name=hiddeninputname]').val(ImgUploadedFiles);

        $.ajax({
            url: '/Jobs/UploadFiles',
            type: "POST",
            contentType: false, // Not to set any content header  
            processData: false, // Not to process data  
            data: fileData,
            success: function (result) {
                // alert(result);
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

    $("#imageUpload").change(function () {
       // debugger;
        readURL(this);
    });

    $("div.avatar-edit").hide();


    $(".avatar-upload").hover(function () {
        $("div.avatar-edit").show();
    }, function () {
        $("div.avatar-edit").hide();
    });

    $("#myMultiSearch").multisearch({
        source: babyNames,
    });

   // var PhoneNo = HttpContext.Current.User.Identity.Name;
   // debugger;
   FetchCandidateDetails();

});


var babyNames = [
    { name: 'Aaliyah' },
    { name: 'Aaron' },
    { name: 'Abigail' },
    { name: 'Adam' },
    { name: 'Addison' },
    { name: 'Adrian' },
    { name: 'Aiden' },
    { name: 'Alex' },
    { name: 'Alexa' },
    { name: 'Alexander' },
    { name: 'Alexandra' },
    { name: 'Alexis' },
    { name: 'Alice' },
    { name: 'Allison' },
    { name: 'Alyssa' },
    { name: 'Amelia' },
    { name: 'Andrew' },
    { name: 'Anna' },
    { name: 'Annabelle' },
    { name: 'Anthony' },
    { name: 'Aria' },
    { name: 'Arianna' },
    { name: 'Asher' },
    { name: 'Aubrey' },
    { name: 'Audrey' },
    { name: 'Austin' },
    { name: 'Ava' },
    { name: 'Avery' },
    { name: 'Bailey' },
    { name: 'Bella' },
    { name: 'Benjamin' },
    { name: 'Bentley' },
    { name: 'Blake' },
    { name: 'Brandon' },
    { name: 'Brayden' },
    { name: 'Brianna' },
    { name: 'Brody' },
    { name: 'Brooke' },
    { name: 'Brooklyn' },
    { name: 'Caleb' },
    { name: 'Cameron' },
    { name: 'Caroline' },
    { name: 'Carson' },
    { name: 'Carter' },
    { name: 'Charlie' },
    { name: 'Charlotte' },
    { name: 'Chase' },
    { name: 'Chloe' },
    { name: 'Christian' },
    { name: 'Christopher' },
    { name: 'Claire' },
    { name: 'Clara' },
    { name: 'Cole' },
    { name: 'Colin' },
    { name: 'Colton' },
    { name: 'Connor' },
    { name: 'Cooper' },
    { name: 'Daniel' },
    { name: 'David' },
    { name: 'Declan' },
    { name: 'Dominic' },
    { name: 'Dylan' },
    { name: 'Easton' },
    { name: 'Eleanor' },
    { name: 'Elena' },
    { name: 'Eli' },
    { name: 'Eliana' },
    { name: 'Elijah' },
    { name: 'Elise' },
    { name: 'Elizabeth' },
    { name: 'Ella' },
    { name: 'Ellie' },
    { name: 'Emily' },
    { name: 'Emma' },
    { name: 'Ethan' },
    { name: 'Eva' },
    { name: 'Evan' },
    { name: 'Evelyn' },
    { name: 'Gabriel' },
    { name: 'Gabriella' },
    { name: 'Gavin' },
    { name: 'Gianna' },
    { name: 'Grace' },
    { name: 'Grayson' },
    { name: 'Hailey' },
    { name: 'Hannah' },
    { name: 'Harper' },
    { name: 'Harrison' },
    { name: 'Hayden' },
    { name: 'Henry' },
    { name: 'Hudson' },
    { name: 'Hunter' },
    { name: 'Ian' },
    { name: 'Isaac' },
    { name: 'Isabella' },
    { name: 'Isabelle' },
    { name: 'Isaiah' },
    { name: 'Isla' },
    { name: 'Jace' },
    { name: 'Jack' },
    { name: 'Jackson' },
    { name: 'Jacob' },
    { name: 'Jake' },
    { name: 'James' },
    { name: 'Jasmine' },
    { name: 'Jason' },
    { name: 'Jayden' },
    { name: 'Jeremiah' },
    { name: 'John' },
    { name: 'Jonathan' },
    { name: 'Jordan' },
    { name: 'Joseph' },
    { name: 'Joshua' },
    { name: 'Julia' },
    { name: 'Julian' },
    { name: 'Kaitlyn' },
    { name: 'Kate' },
    { name: 'Kayla' },
    { name: 'Kaylee' },
    { name: 'Kendall' },
    { name: 'Kennedy' },
    { name: 'Kylie' },
    { name: 'Landon' },
    { name: 'Lauren' },
    { name: 'Layla' },
    { name: 'Leah' },
    { name: 'Leo' },
    { name: 'Levi' },
    { name: 'Liam' },
    { name: 'Lillian' },
    { name: 'Lily' },
    { name: 'Lincoln' },
    { name: 'Logan' },
    { name: 'Lucas' },
    { name: 'Lucy' },
    { name: 'Luke' },
    { name: 'Lyla' },
    { name: 'Mackenzie' },
    { name: 'Madelyn' },
    { name: 'Madison' },
    { name: 'Makayla' },
    { name: 'Maria' },
    { name: 'Mason' },
    { name: 'Matthew' },
    { name: 'Max' },
    { name: 'Maya' },
    { name: 'Mia' },
    { name: 'Micah' },
    { name: 'Michael' },
    { name: 'Mila' },
    { name: 'Miles' },
    { name: 'Molly' },
    { name: 'Morgan' },
    { name: 'Natalie' },
    { name: 'Nathan' },
    { name: 'Nathaniel' },
    { name: 'Nevaeh' },
    { name: 'Nicholas' },
    { name: 'Noah' },
    { name: 'Nolan' },
    { name: 'Nora' },
    { name: 'Oliver' },
    { name: 'Olivia' },
    { name: 'Owen' },
    { name: 'Paige' },
    { name: 'Parker' },
    { name: 'Peyton' },
    { name: 'Piper' },
    { name: 'Quinn' },
    { name: 'Reagan' },
    { name: 'Reese' },
    { name: 'Riley' },
    { name: 'Riley' },
    { name: 'Ruby' },
    { name: 'Ryan' },
    { name: 'Ryder' },
    { name: 'Sadie' },
    { name: 'Samantha' },
    { name: 'Samuel' },
    { name: 'Sarah' },
    { name: 'Savannah' },
    { name: 'Scarlett' },
    { name: 'Sean' },
    { name: 'Sebastian' },
    { name: 'Sienna' },
    { name: 'Sophia' },
    { name: 'Sophie' },
    { name: 'Stella' },
    { name: 'Sydney' },
    { name: 'Taylor' },
    { name: 'Thomas' },
    { name: 'Tristan' },
    { name: 'Tyler' },
    { name: 'Victoria' },
    { name: 'Violet' },
    { name: 'William' },
    { name: 'Wyatt' },
    { name: 'Xavier' },
    { name: 'Zachary' },
    { name: 'Zoe' }
];


function SaveCandidateInfo() {
    
    var Intrest = [];
    var Str_Intrst;

    $("#myMultiSearch div.sel-anchor a").each(function () {
        Intrest.push($(this).text());
        Str_Intrst = Intrest.toString();
    });

    console.log(Str_Intrst);
   // debugger;
    var ValidateCandidate = 1;
    var Name = $("#txt_candName").val();
    var Gender = $('#txt_candGender :selected').val();
    var DOB = $("#txt_candDOB").val();
    var Address = $("#txt_candAddress").val();
    var Email = $("#txt_candEmail").val();
    var Mobile = $("#txt_candMobile").val();
    var Qual = $("#txt_candQual").val();
    var Exp = $("#txt_candExp").val();
    var ImgValue = $("#hdn_imgfname").val();

    if (Name == null || Name == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide name',
        });
        ValidateCandidate = 0;
    }
    else if (DOB == null || DOB == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide birth date',
        });
        ValidateCandidate = 0;
    }
    else if (Address == null || Address == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide address',
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

    else if (Mobile == null || Mobile == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please Provide mobile no',
        });
        ValidateCandidate = 0;
    }
    else if (!phonenumber(Mobile)) {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide a valid mobile number!!',
        });
        ValidateCandidate = 0;
    }

    else if (Qual == null || Qual == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide qualifications',
        });
        ValidateCandidate = 0;
    }
    else if (Exp == null || Exp == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please Provide your Experiance',
        });
        ValidateCandidate = 0;
    }

    else if (Str_Intrst == null || Str_Intrst == "") {
        $.alert({
            type: 'red',
            title: 'Alert!',
            content: 'Please provide interests',
        });
       // debugger;
    }

    if (ValidateCandidate > 0) {
        var CandidateLogin = new Object();

        CandidateLogin.Name = Name;
        CandidateLogin.Gender = Gender;
        CandidateLogin.DOB = DOB;
        CandidateLogin.Address = Address;
        CandidateLogin.Email = Email;
        CandidateLogin.Mobile = Mobile;
        CandidateLogin.Qualification = Qual;
        CandidateLogin.Experiance = Exp;
        CandidateLogin.Interests = Str_Intrst;
        CandidateLogin.ImgValue = ImgValue;

        console.log(CandidateLogin);
       // debugger;
        $.ajax({
            type: "POST",
            url: "/Jobs/InsertCandidateRecord",
            data: JSON.stringify(CandidateLogin),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
               // debugger;
                 

                if (response["Message"] == 'InsertSuccess') {
                    $.alert({
                        type: 'green',
                        title: 'Sucessfull!',
                        content: 'Profile Saved Successfully',
                    });
                }
                $('input[type="text"]').val('');
                $("textarea").val('');
                $("#txt_candDOB").val('dd/mm/yyyy');
            },

            error: function (response) {
                $.alert({
                    type: 'green',
                    title: 'Failed!',
                    content: 'Failed to Save!!',
                });
                $('input[type="text"]').val('');
                $("textarea").val('');
                $("#txt_candDOB").val('dd/mm/yyyy');
            }
        });
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
function FetchCandidateDetails() {

    
  //  debugger;
    $.ajax({
        type: 'POST',
        url: '/Jobs/FetchCandidateDetails',
        //data: {
        //    JobNo: JobNumber
        //},
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            debugger;
           // var r = JSON.parse(data);
            $("#imagePreview").css("background-image", "url('" + data.ImgValue + "')");
            $("#txt_candName").val(data.Name);
            $("#txt_candGender").val(data.Gender);
            $("#txt_candDOB").val(formatDate(data.DOB));
            $("#txt_candAddress").val(data.Address);
            $("#txt_candEmail").val(data.Email);
            $("#txt_candMobile").val(data.Mobile);
            $("#txt_candQual").val(data.Qualification);
            $("#txt_candExp").val(data.Experiance);

            var Intr = data.Interests;
            var temp = new Array();
            
            temp = Intr.split(",");
           // console.log(temp);
            var htm1 = '<a href="#" data-role="selected-item">';
            var htm2 = '</a>';
            $.each(temp, function (i, val) {
               // console.log(val);
               // debugger;
                var final = htm1 + val + htm2;
                $("div.sel-anchor").append(final);
            });

        },
        error: function (ex) {
            alert("Message: " + ex.Message);
            alert("StackTrace: " + ex.StackTrace);
            alert("ExceptionType: " + ex.ExceptionType);
        }
    });
}