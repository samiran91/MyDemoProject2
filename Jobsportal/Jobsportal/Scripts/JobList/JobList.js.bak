
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
    setCookie("keyword", keyword, 365);
    setCookie("posted", posted, 365);
    setCookie("location", location, 365);
    
   
    
});
function Search() {
    debugger;
    var keyword = $("#txt_keyword").val();
    var posted = $("#ddl_posted").val();
    var location = $("#ddl_location").val();
    grid.reload({ searchString: keyword + "|" + posted+"|"+location });
}
function Signinpage() {
    window.location.href = "/Login/LoginRegistration";
}
function ApplyForJob(e) {
   
    var JobNumber = e.data.record.JobNo;
    window.location.href = "/jobs/JobDetails?JNo=" + JobNumber;

}
function getCookie(name) {
    var v = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return v ? v[2] : null;
}
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
} 
