
$(document).ready(function () {
    debugger;
    var keyword = getCookie("keyword");
    var posted = getCookie("posted");
    var location = getCookie("location");
    $("#txt_keyword").val(keyword);
    if (posted!=null) {
        $("#ddl_posted").val(posted);
    }
    if (location!=null) {
        $("#ddl_location").val(location);
    }
    
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
    Search();
});
window.addEventListener("beforeunload", function (e) {
   

    var keyword = $("#txt_keyword").val();
    var posted = $("#ddl_posted").val();
    var location = $("#ddl_location").val();
    document.cookie = "keyword="+keyword;
    document.cookie = "posted="+posted;
    document.cookie = "location="+location;
   
    
});
function Search() {
    debugger;
    var keyword = $("#txt_keyword").val();
    var posted = $("#ddl_posted").val();
    var location = $("#ddl_location").val();
    grid.reload({ searchString: keyword + "|" + posted+"|"+location });
}
function ApplyForJob(e) {
   
    var JobNumber = e.data.record.JobNo;
    window.location.href = "/jobs/JobDetails?JNo=" + JobNumber;

}
function getCookie(name) {
    var v = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return v ? v[2] : null;
}
