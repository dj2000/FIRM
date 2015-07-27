# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	add_search_dropdown = (selector) ->
	  $('.'+selector).selectize
	    create: false
	    sortField: 'text'
	    onChange: (value) ->
	      console.log('value is '+ value)
	      return
	    onType: (text) ->
	    	return
	  return

	add_search_dropdown('property_select')
	add_search_dropdown('customer_select')
	add_search_dropdown('agent_select')