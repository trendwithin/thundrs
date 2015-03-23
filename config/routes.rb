Rails.application.routes.draw do
  resources :comments
  resources :memories
  devise_for :users
  root 'thundrs#index'
end
