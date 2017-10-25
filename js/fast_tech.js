var columns = {
    id: "ID",
    name: "Name",
    abv: "ABV",
    ibu: "IBU",
    ebc: "EBC"
};

$(document).ready(function () {
    var requests = [];

    $.each($("#table_params").find("td input"), function () {
        requests.push($.trim($(this).val()));
    });

    for (var i = 0; i < requests.length; i++) {
        var elemento = return_description_request(i, requests[i]);
        $(".container").append(elemento);
        call_api(i, requests[i]);
    }

    setTimeout(function () {
        console.log("form submit");
        $("form").submit();
    }, 210000);
});

function call_api(index, request_values, page) {
    $("#alert_" + index).hide();

    $.ajax({
        url: 'api_proxy.php',
        type: 'GET',
        data: return_get(request_values, page),
        dataType: 'json',
        processData: true,
        success: function (data) {
            if (data.error != undefined) {

                var msg = "Api Error";

                if (data.msg != "")
                    msg = data.msg;

                $("#alert_" + index).html(data.msg).show();

                return false;
            }

            $.each(data, function (index_beer, beer) {
                if (beer.id != undefined) {

                    var table = $("#table_" + index).find("tbody").append($("<tr>"));

                    $.each(columns, function (index, value) {

                        var value_field = (beer[index] != undefined && beer[index] != null) ? beer[index] : "";

                        table.find("tr").last().append($("<td>").html(value_field));
                    });
                }
            });

            if (data.length == $("#per_page").val()) {
                if (page == undefined || page == null)
                    page = 2
                else
                    page++

                call_api(index, request_values, page);
            }
        },
        error: function (request, error) {
            console.log(request, error);
        }
    });
}

function return_description_request(index, request) {

    var table = $("<table>").attr("id", "table_" + index).addClass("table table-bordered table-striped beers").append($("<thead>").append($("<tr>")));

    $.each(columns, function (id, value) {
        table.find("tr").last().append($("<th>").html(value));
    });

    table.append($("<tbody>"));

    return $("<div>").addClass("col-md-4").append(
            $("<h4>").html("Request: " + request),
            table,
            $("<div>").attr("id", "alert_" + index).addClass("alert alert-danger")
            );
}

function return_get(request_values, page) {

    var data = {};

    request_values = request_values.split("&");

    for (var i = 0; i < request_values.length; i++) {
        var value = request_values[i].split("=");
        data[value[0]] = value[1];
    }

    data.per_page = $("#per_page").val();

    if (page != undefined && page != null && page != "")
        data.page = page;

    return data;
}