module ListsHelper
  # helper to initialize presenter over movie entries in the list
  def presentable_movies(list)
    list.movies.limit(Movie::MAX_DISPLAY).map { |movie| MoviePresenter.new movie }
  end

  def show_more_link?(list)
    list.movies.length > Movie::MAX_DISPLAY
  end
end
