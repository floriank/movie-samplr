class MoviesController < ApplicationController
  before_action :authenticate_user!

  rescue_from ActionController::ParameterMissing do
    render json: {}, status: :unprocessable_entity
  end

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

  def update
    @movie = Movie.by(current_user).find(params[:id])
    if @movie.update_attributes(movie_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @movie = MoviePresenter.new(Movie.by(current_user).find(params[:id]))
  end

  def destroy
    find_movie
    movie, errors = RemoveMovieFromList.for user: current_user, movie: @movie
    if errors.any?
      render json: { errors: errors }, status: :unauthorized
    else
      render json: { movie: movie }, status: :ok
    end
  end

  def add_to_list
    find_movie_and_list

    respond_to do |format|
      format.js do
        AddMovieToList.for(title: @movie.name, list: @list, imdb_id: @movie.imdb_id, user: current_user)
        @movie = MoviePresenter.new(@movie)
        render :lists_update
      end
    end
  rescue
    render json: {}, status: :unprocessable_entity
  end

  def delete_from_list
    find_movie_and_list

    respond_to do |format|
      format.js do
        RemoveMovieFromList.for(movie: @movie, list: @list, user: current_user)
        @movie = MoviePresenter.new(@movie)
        render :lists_update
      end
    end
  rescue
    render json: {}, status: :unprocessable_entity
  end

  private

  def movie_params
    params.require(:movie).permit :imdb_id, :title, :id, :notes
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

  def find_movie
    @movie = Movie.by(current_user).find_by(imdb_id: params[:id])
  end

  def find_movie_and_list
    @movie = Movie.by(current_user).find(params[:movie_id])
    @list = List.for(current_user).find(params[:list_id])
  end
end
