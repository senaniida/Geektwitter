Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  post 'tweets/touser' => 'tweets#touser'
  root 'hello#index'
  
  # get 'tweets' => 'tweets#index'
  # get 'tweets/new' => 'tweets#new'
  # post 'tweets' => 'tweets#create'
  # get 'tweets/:id' => 'tweets#show' ,as: 'tweet'
  # patch 'tweets/:id' => 'tweets#update'
  # put 'tweets/:id' => 'tweets#update'
  # delete 'tweets/:id' => 'tweets#destroy'
  # get 'tweets/:id/edit' => 'tweets#edit', as:'edit_tweet'

  get 'tweets/scraping' => 'tweets#scraping'
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
    resources :keeps, only: [:create, :destroy]
  end
  resources :rooms
  #get 'rooms' => 'rooms#index'
  resources :relationships, only: [:create, :destroy]
end

