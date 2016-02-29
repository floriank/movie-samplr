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
end
