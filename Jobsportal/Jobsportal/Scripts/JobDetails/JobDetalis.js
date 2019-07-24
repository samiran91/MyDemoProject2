
$(document).ready(function () {


    $('[data-toggle="tooltip"]').tooltip();

    $("#JobApplyLink").click(function () {
        
        var JobNumber = GetParameterValues('JobNo');


        $.confirm({
            title: 'Confirm!',
            content: 'You will be redirected to the vendor website.Press confirm to visit that site ',
            buttons: {
                confirm: function () {
                    $.ajax({
                        type: 'POST',
                        url: '/Jobs/FetchJobApplyLink',
                        data: {
                            JobNo: JobNumber
                        },
                        success: function (data) {
                            if (validURL(data)) {
                                window.location.href = data;
                            }
                            else {
                                $.alert({
                                    type: 'green',
                                    title: 'Message!',
                                    content: data,
                                });
                            }

                        },
                        error: function (ex) {
                            console.log("Eroor", ex.StackTrace);
                        }
                    }); 
                },
                cancel: function () {
                    
                }
            }
        });






    });
    $("#JobReturn").click(function () {
        window.location.href = "/jobs";
    });

    var JobNumber = GetParameterValues('JobNo');

    FetchDiscussion(JobNumber);
    
});
function JoinToDiscussion() {
    
    var JobNumber = GetParameterValues('JobNo');
    window.location.href = "/Login/LoginRegistration?FromJobNo=" + JobNumber;
}
function FetchDiscussion(JobNumber) {

    $.ajax({
        type: 'GET',
        url: '/Jobs/FetchDiscussion',
        data: {
            JobNumber: JobNumber
        },
        success: function (data) {
            
            $("#FAQ-Community-Div").html('');
            $("#FAQ-Community-Div").html(data);
            
        },
        error: function (ex) {
            var r = jQuery.parseJSON(response.responseText);
            alert("Message: " + r.Message);
            alert("StackTrace: " + r.StackTrace);
            alert("ExceptionType: " + r.ExceptionType);
        }
    });
}

function AddMsgText() {

    var JobNumber = GetParameterValues('JobNo');
    var Msg = $("#txt-FAQ-Comm").val();
    var Discussion = new Object();

    Discussion.UserName = 'anonymous';
    Discussion.JobNo = JobNumber;
    Discussion.Messages = Msg;

    $.ajax({
        
        type: "POST",
        url: "/Jobs/AddDiscussionMsg",
        data: JSON.stringify(Discussion),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var JobNumber = GetParameterValues('JobNo');
            FetchDiscussion(JobNumber);
            $("#txt-FAQ-Comm").val('');
        },

        error: function (response) {
            console.log(response);
        }
    });
}

