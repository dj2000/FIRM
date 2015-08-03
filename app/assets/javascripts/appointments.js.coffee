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