class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if query.present?
      search_path(m: query)
    else
      root_path
    end
  end

  private

  def query
    return unless params[:user].present?
    params[:user][:query]
  end
end
