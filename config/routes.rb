Rails.application.routes.draw do
  root 'welcome#index'

  get 'players', to: "players#index"
end
