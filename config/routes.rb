Rails.application.routes.draw do

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items do
    collection do
    get 'confirm'
    end
    # resources :images, only: [ :new, :create] 
  end

  resources :users, only: [:new, :show, :destroy] do
    resources :cards, only: [:new]
    collection do
      get "new_address"
      get "create_address"
      get "user_logout"
    end
  end
end
