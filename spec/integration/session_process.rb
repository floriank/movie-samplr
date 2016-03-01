# a page object describing the registration/login/forgot password process
class SessionProcess
  include CommonPageObject

  def initialize(to = new_user_registration_path)
    visit to
  end

  def register_as(user, override = {})
    fill_in 'user_email', with: override.fetch(:email, user.email)
    fill_in 'user_password', with: override.fetch(:password, user.password)
    fill_in 'user_password_confirmation', with: override.fetch(:password_confirmation, user.password)
    click_on t('registrations.new.sign_up')
  end

  def login_as(user, override = {})
    fill_in 'user_email', with: override.fetch(:email, user.email)
    fill_in 'user_password', with: override.fetch(:password, user.password)
    click_on t('sessions.new.log_in')
  end

  def switch_to_login
    click_on t('shared.links.already_registered_login')
  end

  def switch_to_register
    click_on t('shared.links.not_registered_yet_create_account')
  end

  # wrapper around a specific I18n path
  def t(term)
    I18n.t("devise.#{term}")
  end
end
