require 'rails_helper'

describe MovieSearchResult do
  let(:result) { described_class.new title: 'Hitchhikers guide to the Galaxy', id: 42 }

  it 'decides if it is a result from imdb' do
    expect(result.imdb?).to be_falsy
    expect(result.local?).to be_truthy
  end

  it 'decides if a result is local' do
    reult = described_class.new title: 'Deadpool', type: 'imdb'
    expect(result.local?).to be_falsy
    expect(result.imdb?).to be_truthy
  end
end
