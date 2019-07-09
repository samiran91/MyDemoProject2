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
        source: babyNames,
    });

 
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