Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  resources :wikis

  resources :collaborators

  patch 'users/downgrade', to: 'users#downgrade', as: 'user_downgrade'
  patch 'users/regrade', to: 'users#regrade', as: 'user_regrade'
  
  patch 'users/upgrade', to: 'users#update', as: 'user_upgrade'
  get 'users/upgradev'
  
end
