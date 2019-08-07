$(document).ready(function () {

   // alert("");

});

function SubmitReply(JobNumber) {
    
    var current_date = new Date();
    var gmt_offset = current_date.getTimezoneOffset()
    $.ajax({
        type: 'GET',
        url: '/Jobs/FetchDiscussion',
        data: {
            JobNumber: JobNumber,
            OffSet: gmt_offset
        },
        success: function (data) {
            debugger;
            $("#discussionAdmin_div").html('');
            $("#discussionAdmin_div").html(data);
            $('#DiscussionAdminModal').modal('show');

        },
        error: function (ex) {
            console.log(ex.StackTrace);
        }
    });

}