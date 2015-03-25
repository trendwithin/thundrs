Rails.application.routes.draw do
  resources :memories do
    resources :comments
  end
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks"}

  root 'thundrs#index'
end
