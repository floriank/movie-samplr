class LookupImdbMovie

  def self.for(query, opts = {})
    i = Imdb::Search.new(query)
    convert_to_movie_results!(i.movies, opts)
  end

  private

  def self.convert_to_movie_results!(result, opts)
    if opts.key? :limit
      result = result.first(opts[:limit])
    end
    result.map { |movie| MovieSearchResult.new title: movie.title, id: movie.id }
  end
end
