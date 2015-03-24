Rails.application.routes.draw do
  resources :memories do
    resources :comments
  end
  devise_for :users

  root 'thundrs#index'
end
