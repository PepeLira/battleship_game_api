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

  # GET Friends 
  def get_friends
    friends = Player.where(id: params[:id]).first.friend_requests.where(status: params[:status])
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
