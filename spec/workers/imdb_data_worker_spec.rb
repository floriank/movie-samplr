require 'rails_helper'

describe ImdbDataWorker, :vcr do
  let(:id) { "1431045" } # deadpool
  let(:worker) { described_class.new }

  it 'should retrieve the data for a given id and write it into a new dataset' do
    worker.perform(id)

    expect(Dataset.count).to eql 1
  end
end
