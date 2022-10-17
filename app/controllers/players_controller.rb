class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show ]
  skip_before_action :verify_authenticity_token

  # GET /players/1 or /players/1.json
  def login
    player = Player.where(email: params[:email], password: params[:password]).first

    if player.present?
      render json: player
    else
      render json: {status: 'Login fallido'}
    end
  end

  def new
    if params[:name].present? && params[:email].present? && params[:password].present?
      new_player = Player.create!(name: params[:name], email: params[:email], password: params[:password])
      render json: new_player
    end
  end

  # Patch update
  def update
      player = Player.find(params[:id])

      player.update_attribute(:name, params[:name]) if params[:name].present?
      player.update_attribute(:email, params[:email]) if params[:email].present?
      player.update_attribute(:password, params[:password]) if params[:password].present?
      player.update_attribute(:n_win_games, params[:n_win_games]) if params[:n_win_games].present?
      player.update_attribute(:n_lose_games, params[:n_lose_games]) if params[:n_lose_games].present?
      player.update_attribute(:n_played_games, params[:n_played_games]) if params[:n_played_games].present?
      player.update_attribute(:n_bonifications, params[:n_bonifications]) if params[:n_bonifications].present?
      player.update_attribute(:n_effectiveness, params[:n_effectiveness]) if params[:n_effectiveness].present?
      player.update_attribute(:turns_mean_of_games, params[:turns_mean_of_games]) if params[:turns_mean_of_games].present?
      player.update_attribute(:mean_of_misses_by_game, params[:mean_of_misses_by_game]) if params[:mean_of_misses_by_game].present?

      render json: player
  end 

  def show
    if params[:id].present?
      player = Player.find(params[:id])
      render json: player
    end
  end
  
  def new_friend_request
    if params[:player_email].present? && params[:friend_email].present?
      player = Player.find_by(email: params[:player_email])
      friend_player = Player.find_by(email: params[:friend_email])
      friend = Friend.find_by(player: friend_player)
      new_friend_request = FriendRequest.create!(player: player, friend: friend, status: "pending")
      render json: new_friend_request
    end
  end

  def respond_friend_request
    if params[:status].present? && params[:friend_request_id].present?
      friend_request = FriendRequest.find_by(id: params[:friend_request_id])
      action_response = friend_request.update(status: params[:status])
      render json: action_response
    end
  end

  # GET Friends 
  def get_friends
    player = Player.find_by(id: params[:id])
    player_friend = Friend.find_by(player: player)
    sended_friend_requests = FriendRequest.where(player: player, status: params[:status])
    received_friend_requests = FriendRequest.where(friend: player_friend, status: params[:status])

    friends = []

    sended_friend_requests.each do |f|
      friends << f.friend.player
    end

    received_friend_requests.each do |f|
      friends << f.player
    end

    render json: friends
  end

  def index
    players = Player.all
    render json: players
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :password, :email, :auth_key, :n_win_games, :n_lose_games, :n_played_games, :n_bonifications, :n_effectiveness, :turns_mean_of_games, :mean_of_misses_by_game)
    end
end
