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
    find_movie_and_list
    movie, errors = RemoveMovieFromList.for user: current_user, list: @list, movie: @movie
    if errors.any?
      render json: { errors: errors }, status: :unauthorized
    else
      render json: { movie: movie }, status: :ok
    end
  end

  private

  def movie_params
    params.require(:movie).permit :imdb_id, :title, :id
  end

  def list_params
    params.require(:list).permit :id
  end

  def movie_title
    movie_params.require(:title)
  end

  def imdb_id
    movie_params.require(:imdb_id)
  end

  def find_movie_and_list
    @movie = Movie.by(current_user).find(movie_params[:id])
    @list = List.for(current_user).find(list_params[:id])
  end
end
