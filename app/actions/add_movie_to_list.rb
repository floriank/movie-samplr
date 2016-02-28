class AddMovieToList
  def self.for(user:, title:, imdb_id:, list: user.lists.default)
    movie = Movie.by(user).find_or_initialize_by imdb_id: imdb_id
    movie.name = title
    if movie.save
      list.movies << movie
      return movie, []
    end
    return nil, movie.errors
  end
end
