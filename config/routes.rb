Rails.application.routes.draw do
  root to: 'users#show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  resources :users, only: [:index, :show, :create] do
    resources :gists, only: [:index, :show, :new, :create, :destroy]
  end
end
