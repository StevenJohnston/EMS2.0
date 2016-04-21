Rails.application.routes.draw do
  resources :time_cards
  resources :full_time_employees
  resources :employees
  resources :companies



  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users
  get 'page/index'
  root 'sessions#new'
end
