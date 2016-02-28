class MoviesController < ApplicationController

  before_action :authenticate_user!

  # aka. add to initial list
  def create
    movie, errors = AddMovieToList.for user: current_user, title: movie_title, imdb_id: imdb_id
    if errors.any?
      render json: { errors: errors }, status: :unprocessable_entity
    else
      CreateDataset.for movie
      render json: {}, status: :ok
    end
  end

  # aka. copy to list
  def update

  end

  # aka. remove from list
  def destroy

  end

  private

  def movie_params
    params.require(:movie).permit :imdb_id, :title
  end

  def movie_title
    movie_params.require(:title)
  end

  def imdb_id
    movie_params.require(:imdb_id)
  end
end
