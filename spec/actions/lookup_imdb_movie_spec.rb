require 'rails_helper'

describe LookupImdbMovie do
  let(:action) { described_class }

  it 'looks up a movie via imdb' do
    movies = action.for 'Nightmare'
    expect(movies).to be_an Array
    expect(movies[0]).to be_a MovieSearchResult
  end

  it 'limits the amount of results' do
    movies = action.for 'Wall-E', limit: 5
    expect(movies.length).to eql(5)
  end

  it 'marks every movie sarch result as an imdb result' do
    movie = action.for('Star Wars', limit: 1).first
    expect(movie.imdb?).to be_truthy
  end
end
