class AddMovieToList
  def self.for(user:, title:, imdb_id:, list: user.lists.default)
    movie = Movie.new name: title, imdb_id: imdb_id
    if movie.save
      list.movies << movie
      return movie, []
    end
    return nil, movie.errors
  end
end
