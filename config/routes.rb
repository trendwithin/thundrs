Rails.application.routes.draw do
  resources :memories
  devise_for :users
  root 'thundrs#index'
end
