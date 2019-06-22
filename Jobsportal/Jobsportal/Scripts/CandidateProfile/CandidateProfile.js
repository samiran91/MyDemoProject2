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
        debugger;
        alert("a");
        readURL(this);
    });

    $("div.avatar-edit").hide();


    $(".avatar-upload").hover(function () {
        $("div.avatar-edit").show();
    }, function () {
        $("div.avatar-edit").hide();

    });
});
