Rails.application.routes.draw do
  get :search, to: 'search#index', as: :search
  root to: 'home#index'
end
