class LookupImdbMovie
  def self.for(query, opts = {})
    i = Imdb::Search.new(query)
    convert_to_movie_results!(i.movies, opts)
  end

  private

  def self.convert_to_movie_results!(result, opts)
    result = result.first(opts[:limit]) if opts.key? :limit
    result.map { |movie| MovieSearchResult.new title: movie.title, id: movie.id, type: 'imdb' }
  end
end
