Rails.application.routes.draw do

  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users
  resources :tweets

  get 'home/top'
  root 'home#top'

  get '/about' => 'home#about'
end