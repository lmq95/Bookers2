Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  post '/users/:id' => 'users#create'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books
end
