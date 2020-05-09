Rails.application.routes.draw do

　root 'items#index'
  get 'items/show', to: 'items#show'

end