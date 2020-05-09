Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items
  resources :users, only: [:show, :destroy] do
    resources :cards, only: :new
  end
end
