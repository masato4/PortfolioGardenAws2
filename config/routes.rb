Rails.application.routes.draw do
  get 'notifications/index'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # マイページのルーティング
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  # トップページのルーティング
  #root to: 'home#top'


  #resources :users, only: [:index, :show, :edit, :update]
  resources :messages, :only => [:create,:destroy]
  resources :rooms, :only => [:create, :show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'hello#index' => 'hello#index'
  root 'hello#index'
  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'


  # get 'tweets' => 'tweets#index'
  # get 'tweets/new' => 'tweets#new'
  # post 'tweets' => 'tweets#create'
  # get 'tweets/:id' => 'tweets#show',as: 'tweet'
  # patch 'tweets/:id'=> 'tweets#update'
  # delete 'tweets/:id' => 'tweets#destroy'
  # get 'tweets/:id/edit' => 'tweets#edit' , as:'edit_tweet'

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]





  resources :users do
    resource :relationships, only: [:create, :destroy,:edit,:update]
    get :followings, on: :member
    get :followers, on: :member

    member do
      get :likes
    end

  end

  #resource :skills
  get 'skills' => 'skills#index'
  get 'skills/new' => 'skills#new'
  post 'skills' => 'skills#create'
  get 'skills/:id' => 'skills#show',as: 'skill'
  patch 'skills/:id'=> 'skills#update'
  put 'skills/:id'=> 'skills#update'
  delete 'skills/:id' => 'skills#destroy'
  get 'skills/:id/edit' => 'skills#edit' , as:'edit_skill'

  # devise_for :users, controllers: {
  # sessions: "users/sessions",
  #     registrations: "users/registrations"
  #   }

  resources :notifications, only: [:index,:update]

end
