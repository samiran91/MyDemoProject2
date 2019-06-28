




$(document).ready(function () {

    var i = 1;
    // $(".quantity").spinner();
    $('.ui-spinner-button').click(function () {
        var id = $(this).siblings('input').attr('id')
        qtychanged(id);
    });

    $('.quantity').on('keyup keydown keypress blur change', function (e) {

        var id = event.target.id;
        qtychanged(id);


    })
    $("#add_row").click(function () {
        var count = $('.product').length;
        $('#tab_logic').append('<tr id="addr' + (count + 1) + '"></tr>');

        $('#addr' + (Number(count) + Number(1))).html("<td id='srn_" + (count + 1) + "'>" + (count + 1) + "</td ><td><input type='text' id='productcode_" + (count + 1) + "'  placeholder='Event' class='form-control product' /> <input type='hidden' id='productcode_stock_" + (count + 1) + "' aria-hidden='true' /></td><td> <input class='form-control eventDt' type='date' id='evntDate_" + (count + 1) + "'name='evntDate' required pattern='[0-9]{4}-[0-9]{2}-[0-9]{2}'></td><td> <span class='glyphicon glyphicon-remove'  id='del_" + (count + 1) + "'style='cursor: pointer;'></span></td>");


        //$(".quantity").spinner();//for new row
        $('.ui-spinner-button').click(function () {
            var id = $(this).siblings('input').attr('id')
            qtychanged(id);
        });
        $('.quantity').on('keyup keydown keypress blur change', function (e) {

            var id = event.target.id;
            qtychanged(id);


        })

        i++;

    });

    $("#myMultiSearch").multisearch({
        source: babyNames,
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

    //$("#SubmitJobDetail").click(function () {


    //    var JobNumber = $("#txt_JobNumber").val();
    //    var JobTitle = $("#txt_JobTitle").val();
    //    var JobPostedDate = $("#txt_PostedDate").val();
    //    var JobApplyLink = $("#txt_AplyLink").val();
    //    var JobDescp = $(".note-editable").text();


    //    var Qual = [];
    //    var Str_Qual;

    //    $("#myMultiSearch div.sel-anchor a").each(function () {
    //        Qual.push($(this).text());
    //        Str_Qual = Qual.toString();
    //    });

    //    var JobData = [];
    //    var Str_JobData;

    //    var mathedcount = 1;
    //    var count = $('.product').length;
    //    var loopcount = 1;
    //    while (mathedcount <= count) {
    //        var element = {};
    //        element.Events = $("#productcode_" + loopcount).val();
    //        element.EventDateTime = $("#evntDate_" + loopcount).val();
    //        typeof (element.ProductCode != 'undefined')
    //        {
    //            JobData.push(element);
    //            mathedcount++;
    //        }

    //        loopcount++;

    //    }


    //    var JobDetails = new Object();

    //    JobDetails.JobNo = JobNumber;
    //    JobDetails.JobTitle = JobTitle;
    //    JobDetails.PostedDate = JobPostedDate;
    //    JobDetails.ApplyLink = JobApplyLink;
    //    JobDetails.JobDesc = JobDescp;
    //    JobDetails.Qualification = Str_Qual;
    //    JobDetails.JobImpDates = JobData;

    //    console.log(JobDetails);
    //    debugger;
    //    $.ajax({
    //        type: "POST",
    //        url: "/Jobs/SaveJobDetails",
    //        data: JSON.stringify(JobDetails),
    //        contentType: "application/json; charset=utf-8",
    //        dataType: "json",
    //        success: function (response) {
    //              debugger;
    //            if (response["j"] == '1') {
    //                alert("Inside Insert");
    //            }
    //        },

    //        error: function (response) {
    //        }
    //    });


    //});


    $("#SubmitJobDetail").click(function () {

        var JobDetailValidate = 1;

        // var JobNumber = $("#txt_JobNumber").val();
        var JobTitle = $("#txt_JobTitle").val();
        var JobPostedDate = $("#txt_PostedDate").val();
        var JobApplyLink = $("#txt_AplyLink").val();
        var JobDescp = $(".note-editable").text();

        var Qual = [];
        var Str_Qual;

        $("#myMultiSearch div.sel-anchor a").each(function () {
            Qual.push($(this).text());
            Str_Qual = Qual.toString();
        });

        var JobData = [];
        var Str_JobData;

        var mathedcount = 1;
        var count = $('.product').length;
        var loopcount = 1;
        while (mathedcount <= count) {
            var element = {};
            element.Events = $("#productcode_" + loopcount).val();
            element.EventDateTime = $("#evntDate_" + loopcount).val();
            typeof (element.ProductCode != 'undefined')
            {
                JobData.push(element);
                mathedcount++;
            }

            loopcount++;

        }
       // debugger;
        var EventCount = 0;
        $("#tab_logic tr td input.product").each(function () {
            var vlue = $(this).val();
            if (vlue == null || vlue == "") {
                EventCount++;
            }
        });

        var EventDTCount = 0;
        $("#tab_logic tr td input.eventDt").each(function () {
            var vlue = $(this).val();
            if (vlue == null || vlue == "") {
                EventDTCount++;
            }
        });


        var Documents = [];
        var mathedcount = 1;
        var count = $('.uplodednotes').length;
        var count = $('.uplodedby').length;
        var count = $('.uplodeddate').length;

        var loopcount = 1;
        while (mathedcount <= count) {
            var element = {};
            element.Title = $("#uplodednotes_" + loopcount).text();
            element.Uplodedby = $("#uplodedby_" + loopcount).text();
            element.Uplodeddate = $("#uplodeddate_" + loopcount).text();
            var dlink = $("#uplodednotes_" + loopcount).text();
            element.DownloadLink = "~/CandidateImages/" + dlink;

            typeof (element.uplodednotes != 'undefined')
            {
                Documents.push(element);
                mathedcount++;
            }


            loopcount++;

        }
       // debugger;






        //  debugger;
        if (JobTitle == null || JobTitle == "") {
            $.alert({
                title: 'Alert!',
                content: 'Please Provide Job Title',
            });

            JobDetailValidate = 0;
        }

        else if (JobPostedDate == null || JobPostedDate == "") {
            $.alert({
                title: 'Alert!',
                content: 'Please Provide Job Posted Date',
            });

            JobDetailValidate = 0;
        }

        else if (JobApplyLink == null || JobApplyLink == "") {
            $.alert({
                title: 'Alert!',
                content: 'Please Provide Apply Link',
            });

            JobDetailValidate = 0;
        }

        else if (JobDescp == null || JobDescp == "") {
            $.alert({
                title: 'Alert!',
                content: 'Please Provide Job Description',
            });

            JobDetailValidate = 0;
        }

        else if (Str_Qual == null || Str_Qual == "") {
            $.alert({
                title: 'Alert!',
                content: 'Please Select Qualification',
            });

            JobDetailValidate = 0;
        }
        else if (EventCount > 0) {
            $.alert({
                title: 'Alert!',
                content: 'Please provide events',
            });

            JobDetailValidate = 0;
        }

        else if (EventDTCount > 0) {
            $.alert({
                title: 'Alert!',
                content: 'Please provide events Date',
            });

            JobDetailValidate = 0;
        }

        if (JobDetailValidate > 0) {
            var JobDetails = new Object();

            //JobDetails.JobNo = JobNumber;
            JobDetails.JobTitle = JobTitle;
            JobDetails.PostedDate = JobPostedDate;
            JobDetails.ApplyLink = JobApplyLink;
            JobDetails.JobDesc = JobDescp;
            JobDetails.Qualification = Str_Qual;
            JobDetails.JobImpDates = JobData;
            JobDetails.JobNotes = Documents;

         //   console.log(JobDetails);
            //         debugger;
            $.ajax({
                type: "POST",
                url: "/Jobs/SaveJobDetails",
                data: JSON.stringify(JobDetails),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //         debugger;
                    if (response["j"] == '1') {
                        $.alert({
                            title: 'Confirm!!',
                            content: 'Registration Successful!!',
                        });

                        $('input[type="text"]').val('');
                        $("textarea").val('');
                        $("#txt_PostedDate").val('mm/dd/yyyy');
                    }

                    else if (response["j"] == '0') {
                        $.alert({
                            title: 'Confirm!!',
                            content: 'Registration Error!!',
                        });

                        $('input[type="text"]').val('');
                        $("textarea").val('');
                        $("#txt_PostedDate").val('mm/dd/yyyy');
                    }
                },

                error: function (response) {
                    $.alert({
                        title: 'Alert!',
                        content: 'Insertion Error',
                    });

                    $('input[type="text"]').val('');
                    $("textarea").val('');
                    $("#txt_PostedDate").val('mm/dd/yyyy');
                }
            });
        }

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



$("#txt_invdate").val(getFormattedDate(today()));


$(document).on('click', '.glyphicon-remove', function (e) {
    var id = this.id;
    var delid = id.replace("del_", "");

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
function today() {
    return new Date();
}



// Get formatted date YYYY-MM-DD
function getFormattedDate(date) {
    return date.getFullYear()
        + "-"
        + ("0" + (date.getMonth() + 1)).slice(-2)
        + "-"
        + ("0" + date.getDate()).slice(-2);
}

function qtychanged(id) {

    var i = id.replace("quantity_", "");
    var rate = $("#rate_" + i).val();
    var qty = $("#quantity_" + i).val();
    var sto = $("#productcode_stock_" + i).val();
    rate = parseFloat(rate);
    qty = parseFloat(qty);
    sto = parseFloat(sto);

    if (sto >= qty) {
        var tot = rate * qty;
        $("#tax_" + i).val(parseFloat(tot).toFixed(2));
        var netamount = 0.00;
        var count = $('.total').length;
        var loopcount = 1;
        while (loopcount <= count) {
            netamount = netamount + parseFloat($("#tax_" + loopcount).val());
            loopcount++;

        }

        $("#netvalue").text(parseFloat(netamount).toFixed(2));
    }
    else {

    }
}

function CreateInvoice(e) {
    if (Validate()) {
        var $loader = $("#loader");
        $loader.gSpinner({

            scale: .5

        });
        $.confirm({
            title: 'Confirmation!',
            content: 'Plese select yes to create the invoice.',
            type: 'blue',
            typeAnimated: true,
            buttons: {
                Yes: {

                    action: function () {
                        var InvoiceData = {

                            InvoiceDate: $("#txt_invdate").val()
                        };



                        var ClientData = {

                            ClientId: $("#txt_custgstin").val(),
                            Name: $("#txt_custname").val(),
                            Address: $("#txt_custaddr").val(),
                            Email: $("#txt_custemail").val(),
                            Phone: $("#txt_custphone").val(),
                            iscontact: $("#chk_savecust").is(':checked')
                        };
                        //var productsData = [
                        //             { ProductCode: "JioFI", Quantity: '1' },
                        //             { ProductCode: "AIR4", Quantity: '2' }
                        //];
                        var productsData = [];
                        var mathedcount = 1;
                        var count = $('.product').length;
                        var loopcount = 1;
                        while (mathedcount <= count) {
                            var element = {};
                            element.ProductCode = $("#productcode_" + loopcount).val();
                            element.Quantity = $("#quantity_" + loopcount).val();
                            typeof (element.ProductCode != 'undefined')
                            {
                                productsData.push(element);
                                mathedcount++;
                            }
                            loopcount++;

                        }

                        if (productsData[0].ProductCode.length > 0 && productsData.length > 0) {

                            //  things = JSON.stringify({ 'things': things });
                            $.ajax({ url: "Invoice/CreateInvoice", type: "POST", data: { invoice: InvoiceData, client: ClientData, products: productsData } })
                                .success(function (response) {

                                    $loader.gSpinner("hide");
                                    if (response.invoiceno != null && response.PDFSuccess == true) {
                                        $.confirm({
                                            title: 'Sucessfull!',
                                            closeIcon: true,
                                            content: 'Invoice No-' + response.invoiceno + ' Created Sucessfully.' +
                                                '<form action="" class="formName">' +
                                                '<div class="form-group">' +
                                                '<label>Forward To</label>' +
                                                '<input type="email" placeholder="Email"  id="txt_fwdemail" value="' + ClientData.Email + '"class="email" required />' +
                                                '</div>' +
                                                '</form>',
                                            type: 'green',
                                            buttons: {
                                                "Forward as Email": {

                                                    action: function () {
                                                        var sendto = this.$content.find('#txt_fwdemail').val();
                                                        $.ajax({ url: "Invoice/ForwardEmail", type: "POST", data: { invoiceno: response.invoiceno, email: sendto } })
                                                            .success(function (result) {

                                                            })



                                                    }
                                                },
                                                "DownLoad": {
                                                    action: function () {

                                                        //                    $.ajax({ url: "/Main/SavePDF", type: "POST", data: { invoiceno: result } })
                                                        //.done(function (result) {
                                                        window.location.href = "Invoice/DownLoad?invoiceno=" + response.invoiceno;

                                                        //})
                                                    }
                                                }


                                            }
                                        });
                                    }
                                    else if (response.invoiceno != null && response.PDFSuccess == false) {
                                        $.alert({
                                            title: 'Alert!',
                                            content: 'A invoice with invoice no ' + response.invoiceno + " created sucessfully,but due to some techinal reason failed to create the PDF",
                                            type: 'warning',
                                        });
                                        $loader.gSpinner("hide");
                                    }
                                    else {
                                        $.alert({
                                            title: 'Alert!',
                                            content: 'Failed to Create Invoice.!',
                                            type: 'red',
                                        });
                                        $loader.gSpinner("hide");
                                    }
                                })
                                .fail(function (response) {

                                    $.alert({
                                        title: 'Alert!',
                                        content: 'Failed to Create Invoice.!',
                                        type: 'red',
                                    });
                                    $loader.gSpinner("hide");
                                });
                        }
                        else {
                            $.alert('Atleast one product required for invoice creation ', 'Alert!');
                            $loader.gSpinner("hide");
                        }
                    }
                },
                no: function () {
                    $loader.gSpinner("hide");
                }
            }
        });
    }
    else {
        $.alert('Missing Input', 'Alert!');
    }
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
    if (files.length > 0) {
        modifiedfilename = dateTime + "-" + files[0].name;
    }

   // debugger;
    var fileData = new FormData();
    // Looping over all files and add it to FormData object  
    for (var i = 0; i < files.length; i++) {
        fileData.append(dateTime + "-" + files[i].name, files[i]);
    }

    $.ajax({
        url: '/Jobs/UploadFiles',
        type: "POST",
        contentType: false, // Not to set any content header  
        processData: false, // Not to process data  
        data: fileData,
        success: function (result) {

          //  debugger;
            var count = $('.uplodednotes').length;
            var count1 = $('.uplodedby').length;
            var count2 = $('.uplodeddate').length;
            count++;
            count1++;
            count2++;
            var htm = '<tr><td id="uplodednotes_' + count + '" class="uplodednotes">' + modifiedfilename + '</td><td id="uplodedby_' + count1 + '" class="uplodedby">Maynak Nandi</td><td id="uplodeddate_' + count2 +'" class="uplodeddate">' + date + '</td> <td> <i class="fa fa-times" aria-hidden="true"></i></td></tr>';
            $("#DocUpload tbody").append(htm);
            count++;
        },
        error: function (err) {
            alert(err.statusText);
        }
    });
}