$(document).on 'turbolinks:load', ->


  $('#parts.list a').click ->
    $('#assignment_title').val($(this).text())
