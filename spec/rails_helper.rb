# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

# capybara integration
require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Test mode for Warden (=> Devise)
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end

  config.include Devise::TestHelpers, type: :controller

  # Factory Settings
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false

  # Use transactions by default
  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  # For the javascript-enabled tests, switch to truncation, but *only on tables that were used*
  config.before :each, js: true do
    DatabaseCleaner.strategy = :truncation, { pre_count: true }
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

module CommonPageObject
  extend ActiveSupport::Concern

  included do
    include Capybara::DSL
    include Rails.application.routes.url_helpers

    def default_url_options
      ActionMailer::Base.default_url_options
    end
  end

  def login_as!(user, password = 'stanl3ykubr1k')
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: password
    click_on I18n.t('devise.sessions.new.log_in')
  end

  def search(movie)
    visit search_path(m: movie)
  end

  def reload
    visit current_url
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  private

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end
