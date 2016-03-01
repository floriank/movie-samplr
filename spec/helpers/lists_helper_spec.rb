require 'rails_helper'

RSpec.describe ListsHelper, type: :helper do
  let(:movie) { create :movie, name: 'the room' }
  let(:list) { create :list, movies: [movie] }

  describe '#presentable_movies' do

    it 'maps out a list of presentable movies' do
      expect(presentable_movies(list)).to be_an Array
      expect(presentable_movies(list).first).to be_a MoviePresenter
    end

    it "limits the movies to a maximum of #{Movie::MAX_DISPLAY}" do
      (Movie::MAX_DISPLAY + 1).times { |n| list.movies << create(:movie) }
      expect(presentable_movies(list).length).to eql Movie::MAX_DISPLAY
    end

    it 'ignores the limit if told' do
      (Movie::MAX_DISPLAY + 1).times { |n| list.movies << create(:movie) }
      # plus 2 because there was already a movie in the list
      expect(presentable_movies(list, true).length).to eql (Movie::MAX_DISPLAY + 2)
    end
  end

  describe '#show_more_link?' do
    it "returns false if the list of movies is no longer than #{Movie::MAX_DISPLAY}" do
      expect(show_more_link?(list)).to be_falsy
    end

    it "returns true if the list of movies is longer than #{Movie::MAX_DISPLAY}" do
      (Movie::MAX_DISPLAY + 1).times { |n| list.movies << create(:movie) }
      expect(show_more_link?(list)).to be_truthy
    end

    it "returns false if the list has exactly #{Movie::MAX_DISPLAY} entries" do
      (Movie::MAX_DISPLAY).times { |n| list.movies << create(:movie) }
      expect(show_more_link?(list)).to be_truthy
    end
  end
end
