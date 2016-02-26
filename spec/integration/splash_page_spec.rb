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
end
