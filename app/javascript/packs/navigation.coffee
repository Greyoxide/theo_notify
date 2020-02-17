$(document).on 'turbolinks:load', ->
  
  $('#burger').click ->
    $('#burger').toggleClass('is-active')
    $('nav').toggleClass('is-active')
