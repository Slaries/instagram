Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  root 'pages#home'

  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:show, :new, :create, :index, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
