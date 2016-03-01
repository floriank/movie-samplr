class MoviePresenter
  include Rails.application.routes.url_helpers
  delegate :name, :notes, :lists, :user, to: :@movie

  alias_method :title, :name
  attr_reader :movie

  def initialize(movie)
    @movie = movie
  end

  def poster
    dataset.poster_url || 'default_poster.png'
  end

  def cast
    loaded? ? dataset.cast.first(10).join(', ') : ''
  end

  def directors
    loaded? ? dataset.director.join(', ') : ''
  end

  def year
    loaded? ? dataset.year : ''
  end

  def tagline
    loaded? ? dataset.tagline : ''
  end

  def plot_summary
    loaded? ? dataset.plot_summary : ''
  end

  def hint
    return title if @movie.dataset.present?
    I18n.t('movie.loading')
  end

  def loaded?
    @movie.dataset.present?
  end

  def path
    movie_path @movie
  end

  def possible_lists
    user.lists.where.not(id: lists.map(&:id)).all
  end

  private

  def dataset
    @movie.dataset || OpenStruct.new
  end
end
