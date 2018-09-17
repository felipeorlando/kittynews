Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  resources :posts, only: %(show) do
    resources :comments, only: %(index)
  end
end