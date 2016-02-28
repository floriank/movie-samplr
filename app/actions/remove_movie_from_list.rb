class RemoveMovieFromList
  def self.for(movie:, user:, list: user.lists.default)
    unless user.lists.include? list
      return nil, [{ message: 'cannot remove another users movies'}]
    end

    unless movie.user == user
      return nil, [{error: 'cannot delete someone elses movies'}]
    end

    list.movies.delete(movie)
    return movie, []
  end
end
