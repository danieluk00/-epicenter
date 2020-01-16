Rails.application.routes.draw do
  root to: 'pages#home'
  resources :events, only: [:new, :create, :update]

  get '/share', to: 'events#share'
  get 'howitworks', to: 'pages#howitworks'
  get 'confirmation', to: 'pages#confirmation', as: :confirmation
  get '/waiting', to: 'pages#waiting'
  get '/optimising', to: 'pages#optimising'
  get 'events/:event_token', to: 'events#join'
  get '/cancelation', to: "pages#cancelation"
  get 'events/:event_token/users/new', to: 'users#new', as: 'new_user'
  post 'events/:event_token/users/create', to: 'users#create', as: 'create_user'
  post 'events/:event_token/', to: 'events#endwaiting', as: 'endwaiting'
  post 'spinagain/:event_token/', to: 'events#spinagain', as: 'spinagain'
  get 'events/:event_token/refreshusers', to: 'events#refresh_users'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
    mount Sidekiq::Web => '/sidekiq'
end
