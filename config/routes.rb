Rails.application.routes.draw do
  root 'welcome#index'

  get 'players', to: "players#index"
  post 'players/login', to: 'players#login'
  get 'players/:id/friends', to: 'players#get_friends'
end
