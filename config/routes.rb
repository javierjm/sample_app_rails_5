Rails.application.routes.draw do
  get 'sessions/new'

  # get 'users/new', as: 'signup'
  # same result as -- Not working when exists resources :users
  get '/signup', to: 'users#new'
  post '/signup', to:'users#create'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
