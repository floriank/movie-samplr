$ ->
  $('.add-to-default-list').on 'click', (e) ->
    e.preventDefault()
    button = $(@)
    path = button.data('href')
    imdb_id =  button.data('id')
    title =  button.data('title')
    $.post path,
      movie:
        imdb_id: imdb_id,
        title: title
      (response) ->
        button.text(button.data('added')).attr('disabled')

