
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
                icon: "glyphicon-pencil", tooltip: "Edit", events: { "click": Edit }
            },
            {
                field: "Delete", title: "", width: 34, type: "icon",
                icon: "glyphicon-remove", tooltip: "Delete", events: { "click": Remove }
            }
        ],
        pager: { enable: true, limit: 5, sizes: [2, 5, 10, 20] }


    });
 
});

function Edit(e) {
    window.location.href = "/Jobs/Editjobdetail";
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
