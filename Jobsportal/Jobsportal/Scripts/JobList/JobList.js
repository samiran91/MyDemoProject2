
$(document).ready(function () {
    grid = $('#grid').grid({
        primaryKey: 'JOBNO',
        
        dataSource: '/Jobs/GetJobList',
        columns: [
            { field: 'JobNo', title: 'Job Number', width: 200},
            { field: 'JobTitle',title: 'Job Title', sortable: true },
            { field: 'PostedDate', title: 'Posted Date', width: 200, sortable: true, type: 'date' },
            //{ field: 'Qualification', title: 'Qualification', sortable: true },
            {
                field: "", title: "Apply Now", width: 100, type: "icon",
                icon: "fa fa-pencil", tooltip: "Apply Now", events: { "click": ApplyForJob }
                
            }
        ],
        pager: { limit: 5 }
    });
});


function ApplyForJob(e) {

    var JobNumber = e.data.record.JobNo;
    window.location.href = "/jobs/JobDetails?JNo=" + JobNumber;

}