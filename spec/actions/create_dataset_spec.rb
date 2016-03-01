require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe CreateDataset do
  let(:action) { described_class }
  let(:movie) { create :movie }

  context 'with an existing dataset' do
    let(:dataset) { create :dataset }
    let(:movie) { create :movie, dataset: dataset }

    it 'does not do a thing if a movie already has a dataset' do
      expect(action.for(movie)).to be_truthy
    end
  end

  context 'without an existing dataset' do
    it 'schedules a ImdbDataWorker for the movie' do
      expect do
        action.for(movie)
      end.to change(ImdbDataWorker.jobs, :size).by(1)
    end
  end
end
