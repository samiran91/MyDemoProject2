
$(document).ready(function () {



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
                field: "Edit", title: "", width: 34, type: "icon",
                icon: "fal fa-pencil fa-2X", tooltip: "Edit", events: { "click": Edit }
            },
            {
                field: "Delete", title: "", width: 34, type: "icon",
                icon: "fas fa-times fa-2X", tooltip: "Delete", events: { "click": Remove }
            }
        ],
        pager: { enable: true, limit: 5, sizes: [2, 5, 10, 20] }


    });

    $("#txtname").autocomplete({

        source: function (request, response) {
            var data = $("#txtname").val();
           // debugger;
            $.ajax({
                url: "/Jobs/GetJobAutocompleteValue",

                data: {
                    Keyword: data
                },
                dataType: "json",
                success: function (data) {
                  //  debugger;
                    response($.map(JSON.parse(data), function (item) {
                        //  debugger;
                        //return { label: item.JobNo, value: item.jobtitle };
                        return { value: item };
                    }));
                }
            });
        },

        minLength: 1,

        select: function (event, ui) {
            $("#txtname").val(ui.item.value);
        },
        open: function () {
            $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
        },
        close: function () {
            $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
        }
    });


});

function Edit(e) {
    debugger;
    window.location.href = "/Jobs/Editjobdetail?JobNo=" + e.data.record.JobNo;
    
}

function Add() {
    window.location.href = "/Jobs/Editjobdetail";
}
function Search() {
    grid.reload({ searchString: $("#txtname").val() });
}

function Remove(e) {
    $.confirm({
        title: 'Alert!',
        content: 'Are you sure you want to delete?',
        type: 'red',
        typeAnimated: true,
        buttons: {
            Yes: {

                action: function () {
                    var ProductCode = e.data.record.ProductCode;
                    $.ajax({ url: "#", type: "POST", data: { ProductCode: ProductCode } })
                        .done(function () {
                            grid.reload();
                        })
                        .fail(function () {
                            $.alert({
                                title: 'Alert!',
                                content: 'Failed to delete.!',
                                type: 'red',
                            });
                        });

                }
            },
            no: function () {
            }
        }
    });

}


