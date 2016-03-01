require 'rails_helper'
require_relative 'lists_page'

describe ListsPage do
  let(:page) { described_class.new }
  let(:user) { create :user }

  before do
    page.login_as! user
  end

  describe '#index' do
    before do
      3.times do |n|
        user.lists.create name: "List ##{n}"
      end
    end

    it 'shows the lists of a user' do
      page.go_to_collection
      user.lists.each do |list|
        expect(page).to have_content list.name
      end
    end

    describe 'movie list' do

      it 'shows a list of movies underneath' do
        4.times do |n|
          create :movie, name: "Movie ##{n}", user: user, lists: [user.lists.default]
          expect(page).to have_content "Movie ##{n}"
        end
      end

      it 'shows 5 movies at maximum' do
        12.times do |n|
          create :movie, name: "Movie ##{n}", user: user, lists: [user.lists.default]
        end
        (6..12).each do |n|
          expect(page).not_to have_content "Movie ##{n}"
        end
      end
    end
  end

  describe '#edit' do
    let(:list_name) { 'My personal movie collection' }
    it 'allows the renaming of a list' do
      page.go_to_collection
      page.rename_default_list(list_name)
      expect(page).to have_content(list_name)
      expect(user.lists.default.name).to eql list_name
    end

    it 'does not allow the renaming to a name shorter than 5 character' do
      page.go_to_collection
      page.rename_default_list('foo')
      expect(page.error_message?).to be_truthy
    end
  end

  describe '#create' do
    let(:list_name) { 'Action & Adventure' }
    it 'allows the creation of new lists' do
      page.go_to_collection
      page.create_new_list(list_name)
      expect(page).to have_content(list_name)

      expect(user.lists.last.default).to be_falsy
      expect(user.lists.last.name).to eql list_name
    end

    it 'does not allow the creation of a list with a name shorter than 5 characters' do
      page.go_to_collection
      page.create_new_list('foo')
      expect(page.error_message?).to be_truthy
    end
  end

  describe '#destroy', js: true do
    let(:list_name) { 'Romantic comedies' }

    before do
      Capybara.current_driver = :selenium
      user.lists.create name: list_name
    end

    after do
      Capybara.use_default_driver
    end

    it 'removes a list on click' do
      # we have to do this manually here, as the before hook is overriden
      page.login_as! user
      page.go_to_collection
      page.remove_first_custom_list
      page.wait_for_ajax

      expect(page).to_not have_content list_name
    end
  end
end
