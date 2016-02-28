class SearchResultPage
  include CommonPageObject
  include Rails.application.routes.url_helpers

  def add_first_movie_in_list
    first('.add-to-default-list').click
  end

  def remove_first_movie_in_list
    first('button.remove-from-default-list').click
  end
end
