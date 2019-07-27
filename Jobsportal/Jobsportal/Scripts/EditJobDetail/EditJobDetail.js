
$(document).ready(function () {
    PopulateQals();
    var i = 1;
  
    $("#add_row").click(function () {
        var count = $('.product').length;
        $('#tab_logic').append('<tr id="addr' + (count + 1) + '" data-idno="added"></tr>');

        $('#addr' + (Number(count) + Number(1))).html("<td id='srn_" + (count + 1) + "'>" + (count + 1) + "</td ><td><input type='text' id='productcode_" + (count + 1) + "'  placeholder='Event' class='form-control product' onchange='return UpdateStatus(this.id)' /> <input type='hidden' id='productcode_stock_" + (count + 1) + "' aria-hidden='true' onKeyUp='return UpdateStatus(this.id)'" + "  /></td><td> <input class='form-control eventDt' type='date' id='evntDate_" + (count + 1) + "'name='evntDate' onchange='return UpdateStatus(this.id)' required pattern='[0-9]{4}-[0-9]{2}-[0-9]{2}'></td><td> <span class='glyphicon glyphicon-remove'  id='del_" + (count + 1) + "'style='cursor: pointer;'></span></td>");


     

        i++;

    });
    $(document).on('click', '.removenote', function (e) {
        
        var IdNo = $(this).closest('tr').data('idno');
        var delid = $(this).closest('tr').prop('id')
        delid = delid.replace("addr_", "");
        $(this).closest('tr').remove();
        var element = {};
        element.id = IdNo;
        DeleteNotes.push(element);


        var count = $('.uplodednotes').length;


        var previtems = delid - 1;
        var newcount = count;//Already 1 item deleted
        var looprunning = newcount - previtems;
        var nextid = delid;
        for (var loopcounter = 0; loopcounter < looprunning; loopcounter++) {
            nextid++;
            
            
            $('#addr_' + nextid).attr('id', 'addr_' + (nextid - 1));
            $('#uplodednotes_' + nextid).attr('id', 'uplodednotes_' + (nextid - 1));

            $('#uplodedby_' + nextid).attr('id', 'uplodedby_' + (nextid - 1));
            $('#uplodeddate_' + nextid).attr('id', 'uplodeddate_' + (nextid - 1));

        }
    
});
    $(document).on('click', '.glyphicon-remove', function (e) {
        var id = this.id;
        var delid = id.replace("del_", "");
        var IdNo= $(this).closest('tr').data('idno');

        var element = {};
        element.id = IdNo;
        element.status = "Deleted";
        var exist = search(IdNo, RowStatus);
        if (!exist) {
            RowStatus.push(element);
        }

        var existingamount = $("#netvalue").text();
        var deduction = $("#tax_" + delid).val();
        $("#addr" + delid).remove();
        var newamount = existingamount - deduction;
        $("#netvalue").text(parseFloat(newamount).toFixed(2));
        var count = $('.product').length;


        var previtems = delid - 1;
        var newcount = count;//Already 1 item deleted
        var looprunning = newcount - previtems;
        var nextid = delid;
        for (var loopcounter = 0; loopcounter < looprunning; loopcounter++) {
            nextid++;

            $('#addr' + nextid).attr('id', 'addr' + (nextid - 1));
            $('#productcode_' + nextid).attr('id', 'productcode_' + (nextid - 1));
            $('#quantity_' + nextid).attr('id', 'quantity_' + (nextid - 1));
            $('#rate_' + nextid).attr('id', 'rate_' + (nextid - 1));
            $('#tax_' + nextid).attr('id', 'tax_' + (nextid - 1));
            $('#del_' + nextid).attr('id', 'del_' + (nextid - 1));
            $('#srn_' + nextid).attr('id', 'srn_' + (nextid - 1));

            $('#srn_' + (nextid - 1)).text((nextid - 1));//id has been changed now set the new text

        }

    });

    $("#myMultiSearch").multisearch({
        source: QualNames,
    });

    function HomeIndex() {
        var $this = this;

        function initialize() {
            $('#txt_Descp').summernote({
                focus: true,
                height: 450,
                codemirror: {
                    theme: 'united'
                }
            });
        }

        $this.init = function () {
            initialize();
        }
    }
    $(function () {
        var self = new HomeIndex();
        self.init();
    })

   
    $("#SubmitJobDetail").click(function () {
        var JobDetailValidate = 1;

         var JobNumber = $("#txt_JobNumber").val();
        var JobTitle = $("#txt_JobTitle").val();
        var JobPostedDate = $("#txt_PostedDate").val();
        var JobApplyLink = $("#txt_AplyLink").val();
        var Location = $("#txt_location").val();
        var JobDescp = $(".note-editable").html();
        var Qual = [];
        var Str_Qual;
       
        $("#myMultiSearch div.sel-anchor a").each(function () {
          
            Qual.push($(this).text());
            
        });
        
        var qualtextvalues = $("#txt_qual").val().split(",");
        for (index = 0; index < qualtextvalues.length; index++) {
            Qual.push(qualtextvalues[index]);
            
        } 
        Str_Qual = Qual.toString();
        var JobData = [];
        
        for (var i = 0; i < RowStatus.length; i++) {
            if (RowStatus[i].status === "Deleted") {
                var element = {};
                element.Id = RowStatus[i].id;
                element.Events = "Deleted";
                element.DBOP = 3;
                element.EventDateTime = new Date();
                JobData.push(element);

            }
        }
        var Str_JobData;

        var mathedcount = 1;
        var count = $('.product').length;
        var loopcount = 1;
        while (mathedcount <= count) {
            
            
            var element = {};
            element.Id = $("#addr" + loopcount).data('idno');
            element.Events = $("#productcode_" + loopcount).val();
            element.EventDateTime = $("#evntDate_" + loopcount).val();
            element.DBOP = 4;
            if (element.Id == 'added')
                element.DBOP = 1;
            
            for (var i = 0; i < RowStatus.length; i++) {
                if (element.Id == RowStatus[i].id && element.Id != 'added')
                {
                    if (RowStatus[i].status == "Modified" ) {
                        element.DBOP = 2;

                    }
                    
                }
            }
            typeof (element.ProductCode != 'undefined')
            {
                if (element.DBOP != 4)
                {
                    JobData.push(element);
                }
                mathedcount++;
            }

            loopcount++;

        }

        


        var Documents = [];
        var mathedcount = 1;
        var count = $('.uplodednotes').length;
        var count = $('.uplodedby').length;
        var count = $('.uplodeddate').length;
        
        for (var i = 0; i < DeleteNotes.length; i++) {
            
                var element = {};
                element.Id = DeleteNotes[i].id;
                element.Title = "Deleted";
                element.Uplodedby = "Deleted";
                element.DownloadLink = "Deleted";
                element.DBOP = 3;
                element.Uplodeddate= new Date();
                Documents.push(element);
                
            
        }
        var loopcount = 1;
        while (mathedcount <= count) {
            var element = {};
            element.Id = $("#uplodednotes_" + loopcount).parent().data('idno');
            element.Title = $("#uplodednotes_" + loopcount).text();
            element.Uplodedby = $("#uplodedby_" + loopcount).text();
            element.Uplodeddate = $("#uplodeddate_" + loopcount).text();
            element.DBOP = 4;
            var dlink = $("#uplodednotes_" + loopcount+" a").prop("href").replace(/^.*[\\\/]/, '');
            element.DownloadLink =   dlink;
            if (element.Id == 'added')
                element.DBOP = 1;
            typeof (element.uplodednotes != 'undefined')
            {
                if (element.DBOP != 4) {
                    Documents.push(element);
                }
                mathedcount++;
            }


            loopcount++;

        }
        var comments = $("#txt_comments").val();

        if (JobTitle == null || JobTitle == "") {
            $.alert({
                type: 'red',
                title: 'Alert!',
                content: 'Please Provide Job Title',
            });

            JobDetailValidate = 0;
        }

        else if (JobPostedDate == null || JobPostedDate == "") {
            $.alert({
                type: 'red',
                title: 'Alert!',
                content: 'Please Provide Job Posted Date',
            });

            JobDetailValidate = 0;
        }

        else if (JobApplyLink == null || JobApplyLink == "") {
            $.alert({
                type: 'red',
                title: 'Alert!',
                content: 'Please Provide Apply Link',
            });

            JobDetailValidate = 0;
        }
        else if (Location == null || Location == "") {
            $.alert({
                type: 'red',
                title: 'Alert!',
                content: 'Please provide Location',
            });

            JobDetailValidate = 0;
        }
        else if (JobDescp == null || JobDescp == "") {
            $.alert({
                type: 'red',
                title: 'Alert!',
                content: 'Please Provide Job Description',
            });

            JobDetailValidate = 0;
        }

        else if (Str_Qual == null || Str_Qual == "") {
            $.alert({
                type: 'red',
                title: 'Alert!',
                content: 'Please Select Qualification',
            });

            JobDetailValidate = 0;
        }
        

        if (JobDetailValidate > 0) {
            var JobDetails = new Object();

            JobDetails.JobNo = JobNumber;
            JobDetails.JobTitle = JobTitle;
            JobDetails.PostedDate = JobPostedDate;
            JobDetails.ApplyLink = JobApplyLink;
            JobDetails.JobDesc = JobDescp;
            JobDetails.Qualification = Str_Qual;
            JobDetails.JobImpDates = JobData;
            JobDetails.JobNotes = Documents;
            JobDetails.Location = Location;
            JobDetails.comments = comments;
            
            
            $.ajax({
                type: "POST",
                url: "/Jobs/SaveJobDetails",
                data: JSON.stringify(JobDetails),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                   
                    if (response["status"] == '3') {
                        $.alert({
                            type: 'green',
                            title: 'Sucessfull!',
                            content: 'Job Saved Sucessfully!',
                        });

                        $('input[type="text"]').val('');
                        $("textarea").val('');
                        $("#txt_PostedDate").val('mm/dd/yyyy');
                        setTimeout(function () {

                            window.location.href = "/Jobs/ListJob_Admin";

                        }, 3000);
                        
                    }

                    else if (response["status"] == '4') {
                        $.alert({
                            type: 'warning',
                            title: 'Alert!',
                            content: 'Job Details and Important Dates Saved .But Failed to save Important Notes!',
                        });

                        $('input[type="text"]').val('');
                        $("textarea").val('');
                        $("#txt_PostedDate").val('mm/dd/yyyy');
                    }
                    else if (response["status"] == '1') {
                        $.alert({
                            type: 'warning',
                            title: 'Alert!',
                            content: 'Job Details  Saved .But Failed to save Important Dates and  Important Notes!',
                        });

                        $('input[type="text"]').val('');
                        $("textarea").val('');
                        $("#txt_PostedDate").val('mm/dd/yyyy');
                    }
                    else if (response["status"] == '2') {
                        $.alert({
                            type: 'warning',
                            title: 'Alert!',
                            content: 'Job Details and Important Notes Saved .But Failed to save Important Dates!',
                        });

                        $('input[type="text"]').val('');
                        $("textarea").val('');
                        $("#txt_PostedDate").val('mm/dd/yyyy');
                    }
                },

                error: function (response) {
                    $.alert({
                        type: 'red',
                        title: 'Alert!',
                        content: 'Failed to Save!',
                    });

                    $('input[type="text"]').val('');
                    $("textarea").val('');
                    $("#txt_PostedDate").val('mm/dd/yyyy');
                }
            });
        }

    });

    fetchJobDetails();
   

});
function PopulateQals() {
   $.ajax({
       url: '/Jobs/GetDegreeList',


        dataType: "json",
        success: function (data) {
          
           QualData = JSON.parse(data);
           //$.each(data, function (i, item) {
           //    babyNames.push(item.Keyword);
           //});​
           for (index = 0; index < QualData.length; index++) {
               var element = {};
               element.name = QualData[index].Keyword;

               QualNames.push(element);
           } 
           
                
        }
    });
}
var QualData = [];
var QualNames= [
   
];
var DeleteNotes = [];
var RowStatus = [

];
function UpdateStatus(id) {
    
    var IdNo = $("#" + id).parentsUntil("tr").parent().data("idno");
    if (IdNo != 'added') {
        var element = {};
        element.id = IdNo;
        element.status = "Modified";
    }
    else {
        var element = {};
        element.id = IdNo;
        element.status = "Added";
    }
    var exist = search(IdNo, RowStatus);
       if(!exist)
        RowStatus.push(element);
    
}
function UploadNotes() {
    // alert("a");
    var today = new Date();
    // console.log(today);
    var date = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
    //var date1 = today.getDate() + "-" + (today.getMonth() + 1) + "-" + today.getFullYear();
    // console.log(date);
    var time = today.getHours() + "-" + today.getMinutes() + "-" + today.getSeconds();
    var dateTime = date + "-" + time;
    var fileUpload = $("#importantNotesfile").get(0);
    var files = fileUpload.files;
    var modifiedfilename = "";
    var actualfilename = "";
    if (files.length > 0) {
        actualfilename = files[0].name;
        modifiedfilename = dateTime + "-" + files[0].name;
    }

   
    var fileData = new FormData();
    // Looping over all files and add it to FormData object  
    for (var i = 0; i < files.length; i++) {
        fileData.append(dateTime + "-" + files[i].name, files[i]);
    }

    $.ajax({
        url: '/Jobs/UploadNotes',
        type: "POST",
        contentType: false, // Not to set any content header  
        processData: false, // Not to process data  
        data: fileData,
        success: function (result) {

            
            var count = $('.uplodednotes').length;
            var count1 = $('.uplodedby').length;
            var count2 = $('.uplodeddate').length;
            count++;
            count1++;
            count2++;
            var htm = '<tr id="addr_' + count +'" data-idno="added"><td id="uplodednotes_' + count + '" class="uplodednotes"><a href= "' + "/Notes/" + modifiedfilename + '">' + actualfilename + '</a> ' + '</td><td id="uplodedby_' + count1 + '" class="uplodedby">'+result+'</td><td id="uplodeddate_' + count2 + '" class="uplodeddate">' + date + '</td> <td> <i class="fa fa-times removenote" aria-hidden="true"></i></td></tr>';
            $("#DocUpload tbody").append(htm);
            count++;
        },
        error: function (err) {
            alert(err.statusText);
        }
    });
}

function search(nameKey, myArray) {
    for (var i = 0; i < myArray.length; i++) {
        if (myArray[i].name === nameKey) {
            return true;
        }
        else 
            {
                return false;
            }
    }
}

function fetchJobDetails() {
    var JobNumber = GetParameterValues('JobNo');
    if (JobNumber != null) {
        $.ajax({
            type: 'GET',
            url: '/Jobs/FetchJobDetails',
            data: {
                JobNo: JobNumber
            },
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                $("#txt_JobNumber").val(data.JobNo);
                $("#txt_JobTitle").val(data.JobTitle);
                $("#txt_PostedDate").val(formatDate(data.PostedDate));
                $("#txt_AplyLink").val(data.ApplyLink);
                $("#txt_location").val(data.Location);
                $("#txt_comments").val(data.Comments);
                $(".note-editable").html(data.JobDesc);

                var Ql = data.Qualification;
                var temp = new Array();

                temp = Ql.split(",");

                var htm1 = '<a href="#" data-role="selected-item">';
                var htm2 = '</a>';
                $.each(temp, function (i, val) {

                    var final = htm1 + val + htm2;
                    $("div.sel-anchor").append(final);
                });



                
                $("#tab_logic tbody").html('');
                var tablerow = $('#tab_logic tbody tr').length;
                for (var i = 0; i < data.JobImpDates.length; i++) {
                    var Id= data.JobImpDates[i].Id;
                    var Evnts = data.JobImpDates[i].Events;
                    var EventDateTime = data.JobImpDates[i].EventDateTime;
                    var j = i + 1;
                    var htm = '<tr id="addr' + j + '"' + "data-idno=" + Id + '><td id="srn' + j + '">' + j + '</td><td><input type="text" id="productcode_' + j + '" placeholder="Event" onchange="return UpdateStatus(this.id)" class="form-control product"><input type="hidden" id="productcode_stock_' + j + '" aria-hidden="true"></td><td><div><input class="form-control eventDt" type="date" id="evntDate_' + j + '" name="bday" onchange="return UpdateStatus(this.id)" required="" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}"></div></td><td><span class="glyphicon glyphicon-remove" id="del_' + j + '" style="cursor: pointer;"></span></td></tr>'
                    $("#tab_logic tbody").append(htm);
                    $("#productcode_" + j).val(Evnts);
                    $("#evntDate_" + j).val(formatDate(EventDateTime));
                    //tablerow++;
                }


                $("#DocUpload tbody").html('');
                for (var i = 0; i < data.JobNotes.length; i++) {
                    var Title = data.JobNotes[i].Title;
                    var DownloadLink = data.JobNotes[i].DownloadLink;
                    var UploadedBy = data.JobNotes[i].Uplodedby;
                    var UplodedDT = formatDate(data.JobNotes[i].Uplodeddate);
                    var Id = data.JobNotes[i].Id;

                    var count = $('.uplodednotes').length;
                    var count1 = $('.uplodedby').length;
                    var count2 = $('.uplodeddate').length;
                    count++;
                    count1++;
                    count2++;
                    var htm = '<tr id="addr_'+count+'"'+ "data-idno=" + Id + '><td id="uplodednotes_' + count + '" class="uplodednotes"><a href="' + DownloadLink + '">' + Title + '</a></td><td id="uplodedby_' + count1 + '" class="uplodedby">' + UploadedBy + '</td><td id="uplodeddate_' + count2 + '" class="uplodeddate">' + UplodedDT + '</td> <td> <i class="fa fa-times removenote" aria-hidden="true"></i></td></tr>';
                    $("#DocUpload tbody").append(htm);

                }


            },
            error: function (ex) {
                alert("Message: " + ex.Message);
                alert("StackTrace: " + ex.StackTrace);
                alert("ExceptionType: " + ex.ExceptionType);
            }
        });
    }
    else {
        $("#txt_JobNumber").val("Auto Assigned");
    }
}