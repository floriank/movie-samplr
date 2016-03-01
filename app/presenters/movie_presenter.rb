class MoviePresenter

  delegate :name, to: :@movie

  alias_method :title, :name

  def initialize(movie)
    @movie = movie
  end

  def poster
    dataset.poster_url || 'default_poster.png'
  end

  def hint
    return title if @movie.dataset.present?
    I18n.t('movie.loading')
  end

  def loaded?
    @movie.dataset.present?
  end

  private

  def dataset
    @movie.dataset || OpenStruct.new
  end
end
