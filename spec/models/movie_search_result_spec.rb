require 'rails_helper'

describe MovieSearchResult do
  let(:result) { described_class.new title: 'Hitchhikers guide to the Galaxy', id: 42 }

  it 'decides if it is a result from imdb' do
    expect(result.imdb?).to be_falsy
    expect(result.local?).to be_truthy
  end
end
