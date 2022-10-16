Rails.application.routes.draw do
  root 'welcome#index'

  get 'players', to: "players#index"

  get 'player/:id', to: "players#show"
  post 'players/login', to: 'players#login'
  post 'players/:id/friends', to: 'players#get_friends'

  post 'player/new', to: 'players#new'
  patch 'player/:id/update', to: 'players#update'
end
