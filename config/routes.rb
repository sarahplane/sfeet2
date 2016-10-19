Rails.application.routes.draw do
  devise_for :users
  resources :products do
    resources :reviews, only: [:create]
  end
  resources :tags, only: [:show, :destroy]
  resources :categories

  controller :pages do
    get :home
    get :about
    get :faq
  end

  root 'pages#home'
end
