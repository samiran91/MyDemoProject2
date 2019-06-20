
$(document).ready(function () {
    var value = document.cookie;
    
    grid = $('#grid').grid({
        primaryKey: 'JOBNO',
        uiLibrary: "bootstrap",
        responsive: true,
        
        dataSource: '/Jobs/GetJobList',
        columns: [
            { field: 'JobNo', title: 'Job Number', width: 200, priority: 3 },
            { field: 'JobTitle', title: 'Job Title', sortable: true, priority: 1 },
            { field: 'PostedDate', title: 'Posted Date', width: 200, sortable: true, type: 'date', priority: 2 },
           
            {
                field: "", title: "Apply Now", width: 100, type: "icon",
                icon: "fa fa-sign-in fa-2X", tooltip: "Apply Now", events: { "click": ApplyForJob }
                
            }
        ],
        pager: { enable: true, limit: 5, sizes: [2, 5, 10, 20] }
   

    });
});
window.addEventListener("beforeunload", function (e) {
   

    var keyword = $("txt_keyword").text();
    var posted = $("ddl_posted").text();
    var location = $("ddl_location").text();
    document.cookie = "keyword="+keyword;
    document.cookie = "posted="+posted;
    document.cookie = "location="+location;
   
    
});

function ApplyForJob(e) {
   
    var JobNumber = e.data.record.JobNo;
    window.location.href = "/jobs/JobDetails?JNo=" + JobNumber;

}
