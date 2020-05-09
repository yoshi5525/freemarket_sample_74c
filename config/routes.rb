Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:new] do
    collection do
      get "new_address"
      get "create_address"
      get 'items/show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'items#index'
  resources :items
  resources :users, only: [:show, :destroy] do
    resources :cards, only: :new
  end
end
