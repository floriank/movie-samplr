class SearchController < ApplicationController

  before_filter :require_query!

  def index
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
