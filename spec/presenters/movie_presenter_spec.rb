require 'rails_helper'

describe MoviePresenter do
  let(:movie) { build :movie, name: 'Lego Movie' }
  let(:presenter) { described_class.new(movie) }

  context 'fo a movie without a dataset' do
    it 'uses the initial title from the user' do
      expect(presenter.title).to eql 'Lego Movie'
    end

    it 'falls back to the default poster' do
      expect(presenter.poster).to eql 'default_poster.png'
    end

    it 'presents a hint that the movie is loaded at the moment' do
      expect(presenter.hint).to eql I18n.t('movie.loading')
    end

    it 'responds not truthfully to #loaded?' do
      expect(presenter.loaded?).to be_falsy
    end
  end

  context 'for a movie with a proper dataset' do
    let(:movie) { build :movie, dataset: create(:dataset) }

    it 'uses the title from the movie anyway' do
      expect(presenter.title).to eql movie.name
    end

    it 'uses the poster from the dataset' do
      expect(presenter.poster).to eql 'hellokitty.jpg'
    end

    it 'responds truthfully to #loaded?' do
      expect(presenter.loaded?).to be_truthy
    end

    it 'provides the cast from the dataset' do
      expect(presenter.cast).to eql 'Ryan Reynolds, Morena Baccarin, T.J. Miller'
    end

    it 'provides the director from the dataset' do
      expect(presenter.directors).to eql 'Tim Miller'
    end
  end
end
