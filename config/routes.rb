Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items do
    collection do
    get 'confirm'
    end
    member do
      get "buy"
      get "pay"
    end
    resources :images, only: [:new, :create] 
  end
  
  resources :cards, only: [:new, :create, :destroy, :show]
  
  resources :users, only: [:new, :show] do
    collection do
      get "user_logout"
    end
  end
end
