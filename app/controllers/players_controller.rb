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

  def new_friend_request
    binding.pry
    if params[:player_email].present? && params[:friend_email].present?
      player = Player.find_by(email: params[:player_email])
      friend_player = Player.find_by(email: params[:friend_email])
      friend = Friend.find_by(player: friend_player)
      new_friend_request = FriendRequest.create!(player: player, friend: friend, status: "pending")
      render json: new_friend_request
    end
  end

  # GET Friends 
  def get_friends
    friends = Player.where(id: params[:id]).first.friend_requests.where(status: params[:status])

    friends_ids = []

    friends.each do |f|
      friends_ids << f.friend.id
    end

    friends = Player.where(id: friends_ids)


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
