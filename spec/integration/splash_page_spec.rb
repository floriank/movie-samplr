require 'rails_helper'
require_relative "splash_page"

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

  context 'for a registered user' do
    before do
      # mock the user signed in function, as we do not have a real user for this
      allow_any_instance_of(HomeHelper).to receive(:user_signed_in?).and_return(true)
    end
    it 'presents a link to the users collection' do
      expect(page.collection_link).to be_present
      expect(page).to have_content(page.t('.welcome_back'))
    end
  end
end
