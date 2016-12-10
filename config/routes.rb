Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :products do
    resources :reviews, only: [:create]
  end
  resources :tags, only: [:show, :edit, :update, :destroy]
  resources :categories

  controller :pages do
    get :home
    get :about
    get :faq
  end

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy]
      # resources :categories, only: [:index, :show, :create, :update, :destroy]
      # resources :tags, only: [:index, :show, :create, :update, :destroy]
      # resources :reviews, only: [:create]
    end
  end

  root 'pages#home'
end
