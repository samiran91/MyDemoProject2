function readURL(input) {

    if (input.files && input.files[0]) {
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
    debugger;
    var ValidateCandidate = 1;
    var Name = $("#txt_candName").val();
    var Gender = $('#txt_candGender :selected').val();
    var DOB = $("#txt_candDOB").val();
    var Address = $("#txt_candAddress").val();
    var Email = $("#txt_candEmail").val();
    var Mobile = $("#txt_candMobile").val();
    var Qual = $("#txt_candQual").val();
    var Exp = $("#txt_candExp").val();

    if (Name == null || Name == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Name',
        });
        ValidateCandidate = 0;
    }
    else if (DOB == null || DOB == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Birth date',
        });
        ValidateCandidate = 0;
    }
    else if (Address == null || Address == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Address',
        });
        ValidateCandidate = 0;
    }
    else if (Email == null || Email == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Email',
        });
        ValidateCandidate = 0;
    }

    else if (!isEmail(Email)) {
        $.alert({
            title: 'Confirm',
            content: 'Please enter a valid email id!!',
        });
        ValidateCandidate = 0;
    }

    else if (Mobile == null || Mobile == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Mobile no',
        });
        ValidateCandidate = 0;
    }
    else if (!phonenumber(Mobile)) {
        $.alert({
            title: 'Confirm',
            content: 'Please enter a valid Mobile Number!!',
        });
        ValidateCandidate = 0;
    }

    else if (Qual == null || Qual == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Qualifications',
        });
        ValidateCandidate = 0;
    }
    else if (Exp == null || Exp == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide your Experiance',
        });
        ValidateCandidate = 0;
    }

    else if (Str_Intrst == null || Str_Intrst == "") {
        $.alert({
            title: 'Alert!',
            content: 'Please Provide Interests',
        });
        debugger;
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

        console.log(CandidateLogin);
        debugger;
        $.ajax({
            type: "POST",
            url: "/Jobs/InsertCandidateRecord",
            data: JSON.stringify(CandidateLogin),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                  debugger;
                if (response["Message"] == 'InsertSuccess') {
                    $.alert({
                        title: 'Confirm',
                        content: 'Profile Saved Successfully',
                    });
                }
                $('input[type="text"]').val('');
                $("textarea").val('');
                $("#txt_candDOB").val('mm/dd/yyyy');
            },

            error: function (response) {
                $.alert({
                    title: 'Alert!',
                    content: 'Insertion Error!!',
                });
                $('input[type="text"]').val('');
                $("textarea").val('');
                $("#txt_candDOB").val('mm/dd/yyyy');
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
