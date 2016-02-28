Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }
  get :search, to: 'search#index', as: :search
  root to: 'home#index'
end
