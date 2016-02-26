require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomeHelper, type: :helper do
  it 'provides a dummy user signed in method for now' do
    expect(user_signed_in?).to be_falsy
    expect(user_signed_in?(true)).to be_truthy
  end
end
