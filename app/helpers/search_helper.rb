module SearchHelper
  def imdb_url(movie)
    "http://imdb.com/title/tt#{movie.id}"
  end

  def optional_query
    params[:m]
  end
end
