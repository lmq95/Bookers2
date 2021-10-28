Rails.application.routes.draw do
  root to: 'homes#top'
  get '/home/about' => 'homes#about', as: 'about'
  devise_for :users
  post '/users/:id' => 'users#create'
  
  resources :users, only: [:index, :create, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end  
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
 end
