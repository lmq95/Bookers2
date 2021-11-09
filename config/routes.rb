Rails.application.routes.draw do
  root to: 'homes#top'
  get '/home/about' => 'homes#about', as: 'about'
  devise_for :users

  get 'search' => "searches#search", as: "search"

  resources :users, only: [:index, :create, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :groups do
    get 'join' => "groups#join", as: 'join'
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

 end
