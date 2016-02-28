module SearchHelper
  def imdb_url(movie)
    "http://imdb.com/title/tt#{movie.id}"
  end

  def optional_query
    params[:m]
  end

  def user_has_movie?(movie)
    current_user.lists.default.movies.pluck(:imdb_id).include? movie.id
  end
end
