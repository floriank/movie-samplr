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
  end

  describe '#edit' do
    let(:list_name) { 'My personal movie collection' }
    it 'allows the renaming of a list' do
      page.go_to_collection
      page.rename_default_list(list_name)
      expect(page).to have_content(list_name)
      expect(user.lists.default.name).to eql list_name
    end
  end
end
