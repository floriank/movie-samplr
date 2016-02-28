Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  resource :movies, only: [:create, :update, :destroy]

  get :search, to: 'search#index', as: :search
  root to: 'home#index'
end
