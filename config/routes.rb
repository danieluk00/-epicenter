Rails.application.routes.draw do
  root to: 'pages#home'
  get '/share', to: 'pages#share'
  get 'howitworks', to: 'pages#howitworks'
  resources :booking, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
