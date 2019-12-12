Rails.application.routes.draw do
  root to: 'pages#home'
  resources :events, only: [:new, :create, :update]
  resources :users, only: [:new, :create]

  get '/share', to: 'events#share'
  get 'howitworks', to: 'pages#howitworks'
  get 'confirmation', to: 'pages#confirmation'
  get '/waiting', to: 'pages#waiting'
  get 'events/:event_token', to: 'events#join'
  get 'events/:event_token/users/new', to: 'users#new', as: 'new_user'
  post 'events/:event_token/users/create', to: 'users#create', as: 'create_user'
end
