$(document).on 'turbolinks:load', ->

  $('.form-remover').click ->
    target = '#' + $(this).data('target')
    $(target).remove()

  $('a.modal-open').click ->
    target = '#' + $(this).data("modal")
    $(target).addClass("active")
    $('body').css("overflow", "hidden")

  $('.modal section .closer').click ->
    $(this).parents('.modal').removeClass("active")
    $('body').css("overflow", "auto")

  $ ->
    $('#allsubmit').click ->
      $('form').each ->
        valuesToSend = $(this).serialize()
        $.ajax $(this).attr('action'),
          method: $(this).attr('method')
          data: valuesToSend
        return
      return
    return
