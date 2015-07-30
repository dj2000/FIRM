# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.agent_select').chosen()

  $('.property_select').chosen().change (e) ->
    value = $(this).val()
    $.ajax
      url: '/insp_requests/get_property_clients'
      data:
        selector_id: value
      dataType: 'script'
      success: (data, textStatus, jqXHR) ->
        console.log("success")

  $('.client_select').chosen().change (e) ->
    value = $(this).val()
    $.ajax
      url: '/insp_requests/get_client_agents'
      data:
        selector_id: value
      dataType: 'script'
      success: (data, textStatus, jqXHR) ->
        console.log("success")