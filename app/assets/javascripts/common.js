$(document).ready(function(){
	$('select.state').change(function(e){
		var state = $(this).val();
		$.ajax({
			url: '/cities',
			data: { state: state },
			success: function(result){
				var selectTag = $(".city").empty();
				$("<option/>").text("Please Select").appendTo(selectTag);
				for( var val in result){
					($("<option/>").text(result[val]).attr('value', result[val])).appendTo(selectTag);
				}
			}
		});
	});

  $('.input-group.date').datepicker({
    format: 'yyyy-mm-dd'
  });
});

function printReport(url, invoiceType){
  var startDate = $("#start_date").val();
  var endDate = $("#end_date").val();
  $.ajax({
    url: url,
    type: 'GET',
    data: { start_date: startDate, end_date: endDate, invoice_type: invoiceType },
    success: function() {}
  });
}

function printData(contents, startDate, endDate){
	var oldPage = document.body.innerHTML;
	document.body.innerHTML = contents;
	window.print();
	document.body.innerHTML = oldPage;
	$("#start_date").val(startDate);
	$("#end_date").val(endDate);
	$('.input-group.date').datepicker({
	  format: 'yyyy-mm-dd'
	});
}

function showInfo(url,request_url){
  if (request_url == "/"){
    window.location = "/"+ url;
  }
}
