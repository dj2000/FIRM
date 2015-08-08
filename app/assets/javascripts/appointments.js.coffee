# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#appointment_prepaid').change ->
	  value = $('#appointment_prepaid').is(':checked')
	  if value == true
	    $('.payment_method').show()
	  else
	    $('.payment_method').hide()
	  return

	$('#client_property_escrow').change ->
	  value = $('#client_property_escrow').is(':checked')
	  if value == true
	    $('.escrow_date').show()
	  else
	    $('.escrow_date').hide()
	  return