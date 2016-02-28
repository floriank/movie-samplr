require 'rails_helper'
require_relative 'splash_page'

describe SplashPage do
  let(:page) { described_class.new }

  it 'displays a welcome' do
    expect(page).to have_content(page.t('.hero_intro'))
  end

  it 'displays the subline' do
    expect(page).to have_content(page.t('.hero_intro_sub'))
  end

  it 'provides an interface to lookup a movie quickly' do
    expect(page.search_box).to be_present
  end

  it 'should redirect to the search page if the users looks for a movie' do
    page.search 'The Good, the Bad an the Ugly'
    expect(page.current_path).to eql search_path
  end

  context 'for a registered user' do
    before do
      user = create :user
      login_as(user, scope: :user)
    end
    it 'presents a link to the users collection' do
      expect(page.collection_link).to be_present
      expect(page).to have_content(page.t('.welcome_back'))
    end
  end
end
