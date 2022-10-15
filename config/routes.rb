Rails.application.routes.draw do
  root 'welcome#index'

  get 'players/index', to: "players#index"
end
