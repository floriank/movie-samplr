require 'rails_helper'

require_relative 'search_result_page'

describe SearchResultPage, js: true do
  let(:page) { described_class.new }
  let(:user) { create :user, email: 'bruce@banner.com' }

  before do
    Capybara.current_driver = :selenium
  end

  after do
    Capybara.use_default_driver
  end

  it 'lets the user add a title to their default list' do
    page.login_as! user
    page.search 'Vertigo'
    page.add_first_movie_in_list
    page.wait_for_ajax
    expect(user.lists.default.movies.count).to eql 1
  end

  it 'lets the user remove and added movie from the list' do
    page.login_as! user
    page.search 'Vertigo'
    page.add_first_movie_in_list
    page.wait_for_ajax
    page.reload
    page.remove_first_movie_in_list
    expect(user.lists.default.movies.count).to eql 0
  end
end
