$ ->
  # adding and removing from default list
  $('.add-to-default-list').on 'click', ->
    button = $(@)
    path = button.data('href')
    imdb_id =  button.data('id')
    title =  button.data('title')
    $.post path,
      movie:
        imdb_id: imdb_id,
        title: title
      () ->
        button.text(button.data('added')).attr('disabled', true)

  $('.remove-from-default-list').on 'click', ->
    button = $(@)
    path = button.data('href')
    $.ajax
      type: 'DELETE',
      url: path,
      success: ->
        button.text(button.data('removed')).attr('disabled', true)

  # on-click notes
  paragraph = $('p.notes')
  form      = $('div.notes')
  paragraph.on 'click', ->
    paragraph.addClass('hidden')
    form.removeClass('hidden')

