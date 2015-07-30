# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('select.state').change (e) ->
	  property_value = $(this).val()
	  $.ajax
	    url: '/properties/cities'
	    data: state: property_value
	    success: (result) ->
	    	selectTag = $(".city").empty()
	    	$("<option/>", text: "Please Select").appendTo selectTag
	    	for val of result
	    		$("<option/>",
	    			value: result[val[1]]
	    			text: result[val]
	  				).appendTo selectTag
	  return