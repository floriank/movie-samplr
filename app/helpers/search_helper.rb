module SearchHelper
  def imdb_url(movie)
    if movie.is_a? MovieSearchResult
      return "http://imdb.com/title/tt#{movie.id}"
    end
    "http://imdb.com/title/tt#{movie.imdb_id}"
  end

  def optional_query
    params[:m]
  end

  def user_has_movie?(user, movie)
    id = movie.is_a?(MovieSearchResult) ? movie.id : movie.imdb_id
    user.lists.default.movies.pluck(:imdb_id).include? id
  end
end
