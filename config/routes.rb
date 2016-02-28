Rails.application.routes.draw do
  devise_for :users
  get :search, to: 'search#index', as: :search
  root to: 'home#index'
end
