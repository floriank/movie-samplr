require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  it 'requires a movie query to be accessed' do
    get :index, m: 'Primer'
    expect(response).to be_successful
  end

  it 'redirects upon not having a query parameter' do
    get :index
    expect(response).to redirect_to root_path
  end
end
