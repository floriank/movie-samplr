require 'rails_helper'
require_relative 'session_process'

describe SessionProcess, :vcr do
  let(:email) { 'dead@pool.com' }
  let(:password) { 'h3llok1tty' }
  let(:new_user) { build :user, password: password, email: email }
  let(:user) { create :user, password: password, email: email }
  let(:page) { described_class.new }

  shared_examples 'for a logged in user' do
    before do
      login_as user, scope: :user
    end

    it 'redirects to the front page' do
      expect(page.current_path).to eql root_path
    end
  end

  describe '#register' do
    context 'for anonymous user' do
      it 'registers a user' do
        page.register_as new_user
        expect(page.current_path).to eql root_path
        expect(User.count).to eql 1
      end

      it 'rejects existing emails' do
        page.register_as user
        expect(page.current_path).to eql '/users'
      end

      it 'allows switching to login' do
        page.switch_to_login
        expect(page.current_path).to eql new_user_session_path
      end

      it 'displays a message when trying to use an already existing user' do
        page.register_as user
        expect(page.error_message?).to be_truthy
      end

      it 'displays an error message when passwords do not match' do
        page.register_as new_user, password_confirmation: 'k1ttyh3llo'
        expect(page.error_message?).to be_truthy
      end
    end

    context 'after clicking on the add link' do
      let(:query) { 'Austin Powers 2' }
      let(:page) { described_class.new(new_user_registration_path(m: query)) }

      it 'redirects the user back to the search page they came from after registering' do
        page.register_as new_user
        expect(page.current_path).to eql search_path
      end
    end

    it_behaves_like 'for a logged in user'
  end

  describe '#login' do
    let(:page) { described_class.new(new_user_session_path) }

    context 'for anonymous user' do
      it 'displays a message for non existing users' do
        page.login_as new_user
        expect(page.current_path).to eql new_user_session_path
        expect(page.error_message?).to be_truthy
      end

      it 'allows switching to registration' do
        page.switch_to_register
        expect(page.current_path).to eql new_user_registration_path
      end
    end

    context 'after clicking on the add link' do
      let(:query) { 'Austin Powers 3' }
      let(:page) { described_class.new(new_user_session_path(m: query)) }

      it 'redirects the user back to the search page they came from after registering' do
        page.login_as user
        expect(page.current_path).to eql search_path
      end
    end

    it_behaves_like 'for a logged in user'
  end

  describe '#forgot_password', js: true do
    let(:page) { described_class.new(new_user_password_path) }

    it_behaves_like 'for a logged in user'

    before do
      create :user
    end

    it 'shows an error message if the email is not in the db' do
      page.fill_in 'user[email]', with: 'foo@bar.com'
      page.click_on page.t('passwords.new.send_instructions')
      expect(page.error_message?).to be_truthy
    end

    it 'sends the user back to the login page afterwards' do
      page.fill_in 'user[email]', with: user.email
      page.click_on page.t('passwords.new.send_instructions')
      expect(page).to have_content page.t('sessions.new.welcome_back')
    end
  end
end
