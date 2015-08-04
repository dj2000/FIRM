# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  selector_list = [
    'property'
    'client'
    'agent'
  ]
  for i of selector_list
    $('.' + selector_list[i] + '_select').chosen()

  $('.property_select').change (e) ->
    value = $(this).val()
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

  addLink = (entity) ->
    selector_class = $('.' + entity + '_select')
    if selector_class.length
      selector_class.data('chosen').container.on 'keyup', (event) ->
        matchResult(entity, $(this))

      selector_class.data('chosen').container.on 'keydown', (event) ->
        matchResult(entity, $(this))

  matchResult = (selector, container) ->
    $('.add-' + selector).hide()
    text = container.find('.no-results').text()
    if text.match(/No results match/)
      $('.add-' + selector).show()
    return

  for i of selector_list
    addLink(selector_list[i])