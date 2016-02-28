require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SearchHelper. For example:
#
# describe SearchHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SearchHelper, type: :helper do
  it 'creates an imdb link for a given movie search result' do
    movie = MovieSearchResult.new type: 'imdb', id: 110_220, title: 'Deadpool'
    expect(imdb_url(movie)).to eql 'http://imdb.com/title/tt110220'
  end
end
