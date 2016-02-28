class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    return root_path unless query.present?
    search_path(m: query)
  end

  private

  def query
    params[:user][:query]
  end
end
