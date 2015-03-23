Rails.application.routes.draw do
  devise_for :users
  root 'thundrs#index'
end
