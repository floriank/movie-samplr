require 'rails_helper'
require_relative 'movie_page'

describe MoviePage, js: true do
  let(:page) { described_class.new }

  before do
    Capybara.current_driver = :selenium
  end

  after do
    Capybara.use_default_driver
  end

  describe '#show' do
    let(:user) { create :user }
    let(:movie) { create :movie, user: user }
    let(:note) { 'Awesome movie, would watch again!' }
    before(:each) do
      page.login_as! user
    end

    it 'allows adding notes' do
      page.go_to movie
      page.add_notes note
      page.wait_for_ajax

      expect(page).to have_content note
    end

    context 'without a dataset' do
      it 'tells the user that data is currently fetched' do
        page.go_to movie
        expect(page.html).to include page.t('.movie_being_loaded')
      end
    end

    context 'with a dataset' do

    end
  end
end
