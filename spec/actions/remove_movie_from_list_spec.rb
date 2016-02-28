require 'rails_helper'

describe RemoveMovieFromList do
  let(:action) { described_class }
  let(:user) { create :user }
  let(:movie) { create :movie, user: user }

  before do
    user.lists.default.movies << movie
  end

  it 'removes a a movie from the default list if no list is given' do
    result, _ = action.for movie: movie, user: user
    expect(result).to equal(movie)
    expect(user.lists.default.movies.length).to eql 0
  end

  describe 'when trying to remove another users movies' do
    let(:second_user) { create :user, email: 'not@me.com' }
    let(:second_movie) { create :movie, user: second_user }

    it 'is not possible to remove another users movies from their list' do
      movie, err = action.for(user: second_user, movie: movie, list: user.lists.default)
      expect(movie).to be_nil
      expect(err.empty?).to be_falsy
    end

    it 'is not possible to target someone elses movie entry' do
      movie, err = action.for(user: user, movie: second_movie)
      expect(movie).to be_nil
      expect(err.empty?).to be_falsy
    end
  end
end
