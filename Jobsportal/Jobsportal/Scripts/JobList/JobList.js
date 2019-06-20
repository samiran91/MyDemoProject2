
$(document).ready(function () {
    grid = $('#grid').grid({
        primaryKey: 'JOBNO',
        uiLibrary: "bootstrap",
        responsive: true,
        
        dataSource: '/Jobs/GetJobList',
        columns: [
            { field: 'JobNo', title: 'Job Number', width: 200, priority: 1 },
            { field: 'JobTitle', title: 'Job Title', sortable: true, priority: 3 },
            { field: 'PostedDate', title: 'Posted Date', width: 200, sortable: true, type: 'date', priority: 2 },
            //{ field: 'Qualification', title: 'Qualification', sortable: true },
            {
                field: "", title: "Apply Now", width: 100, type: "icon",
                icon: "fa fa-sign-in fa-2X", tooltip: "Apply Now", events: { "click": ApplyForJob }
                
            }
        ],
        pager: { enable: true, limit: 5, sizes: [2, 5, 10, 20] }
   

    });
});


function ApplyForJob(e) {

    var JobNumber = e.data.record.JobNo;
    window.location.href = "/jobs/JobDetails?JNo=" + JobNumber;

}