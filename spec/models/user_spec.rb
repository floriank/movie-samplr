require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  it 'starts out with one default list' do
    expect(user.lists.default).to be_a List
    expect(user.lists.default.name).to eql I18n.t('.lists.default_name')
  end
end
