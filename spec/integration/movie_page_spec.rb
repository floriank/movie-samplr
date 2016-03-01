require 'rails_helper'
require_relative 'movie_page'

describe MoviePage, js: true, vcr: true do
  let(:page) { described_class.new }

  before do
    Capybara.current_driver = :selenium
  end

  after do
    Capybara.use_default_driver
  end

  describe '#show', :vcr do
    let(:user) { create :user }
    let(:list) { user.lists.default }
    let(:movie) { create :movie, user: user, lists: [list] }
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

    it 'allows for moving movies in and out of lists' do
      list = user.lists.create name: 'My new list'
      page.go_to movie
      expect(page).to have_content page.t('.lists_to_add')

      page.click_on_list list
      page.wait_for_ajax

      expect(page).to have_content page.t('.lists_to_remove')
    end

    it 'allows for removing the movie from a list' do
      page.go_to movie
      expect(page).to have_content page.t('.lists_to_remove')

      page.click_on_list user.lists.default
      page.wait_for_ajax

      expect(page).to have_content page.t('.lists_to_add')
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
