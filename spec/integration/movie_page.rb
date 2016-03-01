class MoviePage
  include CommonPageObject

  def add_notes(note)
    find('p.notes').click
    fill_in 'movie[notes]', with: note
    click_on t('.save_notes')
  end

  def go_to(movie)
    visit movie_path(movie)
  end

  def t(key)
    I18n.t("movies.show.#{key}")
  end
end
