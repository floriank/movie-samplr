module ListsHelper
  # helper to initialize presenter over movie entries in the list
  def presentable_movies(list, no_limit = false)
    if no_limit
      movies = list.movies
    else
      movies = list.movies.limit(Movie::MAX_DISPLAY)
    end
    movies.map { |movie| MoviePresenter.new movie }
  end

  def show_more_link?(list)
    list.movies.length > Movie::MAX_DISPLAY
  end
end
