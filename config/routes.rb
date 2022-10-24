Rails.application.routes.draw do
  root 'welcome#index'

  get 'players', to: "players#index"
  get 'rooms', to: "games#get_all_roomsget_all_rooms"


  get 'player/:id', to: "players#show"
  post 'players/login', to: 'players#login'
  post 'players/:id/friends', to: 'players#get_friends'

  post 'player/new', to: 'players#new'
  patch 'player/:id/update', to: 'players#update'
  post 'friend_request/new', to: 'players#new_friend_request'
  post 'friend_request/response', to: 'players#respond_friend_request'


  post 'player/:player_id/rooms', to: 'games#get_rooms'
  post 'player/new_room', to: 'games#create_new_room'
  post 'room/new_player', to: 'games#add_new_player'
  get 'room/:room_id/players', to: 'games#get_room_players'
  post 'room/:room_id/response', to: 'games#respond_invitation'

  post "new_game", to: 'games#new_game'
  post 'room/:room_id/game/turn', to: 'games#post_new_turn'
  post 'get_board_state', to: 'games#get_board_state'

  get "room/:room_id/game_state", to: 'games#get_game_state'
end
