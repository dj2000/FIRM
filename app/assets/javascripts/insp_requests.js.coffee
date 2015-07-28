# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  add_search_dropdown = (selector) ->
    $('.'+selector).selectize
      create: false
      sortField: 'text'
      onChange: (value) ->
        if selector == "property_select" or selector == 'client_select'
          filter_type = $('.'+selector).data('filtertype')
          $.ajax
            url: '/insp_requests/get_'+filter_type
            data:
              selector_id: value
            dataType: 'script'
            success: (result) ->
              console.log "success found"
              
              render: option: (item, escape) ->
                console.log item
                '<div data-value="#{item.text}">' + escape(item.text) + '</div>'
        return
      onType: (text) ->
        return
    return

  selector_list = [
    'property_select'
    'client_select'
    'agent_select'
  ]

  for sel in selector_list
    add_search_dropdown(sel)