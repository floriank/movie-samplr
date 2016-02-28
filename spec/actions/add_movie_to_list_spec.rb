require 'rails_helper'

describe AddMovieToList do
  let(:action) { described_class }
  let(:user) { create :user }
  let(:title) { 'Un chien andalusie' }

  it 'creates a new movie from a title' do
    movie, _ = action.for(user: user, title: title, imdb_id: 'foo')

    expect(movie).to be_a Movie
    expect(movie).to be_persisted
  end

  it 'pushes the newly creates movie into the default list of the user' do
    movie, _ = action.for(user: user, title: title, imdb_id: 'foo')

    expect(user.lists.default.movies).to include movie
  end

  it 'returns the movies errors if any' do
    _, errors = action.for user: user, title: '', imdb_id: 'foo'

    expect(errors).to_not be_empty
  end
end
