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
});