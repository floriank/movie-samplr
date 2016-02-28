require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:user) { create :user }

  context 'without a user' do
    before do
      allow(request.env['warden'])
        .to receive(:authenticate!)
        .and_throw(:warden, scope: :user)
    end
    it 'redirects to the login if no user is present' do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'for a proper user' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe '#create' do
      it 'adds a movie to the default list of the user' do
        post :create, movie: {
          imdb_id: 'foo',
          title: '8 Mile'
        }

        expect(response).to be_successful
      end

      it 'responds with unprocessable_entity if something goe wrong' do
        post :create,           movie: {
          title: '2001: A space odyssey',
          imdb_id: ''
        }

        expect(response).to_not be_successful
        expect(response.status).to eql 422
      end
    end

    describe '#destroy' do
      it 'removes a movie from a given list' do
      end
    end
  end
end
