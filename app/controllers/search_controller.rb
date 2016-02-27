class SearchController < ApplicationController

  before_filter :require_query!

  def index
    @local_results = LookupMovie.for search_query
    @imdb_results = LookupImdbMovie.for(search_query, limit: 10)
  end

  private

  def require_query!
    @query = search_query
  end

  def search_query
    params.require(:m)
  rescue
    redirect_to root_path
  end
end
