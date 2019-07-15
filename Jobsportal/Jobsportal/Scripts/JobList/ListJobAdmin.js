
$(document).ready(function () {



    grid = $('#grid').grid({
        primaryKey: 'JOBNO',
        uiLibrary: "bootstrap",
        responsive: true,

        dataSource: '/Jobs/GetJobList',
        columns: [
            { field: 'JobNo', title: 'Job Number', priority: 3 },
            { field: 'JobTitle', title: 'Job Title', sortable: true, priority: 1 },
            { field: 'PostedDate', title: 'Posted Date', sortable: true, type: 'date', priority: 2 },
            {
                field: "Edit", title: "", width: 34, type: "icon",
                icon: "fas fa-edit fa-2X", tooltip: "Edit", events: { "click": Edit }
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
            $.ajax({
                url: "/Jobs/GetJobAutocompleteValue",

                data: {
                    Keyword: data
                },
                dataType: "json",
                success: function (data) {
                    response($.map(JSON.parse(data), function (item) {
                        return { value: item };
                    }));
                }
            });
        },

        minLength: 1,

        select: function (event, ui) {
            $("#txtname").val(ui.item.value);
            Search();
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
    window.location.href = "/Jobs/EditJobDetail_Admin?JobNo=" + e.data.record.JobNo;
    
}

function Add() {
    window.location.href = "/Jobs/EditJobDetail_Admin";
}
function Search() {
    grid.reload({ searchfilteradmin: $("#txtname").val() });
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


