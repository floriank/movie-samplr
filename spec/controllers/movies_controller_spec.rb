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
      let(:movie) { create :movie, user: user, lists: [list] }
      let(:list) { user.lists.default }
      it 'removes a movie from the default list' do
        delete :destroy, {
          id: movie.imdb_id
        }

        expect(response).to be_successful
        expect(list.movies).to_not include movie
      end
    end

    describe '#add_to_list' do
      let(:movie) { create :movie, user: user }
      let(:list) { create :list, user: user }

      it 'adds a given movie to a list' do
        put :add_to_list, {
          movie_id: movie.id,
          list_id: list.id,
          format: :js
        }

        expect(response).to be_successful
        expect(list.movies).to include movie
      end

      it 'works only via JS' do
        put :add_to_list, {
          movie_id: movie.id,
          list_id: list.id
        }

        expect(response).to_not be_successful
      end
    end

    describe '#delete_from_list' do
      let(:list) { create :list, user: user }
      let(:movie) { create :movie, user: user, lists: [list] }

      it 'adds a given movie to a list' do
        put :delete_from_list, {
          movie_id: movie.id,
          list_id: list.id,
          format: :js
        }

        expect(response).to be_successful
        expect(list.movies).to_not include movie
      end

      it 'works only via JS' do
        put :delete_from_list, {
          movie_id: movie.id,
          list_id: list.id
        }

        expect(response).to_not be_successful
      end
    end
  end
end
