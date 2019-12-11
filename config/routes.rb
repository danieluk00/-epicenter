Rails.application.routes.draw do
  root to: 'pages#home'
  resources :events, only: [:new, :create]
  resources :users, only: [:new, :create]

  get '/share', to: 'pages#share'
  get 'howitworks', to: 'pages#howitworks'
  get 'confirmation', to: 'pages#confirmation'
  get '/waiting', to: 'pages#waiting'
  get '/:event_token', to: 'pages#join'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
