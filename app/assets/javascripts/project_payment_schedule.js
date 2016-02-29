$(document).ready(function(){
	$(".paid").change(function(){
		var container = $(this).closest('tr');
		var datePaid = container.find("div .date-paid");
		var selected = container.find('select.payment_type option:selected').val();
		if($(this).is(":checked")){
			datePaid.removeClass("hide");
			showClosed(selected, true)
		}
		else{
			datePaid.addClass("hide");
			showClosed(selected, false)
		}
	});
	$(".input-group.date").on('changeDate', function() {
    var paidCheckbox = $(this).closest('tr').find('.paid');
    paidCheckbox.attr("disabled", false);
    paidCheckbox.removeClass("disabled");
  });

	$(".invoice_date").change(function(){
		if($(this).val() == ""){
			var paidCheckbox = $(this).closest('tr').find('.paid');
			paidCheckbox.attr("disabled", true);
		}
	});

	$("select.payment_type").on('change', function(){
		var selected = $("select.payment_type").val();
		var paid = $(this).closest('tr').find('.paid');
		showClosed(selected, paid.is(":checked"))
	});

	function showClosed(selected, paid){
		if((selected == "Completion Payment" || selected == "Final Sign Off") && (paid == true)){
			$(".status").removeClass("hide");
		}
		else{
			$(".status").addClass("hide");
		}
	}

	$("input[name='project[status]']").change(function(){
		if($(this).is(":checked")){
			$(".send-email-to-client").removeClass("hide");
		}
		else{
			$(".send-email-to-client").addClass("hide");
		}
	});

	$(".email-to-client").click(function(){
		var clientEmail = $(this).data('client-email');
		var clientName = $(this).data('client-name');
		var inspectorName = $(this).data('inspector-name');
		var inspectorFullName = $(this).data('inspector-full-name')
		var contents = "Hi " + clientName + ",\n\n";
		contents += inspectorName + " here, I just wanted to take a moment to thank you again for choosing us to take care of your foundation needs, I really appreciate the vote of confidence and of course hope our whole team has met or exceeded all of your expectations!\n\n";
		contents += "If you ever have any questions or need further assistance, please feel free to let me know.\n\n";
		contents += "Beyond that, and this is a humble request, I wondered if you wouldn't mind taking a few moments to let others in on your experience with us. You can do so by clicking on your preferred link below which will take you to a page where you can comment on us. We are very much a word-of-mouth business and your comments are invaluable to future customers looking on-line for a good foundation company!\n\n";
		contents += "Thanks in advance for taking the time to do this, I'm sure you value your time and I appreciate your willingness to have shared a slice of it this way!\n\n";
		contents += "All the best,\n\n";
		contents += inspectorFullName
		var mailToUrl = "mailto:" + clientEmail +"?subject=Welcome Email&body=" + encodeURIComponent(contents);
		location.href = mailToUrl;
	});
});