Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  resources :wikis

  resources :users, only: [:update]

  get 'users/upgrade', to: 'users#upgrade', as: 'user_upgrade'

  
end
