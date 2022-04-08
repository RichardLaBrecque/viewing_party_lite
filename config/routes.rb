# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/discover', to: 'users#discover'
  post '/movies', to: 'movies#index'
  get '/dashboard', to: 'users#show'
  resources :users do
    resources :movies, only: [:index, :show]
    resources :viewing_parties, only: [:new, :index, :show]
  end
    post '/users/:user_id/viewing_parties/new', to: 'viewing_parties#create'

end
