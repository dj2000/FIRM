# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  selector_list = [
    'property_select'
    'client_select'
    'agent_select'
  ]
  for i of selector_list
    $('.' + selector_list[i]).chosen()

  $('.property_select').change (e) ->
    value = $(this).val()
    if value != ''
      $('.add-client').show()
    $.ajax
      url: '/insp_requests/get_property_clients'
      data:
        selector_id: value

  $('.client_select').change (e) ->
    value = $(this).val()
    $.ajax
      url: '/insp_requests/get_client_agents'
      data:
        selector_id: value