Rails.application.routes.draw do
  resources :users
  resources :sessions,   only: [:new, :create, :destroy]
  resources :lists
  resources :items

  get   '/signup',  to: 'users#new'
  get   '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root  :to => 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
end
