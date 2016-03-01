class ImdbDataWorker
  include Sidekiq::Worker

  def perform(imdb_id)
    dataset = Dataset.find_or_initialize_by imdb_id: imdb_id

    return if dataset.persisted? && dataset.updated_at > 30.days.ago

    movie = Imdb::Movie.new(imdb_id)
    dataset.update_attributes({
      title: movie.title,
      plot: movie.plot,
      plot_summary: movie.plot_summary,
      year: movie.year,
      tagline: movie.tagline,
      imdb_id: imdb_id,
      poster_url: movie.poster,
      cast: movie.cast_members,
      director: movie.director
    })
  end
end
