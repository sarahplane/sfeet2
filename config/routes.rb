Rails.application.routes.draw do
  devise_for :users
  resources :products

  controller :pages do
    get :home
    get :about
    get :faq
    get :help_center
    get :news
    get :black_list
  end

  root 'pages#home'
end
