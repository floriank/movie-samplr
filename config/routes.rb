Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  resources :movies, only: [:create, :update, :destroy, :show]

  put '/lists_movies/:list_id/:movie_id',
    controller: 'movies',
    action: :add_to_list,
    as: :add_lists_movies,
    constraints: { format: :js}

  delete '/lists_movies/:list_id/:movie_id',
    controller: 'movies',
    action: :delete_from_list,
    as: :delete_lists_movies,
    constraints: { format: :js}

  resources :lists
  get :search, to: 'search#index', as: :search
  root to: 'home#index'
end
