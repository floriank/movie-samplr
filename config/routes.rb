Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  resources :movies, only: [:create, :update, :destroy]
  resources :lists,except: :show
  get :search, to: 'search#index', as: :search
  root to: 'home#index'
end
