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

function getDocumentImages(type, target){
    var imgName;
    if (type == 'docx' || type == 'doc' || type == 'pdf'){
      imgName = '/assets/' + type + '_icon.png'
    }
    else{
      imgName =  target;
    }
    return imgName;
  }

  function loadPreview(divId, previewClass){
    $("#" + divId).change(function () {
      if (typeof (FileReader) != "undefined") {
        var divPreview = $("." + previewClass);
        divPreview.html("");
        $($(this)[0].files).each(function () {
          var file = $(this);
          var file_name = file[0].name;
          var file_ext = file_name.toLowerCase().split(".").slice(-1)[0];
          var reader = new FileReader();
          reader.onload = function (e) {
            var documentImage = getDocumentImages(file_ext, e.target.result)
            var img = $("<img />");
            img.attr("style", "height:100px;width:100px;border-radius: 8px;").attr('title', file_name);
            if (documentImage){
              img.attr('src', documentImage)
            }
            divPreview.append(img);
          }
          reader.readAsDataURL(file[0]);
        });
      }
      else {
        alert("This browser does not support HTML5 FileReader.");
      }
    });
  }