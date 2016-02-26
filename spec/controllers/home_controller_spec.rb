require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it 'shows a splash page' do
    get :index
    expect(response).to be_successful
  end
end
