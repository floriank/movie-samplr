require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { build :user }
  it 'is not valid by itself' do
    expect(List.new).to_not be_valid
  end

  it 'is valid with a user and a proper name' do
    expect(List.new user: user, name: 'A name to give to a list').to be_valid
  end
end
