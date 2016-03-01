require 'rails_helper'

RSpec.describe SearchHelper, type: :helper do
  let(:movie) { create :movie }


  describe '#imdb_url' do
    it 'provides a link to imdb given a movie' do
      expect(imdb_url(movie)).to eql 'http://imdb.com/title/tt003304'
    end

    it 'creates an imdb link for a given movie search result' do
      movie = MovieSearchResult.new type: 'imdb', id: 110_220, title: 'Deadpool'
      expect(imdb_url(movie)).to eql 'http://imdb.com/title/tt110220'
    end
  end

  describe '#user_has_movie?' do
    let(:user) { create :user }
    let(:movie) { create :movie, user: user, lists: [list] }
    let(:list) { user.lists.default }

    it 'checks if a user has a movie in their default list' do
      expect(user_has_movie?(user, movie)).to be_truthy
    end
  end
end
